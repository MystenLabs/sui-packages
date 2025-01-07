module 0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::price_oracle {
    struct ORACLE_ADMIN has drop {
        dummy_field: bool,
    }

    struct PriceUpdated has copy, drop {
        price: u64,
        setter: address,
    }

    struct PriceOracle has store, key {
        id: 0x2::object::UID,
        stale: 0x1::option::Option<u64>,
        admin_price: 0x1::option::Option<u64>,
        last_updated: 0x1::option::Option<u64>,
    }

    public fun create_oracle(arg0: &0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::admin::OwnerCap<ORACLE_ADMIN>, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) : PriceOracle {
        PriceOracle{
            id           : 0x2::object::new(arg2),
            stale        : arg1,
            admin_price  : 0x1::option::none<u64>(),
            last_updated : 0x1::option::none<u64>(),
        }
    }

    public fun destroy_oracle(arg0: PriceOracle) {
        let PriceOracle {
            id           : v0,
            stale        : _,
            admin_price  : _,
            last_updated : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_oracle_price(arg0: &PriceOracle, arg1: &0x2::clock::Clock) : u64 {
        assert!(0x1::option::is_some<u64>(&arg0.admin_price), 0);
        assert!(0x1::option::is_none<u64>(&arg0.stale) || 0x2::clock::timestamp_ms(arg1) - *0x1::option::borrow<u64>(&arg0.last_updated) < *0x1::option::borrow<u64>(&arg0.stale), 1);
        *0x1::option::borrow<u64>(&arg0.admin_price)
    }

    public fun get_oracle_price_unsafe(arg0: &PriceOracle) : u64 {
        assert!(0x1::option::is_some<u64>(&arg0.admin_price), 0);
        *0x1::option::borrow<u64>(&arg0.admin_price)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ORACLE_ADMIN{dummy_field: false};
        let v1 = 0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::admin::create_owner_cap<ORACLE_ADMIN>(v0, arg0);
        0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::admin::transfer_owner_cap<ORACLE_ADMIN>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::admin::OperatorCap<ORACLE_ADMIN>>(0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::admin::create_operator_cap<ORACLE_ADMIN>(&v1, arg0), 0x2::tx_context::sender(arg0));
    }

    public entry fun set_admin_price(arg0: &0x6dbc3ef481229600e2dfca5ea29092262e1c20e290292797fdcc5ce87d10da85::admin::OperatorCap<ORACLE_ADMIN>, arg1: &mut PriceOracle, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::option::swap_or_fill<u64>(&mut arg1.admin_price, arg2);
        0x1::option::swap_or_fill<u64>(&mut arg1.last_updated, 0x2::clock::timestamp_ms(arg3));
        let v0 = PriceUpdated{
            price  : arg2,
            setter : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

