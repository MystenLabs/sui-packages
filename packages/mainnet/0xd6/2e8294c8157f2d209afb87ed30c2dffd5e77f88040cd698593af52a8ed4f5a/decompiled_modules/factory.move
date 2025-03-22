module 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::factory {
    struct Factory has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::string::String, address>,
        pool_list: vector<0x1::string::String>,
        default_fee_percent: u64,
        owner: address,
    }

    struct FactoryCreatedEvent has copy, drop {
        factory_id: address,
        owner: address,
        default_fee_percent: u64,
    }

    struct PoolCreatedByFactoryEvent has copy, drop {
        factory_id: address,
        pool_id: address,
        pool_key: 0x1::string::String,
        coin_x_type: 0x1::string::String,
        coin_y_type: 0x1::string::String,
    }

    public fun create_factory(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 500, 3);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = Factory{
            id                  : v0,
            pools               : 0x2::table::new<0x1::string::String, address>(arg1),
            pool_list           : 0x1::vector::empty<0x1::string::String>(),
            default_fee_percent : arg0,
            owner               : v1,
        };
        let v3 = FactoryCreatedEvent{
            factory_id          : 0x2::object::uid_to_address(&v0),
            owner               : v1,
            default_fee_percent : arg0,
        };
        0x2::event::emit<FactoryCreatedEvent>(v3);
        0x2::transfer::share_object<Factory>(v2);
    }

    public fun create_pool<T0, T1>(arg0: &mut Factory, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        assert!(!is_same_type<T0, T1>(), 4);
        assert!(arg3 <= 500, 3);
        let v0 = get_pool_key<T0, T1>();
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.pools, v0), 1);
        let v1 = 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::create_pool<T0, T1>(arg1, arg2, arg3, arg4);
        let v2 = 0x2::object::uid_to_address(0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::get_pool_id<T0, T1>(&v1));
        0x2::table::add<0x1::string::String, address>(&mut arg0.pools, v0, v2);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.pool_list, v0);
        let v3 = PoolCreatedByFactoryEvent{
            factory_id  : 0x2::object::uid_to_address(&arg0.id),
            pool_id     : v2,
            pool_key    : v0,
            coin_x_type : get_coin_name<T0>(),
            coin_y_type : get_coin_name<T1>(),
        };
        0x2::event::emit<PoolCreatedByFactoryEvent>(v3);
        0x2::transfer::public_share_object<0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::LiquidityPool<T0, T1>>(v1);
    }

    public fun create_pool_with_default_fee<T0, T1>(arg0: &mut Factory, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.default_fee_percent;
        create_pool<T0, T1>(arg0, arg1, arg2, v0, arg3);
    }

    public fun get_all_pool_keys(arg0: &Factory) : &vector<0x1::string::String> {
        &arg0.pool_list
    }

    fun get_coin_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun get_default_fee_percent(arg0: &Factory) : u64 {
        arg0.default_fee_percent
    }

    public fun get_owner(arg0: &Factory) : address {
        arg0.owner
    }

    public fun get_pool_address<T0, T1>(arg0: &Factory) : address {
        let v0 = get_pool_key<T0, T1>();
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.pools, v0), 2);
        *0x2::table::borrow<0x1::string::String, address>(&arg0.pools, v0)
    }

    public fun get_pool_count(arg0: &Factory) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.pool_list)
    }

    fun get_pool_key<T0, T1>() : 0x1::string::String {
        let v0 = get_coin_name<T0>();
        let v1 = get_coin_name<T1>();
        if (string_compare(&v0, &v1) <= 0) {
            let v3 = 0x1::string::utf8(b"");
            0x1::string::append(&mut v3, v0);
            0x1::string::append(&mut v3, 0x1::string::utf8(b":"));
            0x1::string::append(&mut v3, v1);
            v3
        } else {
            let v4 = 0x1::string::utf8(b"");
            0x1::string::append(&mut v4, v1);
            0x1::string::append(&mut v4, 0x1::string::utf8(b":"));
            0x1::string::append(&mut v4, v0);
            v4
        }
    }

    fun is_same_type<T0, T1>() : bool {
        get_coin_name<T0>() == get_coin_name<T1>()
    }

    fun string_compare(arg0: &0x1::string::String, arg1: &0x1::string::String) : u8 {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::string::as_bytes(arg1);
        let v2 = 0x1::vector::length<u8>(v0);
        let v3 = 0x1::vector::length<u8>(v1);
        let v4 = 0;
        let v5 = if (v2 < v3) {
            v2
        } else {
            v3
        };
        while (v4 < v5) {
            let v6 = *0x1::vector::borrow<u8>(v0, v4);
            let v7 = *0x1::vector::borrow<u8>(v1, v4);
            if (v6 < v7) {
                return 0
            };
            if (v6 > v7) {
                return 2
            };
            v4 = v4 + 1;
        };
        if (v2 < v3) {
            0
        } else if (v2 > v3) {
            2
        } else {
            1
        }
    }

    public fun transfer_ownership(arg0: &mut Factory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.owner = arg1;
    }

    public fun update_default_fee_percent(arg0: &mut Factory, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg1 <= 500, 3);
        arg0.default_fee_percent = arg1;
    }

    // decompiled from Move bytecode v6
}

