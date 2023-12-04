package org.iesvdm.jardineria.modelo;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import java.lang.reflect.ParameterizedType;
import java.util.List;

public class AbstractHome<T> {


    protected final SessionFactory sessionFactory = getSessionFactory();

    protected SessionFactory getSessionFactory() {
        try {
            return new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalStateException("No puedo crear SessionFactory");
        }
    }

    public void beginTransaction() {
        sessionFactory.getCurrentSession().beginTransaction();
    }

    public void commitTransaction() {
        sessionFactory.getCurrentSession().getTransaction().commit();
    }

    public void rollbackTransaction() {
        sessionFactory.getCurrentSession().getTransaction().rollback();
    }

    public List<T> findAll() {
        List<T> lst= null;

        lst = sessionFactory.getCurrentSession().createQuery("SELECT x FROM "+ reflectClassType().getSimpleName()+" x", reflectClassType())
                .getResultList();

        return lst;
    }

    @SuppressWarnings("unchecked")
    public Class reflectClassType() {
        return ((Class) ((ParameterizedType) getClass()
                .getGenericSuperclass()).getActualTypeArguments()[0]);
    }
}
