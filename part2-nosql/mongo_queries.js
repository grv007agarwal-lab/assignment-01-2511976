// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    _id: "ELEC1001",
    name: "Samsung 55-inch 4K Smart TV",
    category: "Electronics",
    brand: "Samsung",
    price: 64999,
    currency: "INR",
    stock: 25,
    specifications: {
      screen_size: "55 inches",
      resolution: "3840x2160",
      display_type: "LED",
      smart_tv: true,
      operating_system: "Tizen",
      ports: [
        { type: "HDMI", count: 3 },
        { type: "USB", count: 2 }
      ],
      voltage: "220-240V"
    },
    warranty: {
      period: "2 years",
      type: "Manufacturer",
      covered_components: ["Panel", "Motherboard", "Power Supply"]
    }
  },
  {
    _id: "CLOT2001",
    name: "Men's Slim Fit Casual Shirt",
    category: "Clothing",
    brand: "Levi's",
    price: 1999,
    currency: "INR",
    stock: 100,
    attributes: {
      material: "Cotton",
      fit: "Slim Fit",
      pattern: "Solid",
      sleeve_type: "Full Sleeve",
      gender: "Men"
    },
    sizes_available: ["S", "M", "L", "XL"]
  },
  {
    _id: "GROC3001",
    name: "Amul Butter 500g",
    category: "Groceries",
    brand: "Amul",
    price: 275,
    currency: "INR",
    stock: 200,
    perishable: true,
    expiry: {
      manufacture_date: new Date("2026-03-01"),
      expiry_date: new Date("2026-06-01")
    },
    ingredients: ["Milk Fat", "Common Salt"]
  }
]);


// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});


// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  "expiry.expiry_date": { $lt: new Date("2025-01-01") }
});


// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { _id: "ELEC1001" },
  { $set: { discount_percent: 10 } }
);


// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });

// Explanation:
// Creating an index on the "category" field improves query performance for
// frequent lookups such as filtering products by category (e.g., Electronics,
// Clothing, Groceries). It reduces full collection scans and speeds up read operations.