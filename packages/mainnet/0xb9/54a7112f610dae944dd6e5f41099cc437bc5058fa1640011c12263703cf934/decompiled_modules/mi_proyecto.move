module 0xb954a7112f610dae944dd6e5f41099cc437bc5058fa1640011c12263703cf934::mi_proyecto {
    struct Shop has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        products: 0x2::vec_map::VecMap<u64, Product>,
    }

    struct Product has drop, store {
        name: 0x1::string::String,
        expiration: u64,
        amount: u16,
        available: bool,
    }

    public fun add_product(arg0: &mut Shop, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: u16) {
        assert!(!0x2::vec_map::contains<u64, Product>(&arg0.products, &arg1), 13906834354732007425);
        let v0 = Product{
            name       : arg2,
            expiration : arg3,
            amount     : arg4,
            available  : true,
        };
        0x2::vec_map::insert<u64, Product>(&mut arg0.products, arg1, v0);
    }

    public fun create_Shop(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Shop{
            id       : 0x2::object::new(arg1),
            name     : arg0,
            products : 0x2::vec_map::empty<u64, Product>(),
        };
        0x2::transfer::transfer<Shop>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun delete_product(arg0: &mut Shop, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Product>(&arg0.products, &arg1), 13906834384796909571);
        let (_, _) = 0x2::vec_map::remove<u64, Product>(&mut arg0.products, &arg1);
    }

    public fun increase_quantity(arg0: &mut Shop, arg1: u64, arg2: u16) {
        assert!(0x2::vec_map::contains<u64, Product>(&arg0.products, &arg1), 13906834410566713347);
        let v0 = 0x2::vec_map::get_mut<u64, Product>(&mut arg0.products, &arg1);
        v0.amount = v0.amount + arg2;
    }

    public fun subtract_amount(arg0: &mut Shop, arg1: u64, arg2: u16) {
        assert!(0x2::vec_map::contains<u64, Product>(&arg0.products, &arg1), 13906834449221419011);
        let v0 = 0x2::vec_map::get_mut<u64, Product>(&mut arg0.products, &arg1);
        assert!(v0.available, 13906834462106451973);
        assert!(v0.amount >= arg2, 13906834466401550343);
        v0.amount = v0.amount - arg2;
        if (v0.amount == 0) {
            v0.available = false;
        };
    }

    // decompiled from Move bytecode v6
}

