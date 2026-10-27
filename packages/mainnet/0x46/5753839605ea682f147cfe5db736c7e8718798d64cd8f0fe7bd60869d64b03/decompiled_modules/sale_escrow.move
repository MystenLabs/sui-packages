module 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::sale_escrow {
    struct EscrowOrder<phantom T0> has key {
        id: 0x2::object::UID,
        ask: u64,
        cut: u64,
        item: 0x2::object::ID,
        maker: address,
        version: u64,
    }

    struct Held has copy, drop, store {
        dummy_field: bool,
    }

    public fun ask<T0>(arg0: &EscrowOrder<T0>) : u64 {
        arg0.ask
    }

    public fun cut<T0>(arg0: &EscrowOrder<T0>) : u64 {
        arg0.cut
    }

    public fun item<T0>(arg0: &EscrowOrder<T0>) : 0x2::object::ID {
        arg0.item
    }

    public fun maker<T0>(arg0: &EscrowOrder<T0>) : address {
        arg0.maker
    }

    public fun post<T0: store + key>(arg0: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_open(arg0);
        assert!(arg2 > 0, 201);
        let v0 = 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::portion(arg2, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::listing_bps(arg0));
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = EscrowOrder<T0>{
            id      : 0x2::object::new(arg3),
            ask     : arg2,
            cut     : v0,
            item    : v1,
            maker   : 0x2::tx_context::sender(arg3),
            version : 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::current(),
        };
        let v3 = Held{dummy_field: false};
        0x2::dynamic_object_field::add<Held, T0>(&mut v2.id, v3, arg1);
        let v4 = 0x2::object::id<EscrowOrder<T0>>(&v2);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::escrow_posted(v4, v1, 0x1::type_name::with_defining_ids<T0>(), arg2, v0, v2.maker);
        0x2::transfer::share_object<EscrowOrder<T0>>(v2);
        v4
    }

    public fun pull<T0: store + key>(arg0: EscrowOrder<T0>, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::tx_context::sender(arg1) == arg0.maker, 202);
        let EscrowOrder {
            id      : v0,
            ask     : v1,
            cut     : _,
            item    : v3,
            maker   : v4,
            version : _,
        } = arg0;
        let v6 = v0;
        let v7 = Held{dummy_field: false};
        0x2::object::delete(v6);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::escrow_pulled(0x2::object::id<EscrowOrder<T0>>(&arg0), v3, 0x1::type_name::with_defining_ids<T0>(), v1, v4);
        0x2::dynamic_object_field::remove<Held, T0>(&mut v6, v7)
    }

    public fun reprice<T0: store + key>(arg0: &mut EscrowOrder<T0>, arg1: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_open(arg1);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_object(arg0.version);
        assert!(0x2::tx_context::sender(arg3) == arg0.maker, 202);
        assert!(arg2 > 0, 201);
        arg0.ask = arg2;
        arg0.cut = 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::portion(arg2, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::listing_bps(arg1));
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::escrow_repriced(0x2::object::id<EscrowOrder<T0>>(arg0), arg0.item, 0x1::type_name::with_defining_ids<T0>(), arg2, arg0.cut, arg0.maker);
    }

    public fun take<T0: store + key>(arg0: EscrowOrder<T0>, arg1: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_open(arg1);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_object(arg0.version);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg0.ask, 203);
        let EscrowOrder {
            id      : v0,
            ask     : v1,
            cut     : v2,
            item    : v3,
            maker   : v4,
            version : _,
        } = arg0;
        let v6 = v0;
        let v7 = Held{dummy_field: false};
        0x2::object::delete(v6);
        let v8 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), v1);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(0x2::balance::split<0x2::sui::SUI>(&mut v8, v2), 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::treasury(arg1), arg3);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(v8, v4, arg3);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::escrow_taken(0x2::object::id<EscrowOrder<T0>>(&arg0), v3, 0x1::type_name::with_defining_ids<T0>(), v1, v2, v4, 0x2::tx_context::sender(arg3));
        0x2::dynamic_object_field::remove<Held, T0>(&mut v6, v7)
    }

    // decompiled from Move bytecode v7
}

