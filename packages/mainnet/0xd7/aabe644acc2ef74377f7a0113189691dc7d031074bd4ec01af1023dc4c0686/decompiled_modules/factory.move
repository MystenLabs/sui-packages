module 0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::factory {
    struct Factory has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<PairKey, address>,
        fee_collector: address,
        total_fees_collected: u64,
        pool_count: u64,
        creation_fee: u64,
    }

    struct PairKey has copy, drop, store {
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolCreated has copy, drop {
        pool_id: address,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        creator: address,
        fee_paid: u64,
        pool_number: u64,
    }

    struct FeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    fun compare_vectors(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 < v5) {
                return true
            };
            if (v4 > v5) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    public fun create_pool<T0, T1>(arg0: &mut Factory, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.creation_fee, 0);
        let v0 = get_pair_key<T0, T1>();
        assert!(!0x2::table::contains<PairKey, address>(&arg0.pools, v0), 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        arg0.total_fees_collected = arg0.total_fees_collected + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.fee_collector);
        let (v2, v3) = 0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::pool::create_pool<T0, T1>(arg2, arg3, arg0.fee_collector, arg4, arg5);
        let v4 = v2;
        let v5 = 0x2::object::id_address<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::pool::Pool<T0, T1>>(&v4);
        0x2::table::add<PairKey, address>(&mut arg0.pools, v0, v5);
        arg0.pool_count = arg0.pool_count + 1;
        0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::pool::share_pool<T0, T1>(v4);
        let v6 = PoolCreated{
            pool_id     : v5,
            coin_a      : v0.coin_a,
            coin_b      : v0.coin_b,
            creator     : 0x2::tx_context::sender(arg5),
            fee_paid    : v1,
            pool_number : arg0.pool_count,
        };
        0x2::event::emit<PoolCreated>(v6);
        v3
    }

    public fun fee_collector(arg0: &Factory) : address {
        arg0.fee_collector
    }

    public fun get_creation_fee(arg0: &Factory) : u64 {
        arg0.creation_fee
    }

    fun get_pair_key<T0, T1>() : PairKey {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        if (is_sorted(v0, v1)) {
            PairKey{coin_a: v0, coin_b: v1}
        } else {
            PairKey{coin_a: v1, coin_b: v0}
        }
    }

    public fun get_pool<T0, T1>(arg0: &Factory) : 0x1::option::Option<address> {
        let v0 = get_pair_key<T0, T1>();
        if (0x2::table::contains<PairKey, address>(&arg0.pools, v0)) {
            0x1::option::some<address>(*0x2::table::borrow<PairKey, address>(&arg0.pools, v0))
        } else {
            0x1::option::none<address>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id                   : 0x2::object::new(arg0),
            pools                : 0x2::table::new<PairKey, address>(arg0),
            fee_collector        : 0x2::tx_context::sender(arg0),
            total_fees_collected : 0,
            pool_count           : 0,
            creation_fee         : 3000000000,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Factory>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_sorted(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) : bool {
        compare_vectors(0x1::ascii::as_bytes(0x1::type_name::borrow_string(&arg0)), 0x1::ascii::as_bytes(0x1::type_name::borrow_string(&arg1)))
    }

    public fun pool_count(arg0: &Factory) : u64 {
        arg0.pool_count
    }

    public fun pool_exists<T0, T1>(arg0: &Factory) : bool {
        0x2::table::contains<PairKey, address>(&arg0.pools, get_pair_key<T0, T1>())
    }

    public fun total_fees_collected(arg0: &Factory) : u64 {
        arg0.total_fees_collected
    }

    public entry fun update_creation_fee(arg0: &AdminCap, arg1: &mut Factory, arg2: u64) {
        arg1.creation_fee = arg2;
        let v0 = FeeUpdated{
            old_fee : arg1.creation_fee,
            new_fee : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public entry fun update_fee_collector(arg0: &AdminCap, arg1: &mut Factory, arg2: address) {
        arg1.fee_collector = arg2;
    }

    // decompiled from Move bytecode v6
}

