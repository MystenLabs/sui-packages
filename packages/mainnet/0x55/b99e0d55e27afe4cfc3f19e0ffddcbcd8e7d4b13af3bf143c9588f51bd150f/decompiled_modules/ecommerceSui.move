module 0x55b99e0d55e27afe4cfc3f19e0ffddcbcd8e7d4b13af3bf143c9588f51bd150f::ecommerceSui {
    struct Ecommerce has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        products: 0x2::vec_map::VecMap<u64, Product>,
    }

    struct Product has drop, store {
        name: 0x1::string::String,
        available: bool,
        stock: u64,
    }

    public fun addProduct(arg0: &mut Ecommerce, arg1: u64, arg2: 0x1::string::String) {
        assert!(!0x2::vec_map::contains<u64, Product>(&arg0.products, &arg1), 13906834350437040129);
        let v0 = Product{
            name      : arg2,
            available : true,
            stock     : 5,
        };
        0x2::vec_map::insert<u64, Product>(&mut arg0.products, arg1, v0);
    }

    public fun createEcommerce(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Ecommerce{
            id       : 0x2::object::new(arg0),
            name     : 0x1::string::utf8(b"Ecommerce Bolivia"),
            products : 0x2::vec_map::empty<u64, Product>(),
        };
        0x2::transfer::transfer<Ecommerce>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun decreaseStock(arg0: &mut Ecommerce, arg1: u64, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, Product>(&arg0.products, &arg1), 13906834492171091971);
        let v0 = 0x2::vec_map::get_mut<u64, Product>(&mut arg0.products, &arg1);
        assert!(v0.stock >= arg2, 13906834517941026821);
        v0.stock = v0.stock - arg2;
    }

    public fun deleteEcommerce(arg0: Ecommerce) {
        let Ecommerce {
            id       : v0,
            name     : _,
            products : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun deleteProduct(arg0: &mut Ecommerce, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Product>(&arg0.products, &arg1), 13906834457811353603);
        let (_, _) = 0x2::vec_map::remove<u64, Product>(&mut arg0.products, &arg1);
    }

    public fun modifyAvailableProduct(arg0: &mut Ecommerce, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Product>(&arg0.products, &arg1), 13906834410566713347);
        0x2::vec_map::get_mut<u64, Product>(&mut arg0.products, &arg1).available = false;
    }

    // decompiled from Move bytecode v6
}

