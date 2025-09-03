module 0x7f3cbc687502e20b3c258e01bdc49eb87aec90f526c3e7c59a8e3e83a48cc6df::warehouse_tracking {
    struct Warehouse has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        products: 0x2::vec_map::VecMap<u16, Product>,
    }

    struct Product has drop, store {
        id: u16,
        name: 0x1::string::String,
        description: 0x1::string::String,
        stock: u8,
        price: u16,
    }

    public fun addProductToWarehouse(arg0: &mut Warehouse, arg1: u16, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u16) {
        assert!(!0x2::vec_map::contains<u16, Product>(&arg0.products, &arg1), 13906834367616909313);
        let v0 = Product{
            id          : arg1,
            name        : arg2,
            description : arg3,
            stock       : arg4,
            price       : arg5,
        };
        0x2::vec_map::insert<u16, Product>(&mut arg0.products, arg1, v0);
    }

    public fun createWarehouse(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Warehouse{
            id       : 0x2::object::new(arg1),
            name     : arg0,
            products : 0x2::vec_map::empty<u16, Product>(),
        };
        0x2::transfer::transfer<Warehouse>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun deleteProduct(arg0: &mut Warehouse, arg1: u16) : (u16, Product) {
        assert!(!0x2::vec_map::contains<u16, Product>(&arg0.products, &arg1), 13906834539415863301);
        0x2::vec_map::remove<u16, Product>(&mut arg0.products, &arg1)
    }

    public fun getProductInfo(arg0: &mut Warehouse, arg1: u16) : Product {
        assert!(!0x2::vec_map::contains<u16, Product>(&arg0.products, &arg1), 13906834483581288453);
        let v0 = 0x2::vec_map::get<u16, Product>(&arg0.products, &arg1);
        Product{
            id          : v0.id,
            name        : v0.name,
            description : v0.description,
            stock       : v0.stock,
            price       : v0.price,
        }
    }

    public fun sellProduct(arg0: &mut Warehouse, arg1: u16, arg2: u8) {
        assert!(!0x2::vec_map::contains<u16, Product>(&arg0.products, &arg1), 13906834427746713605);
        let v0 = 0x2::vec_map::get_mut<u16, Product>(&mut arg0.products, &arg1);
        assert!(v0.stock > arg2, 13906834436336517123);
        v0.stock = v0.stock - arg2;
    }

    public fun supplyProduct(arg0: &mut Warehouse, arg1: u16, arg2: u8) {
        assert!(!0x2::vec_map::contains<u16, Product>(&arg0.products, &arg1), 13906834457811484677);
        let v0 = 0x2::vec_map::get_mut<u16, Product>(&mut arg0.products, &arg1);
        v0.stock = v0.stock + arg2;
    }

    // decompiled from Move bytecode v6
}

