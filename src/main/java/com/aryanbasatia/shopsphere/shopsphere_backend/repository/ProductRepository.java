package com.aryanbasatia.shopsphere.shopsphere_backend.repository;

import com.aryanbasatia.shopsphere.shopsphere_backend.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> { }
