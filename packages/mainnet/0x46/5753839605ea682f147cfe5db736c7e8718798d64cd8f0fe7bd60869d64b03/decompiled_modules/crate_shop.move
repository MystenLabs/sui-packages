module 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::crate_shop {
    struct Shop has key {
        id: 0x2::object::UID,
        prices: vector<u64>,
        open: bool,
        version: u64,
    }

    public fun buy(arg0: &Shop, arg1: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg2: u8, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_open(arg1);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_object(arg0.version);
        assert!(arg0.open, 705);
        assert!((arg2 as u64) < 0x1::vector::length<u64>(&arg0.prices), 701);
        assert!(arg3 > 0, 702);
        let v0 = *0x1::vector::borrow<u64>(&arg0.prices, (arg2 as u64));
        assert!(v0 <= arg4, 703);
        let v1 = v0 * arg3;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg5) >= v1, 704);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg5), v1), 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::treasury(arg1), arg6);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::crate_bought(0x2::tx_context::sender(arg6), arg2, arg3, v0, v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Shop{
            id      : 0x2::object::new(arg0),
            prices  : vector[1000000000, 30000000000, 75000000000, 200000000000],
            open    : true,
            version : 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::current(),
        };
        0x2::transfer::share_object<Shop>(v0);
    }

    public fun is_open(arg0: &Shop) : bool {
        arg0.open
    }

    public fun prices(arg0: &Shop) : vector<u64> {
        arg0.prices
    }

    public fun set_open(arg0: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::ConfigCap, arg1: &mut Shop, arg2: bool) {
        arg1.open = arg2;
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::crate_shop_open(arg2);
    }

    public fun set_price(arg0: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::ConfigCap, arg1: &mut Shop, arg2: u8, arg3: u64) {
        let v0 = (arg2 as u64);
        if (v0 == 0x1::vector::length<u64>(&arg1.prices)) {
            0x1::vector::push_back<u64>(&mut arg1.prices, arg3);
        } else {
            assert!(v0 < 0x1::vector::length<u64>(&arg1.prices), 701);
            *0x1::vector::borrow_mut<u64>(&mut arg1.prices, v0) = arg3;
        };
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::crate_priced(arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

