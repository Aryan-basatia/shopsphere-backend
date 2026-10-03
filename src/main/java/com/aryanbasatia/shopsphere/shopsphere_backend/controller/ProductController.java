package com.aryanbasatia.shopsphere.shopsphere_backend.controller;

import com.aryanbasatia.shopsphere.shopsphere_backend.entity.Product;
import com.aryanbasatia.shopsphere.shopsphere_backend.repository.ProductRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    private final ProductRepository repository;

    public ProductController(ProductRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public List<Product> getAll() {
        return repository.findAll();
    }

    @GetMapping("/{id}")
    public Product getOne(@PathVariable Integer id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + id));
    }

    @PostMapping
    public Product create(@RequestBody Product p) {
        p.setId(null);
        return repository.save(p);
    }

    @PutMapping("/{id}")
    public Product update(@PathVariable Integer id, @RequestBody Product p) {
        Product existingProduct = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + id));

        // Fixed: Use standard setters instead of clone()
        existingProduct.setName(p.getName());
        existingProduct.setPrice(p.getPrice());
        existingProduct.setStock(p.getStock());
        existingProduct.setCategory(p.getCategory());

        return repository.save(existingProduct);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        repository.deleteById(id);
    }
}