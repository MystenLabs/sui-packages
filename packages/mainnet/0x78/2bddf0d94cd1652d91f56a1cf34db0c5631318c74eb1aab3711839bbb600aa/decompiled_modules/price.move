module 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::price {
    struct PriceRegistry has store, key {
        id: 0x2::object::UID,
        prices: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    public fun get_monthly_subscription_price() : u64 {
        2000000000
    }

    public fun get_piname_registration_price(arg0: &0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &0x1::string::String, arg2: bool) : u64 {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg1));
        let v1 = if (arg2) {
            if (v0 == 1) {
                0x1::string::utf8(b"p1_lifetime")
            } else if (v0 == 2) {
                0x1::string::utf8(b"p2_lifetime")
            } else if (v0 == 3) {
                0x1::string::utf8(b"p3_lifetime")
            } else if (v0 == 4) {
                0x1::string::utf8(b"p4_lifetime")
            } else {
                0x1::string::utf8(b"p5_lifetime")
            }
        } else if (v0 == 1) {
            0x1::string::utf8(b"p1_yearly")
        } else if (v0 == 2) {
            0x1::string::utf8(b"p2_yearly")
        } else if (v0 == 3) {
            0x1::string::utf8(b"p3_yearly")
        } else if (v0 == 4) {
            0x1::string::utf8(b"p4_yearly")
        } else {
            0x1::string::utf8(b"p5_yearly")
        };
        get_price(arg0, v1)
    }

    public fun get_price(arg0: &0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: 0x1::string::String) : u64 {
        *0x2::vec_map::get<0x1::string::String, u64>(&0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow<PriceRegistry>(arg0).prices, &arg1)
    }

    public fun get_profile_creation_price() : u64 {
        264159265
    }

    public fun initialize(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceRegistry{
            id     : 0x2::object::new(arg1),
            prices : 0x2::vec_map::empty<0x1::string::String, u64>(),
        };
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<PriceRegistry>(arg0, v0);
        insert_price(arg0, 0x1::string::utf8(b"p1_yearly"), 999 * 1000000000);
        insert_price(arg0, 0x1::string::utf8(b"p2_yearly"), 499 * 1000000000);
        insert_price(arg0, 0x1::string::utf8(b"p3_yearly"), 29 * 1000000000);
        insert_price(arg0, 0x1::string::utf8(b"p4_yearly"), 7 * 1000000000);
        insert_price(arg0, 0x1::string::utf8(b"p5_yearly"), 1 * 1000000000);
        insert_price(arg0, 0x1::string::utf8(b"p1_lifetime"), 2999 * 1000000000);
        insert_price(arg0, 0x1::string::utf8(b"p2_lifetime"), 999 * 1000000000);
        insert_price(arg0, 0x1::string::utf8(b"p3_lifetime"), 99 * 1000000000);
        insert_price(arg0, 0x1::string::utf8(b"p4_lifetime"), 19 * 1000000000);
        insert_price(arg0, 0x1::string::utf8(b"p5_lifetime"), 9 * 1000000000);
    }

    public fun insert_price(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: 0x1::string::String, arg2: u64) {
        let v0 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<PriceRegistry>(arg0);
        if (!0x2::vec_map::contains<0x1::string::String, u64>(&v0.prices, &arg1)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.prices, arg1, arg2);
        };
    }

    public fun validate_payment(arg0: &0x2::coin::Coin<0x2::sui::SUI>, arg1: u64) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= arg1, 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::errors::EInsufficientBalance());
        assert!(arg1 > 0, 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::errors::EInvalidAmount());
    }

    // decompiled from Move bytecode v6
}

