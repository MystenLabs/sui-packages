module 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::blank_coins {
    struct CoinSet<phantom T0> has store {
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        metadata_cap: 0x2::coin_registry::MetadataCap<T0>,
        currency_id: 0x2::object::ID,
        owner: address,
        decimals: u8,
    }

    struct CoinSetKey has copy, drop, store {
        decimals: u8,
        cap_id: 0x2::object::ID,
    }

    struct BlankCoinsRegistry has key {
        id: 0x2::object::UID,
        total_sets: u64,
        sets_by_decimals: vector<u64>,
    }

    struct CoinSetDeposited has copy, drop {
        registry_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        owner: address,
        decimals: u8,
        timestamp: u64,
    }

    struct CoinSetTaken has copy, drop {
        registry_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        taker: address,
        fee_paid: u64,
        owner_paid: address,
        timestamp: u64,
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) : BlankCoinsRegistry {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 <= 18) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        BlankCoinsRegistry{
            id               : 0x2::object::new(arg0),
            total_sets       : 0,
            sets_by_decimals : v0,
        }
    }

    public fun deposit_coin_set<T0>(arg0: &mut BlankCoinsRegistry, arg1: &0x2::coin_registry::Currency<T0>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::MetadataCap<T0>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.total_sets < 100000, 7);
        assert!(arg4 <= 18, 13);
        validate_coin_set_for_registry<T0>(arg1, &arg2);
        let v0 = 0x2::coin_registry::decimals<T0>(arg1);
        assert!(arg4 == v0, 12);
        let v1 = 0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg2);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = CoinSet<T0>{
            treasury_cap : arg2,
            metadata_cap : arg3,
            currency_id  : 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg1),
            owner        : v2,
            decimals     : v0,
        };
        let v4 = CoinSetKey{
            decimals : v0,
            cap_id   : v1,
        };
        0x2::dynamic_field::add<CoinSetKey, CoinSet<T0>>(&mut arg0.id, v4, v3);
        arg0.total_sets = arg0.total_sets + 1;
        let v5 = 0x1::vector::borrow_mut<u64>(&mut arg0.sets_by_decimals, (v0 as u64));
        *v5 = *v5 + 1;
        let v6 = CoinSetDeposited{
            registry_id : 0x2::object::id<BlankCoinsRegistry>(arg0),
            cap_id      : v1,
            owner       : v2,
            decimals    : v0,
            timestamp   : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CoinSetDeposited>(v6);
    }

    public entry fun deposit_coin_set_entry<T0>(arg0: &mut BlankCoinsRegistry, arg1: &0x2::coin_registry::Currency<T0>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::MetadataCap<T0>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        deposit_coin_set<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun get_currency_id<T0>(arg0: &BlankCoinsRegistry, arg1: u8, arg2: 0x2::object::ID) : 0x2::object::ID {
        let v0 = CoinSetKey{
            decimals : arg1,
            cap_id   : arg2,
        };
        0x2::dynamic_field::borrow<CoinSetKey, CoinSet<T0>>(&arg0.id, v0).currency_id
    }

    public fun get_decimals<T0>(arg0: &BlankCoinsRegistry, arg1: u8, arg2: 0x2::object::ID) : u8 {
        let v0 = CoinSetKey{
            decimals : arg1,
            cap_id   : arg2,
        };
        0x2::dynamic_field::borrow<CoinSetKey, CoinSet<T0>>(&arg0.id, v0).decimals
    }

    public fun get_owner<T0>(arg0: &BlankCoinsRegistry, arg1: u8, arg2: 0x2::object::ID) : address {
        let v0 = CoinSetKey{
            decimals : arg1,
            cap_id   : arg2,
        };
        0x2::dynamic_field::borrow<CoinSetKey, CoinSet<T0>>(&arg0.id, v0).owner
    }

    public fun has_coin_set(arg0: &BlankCoinsRegistry, arg1: u8, arg2: 0x2::object::ID) : bool {
        let v0 = CoinSetKey{
            decimals : arg1,
            cap_id   : arg2,
        };
        0x2::dynamic_field::exists_<CoinSetKey>(&arg0.id, v0)
    }

    public fun listing_fee() : u64 {
        10000000
    }

    public fun sets_available_for_decimals(arg0: &BlankCoinsRegistry, arg1: u8) : u64 {
        if (arg1 > 18) {
            return 0
        };
        *0x1::vector::borrow<u64>(&arg0.sets_by_decimals, (arg1 as u64))
    }

    public entry fun share_registry(arg0: BlankCoinsRegistry) {
        0x2::transfer::share_object<BlankCoinsRegistry>(arg0);
    }

    public fun take_coin_set<T0>(arg0: &mut BlankCoinsRegistry, arg1: u8, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = CoinSetKey{
            decimals : arg1,
            cap_id   : arg2,
        };
        assert!(0x2::dynamic_field::exists_with_type<CoinSetKey, CoinSet<T0>>(&arg0.id, v0), 9);
        let v1 = 0x2::dynamic_field::remove<CoinSetKey, CoinSet<T0>>(&mut arg0.id, v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 10000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 10000000, arg5), v1.owner);
        arg0.total_sets = arg0.total_sets - 1;
        let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.sets_by_decimals, (v1.decimals as u64));
        *v2 = *v2 - 1;
        let v3 = CoinSetTaken{
            registry_id : 0x2::object::id<BlankCoinsRegistry>(arg0),
            cap_id      : arg2,
            taker       : 0x2::tx_context::sender(arg5),
            fee_paid    : 10000000,
            owner_paid  : v1.owner,
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CoinSetTaken>(v3);
        let CoinSet {
            treasury_cap : v4,
            metadata_cap : v5,
            currency_id  : _,
            owner        : _,
            decimals     : _,
        } = v1;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v4, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T0>>(v5, 0x2::tx_context::sender(arg5));
        arg3
    }

    public fun take_coin_set_for_ptb<T0>(arg0: &mut BlankCoinsRegistry, arg1: u8, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin_registry::MetadataCap<T0>, 0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = CoinSetKey{
            decimals : arg1,
            cap_id   : arg2,
        };
        assert!(0x2::dynamic_field::exists_with_type<CoinSetKey, CoinSet<T0>>(&arg0.id, v0), 9);
        let v1 = 0x2::dynamic_field::remove<CoinSetKey, CoinSet<T0>>(&mut arg0.id, v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 10000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 10000000, arg5), v1.owner);
        arg0.total_sets = arg0.total_sets - 1;
        let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.sets_by_decimals, (v1.decimals as u64));
        *v2 = *v2 - 1;
        let v3 = CoinSetTaken{
            registry_id : 0x2::object::id<BlankCoinsRegistry>(arg0),
            cap_id      : arg2,
            taker       : 0x2::tx_context::sender(arg5),
            fee_paid    : 10000000,
            owner_paid  : v1.owner,
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CoinSetTaken>(v3);
        let CoinSet {
            treasury_cap : v4,
            metadata_cap : v5,
            currency_id  : v6,
            owner        : _,
            decimals     : _,
        } = v1;
        (v4, v5, v6, arg3)
    }

    public fun total_sets(arg0: &BlankCoinsRegistry) : u64 {
        arg0.total_sets
    }

    public fun validate_coin_set<T0>(arg0: &0x2::coin::TreasuryCap<T0>) {
        assert!(0x2::coin::total_supply<T0>(arg0) == 0, 0);
    }

    fun validate_coin_set_for_registry<T0>(arg0: &0x2::coin_registry::Currency<T0>, arg1: &0x2::coin::TreasuryCap<T0>) {
        validate_coin_set<T0>(arg1);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg0), 15);
        let v0 = 0x2::coin_registry::treasury_cap_id<T0>(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 15);
        assert!(0x2::coin_registry::symbol<T0>(arg0) == 0x1::string::utf8(b"Govex Conditional"), 14);
        let v1 = 0x2::coin_registry::name<T0>(arg0);
        assert!(0x1::string::is_empty(&v1), 10);
        let v2 = 0x2::coin_registry::description<T0>(arg0);
        assert!(0x1::string::is_empty(&v2), 10);
        let v3 = 0x2::coin_registry::icon_url<T0>(arg0);
        assert!(0x1::string::is_empty(&v3), 10);
        let v4 = 0x1::type_name::get<T0>();
        let v5 = 0x1::ascii::into_bytes(0x1::type_name::get_module(&v4));
        let v6 = b"conditional_";
        let v7 = 0x1::vector::length<u8>(&v6);
        assert!(0x1::vector::length<u8>(&v5) > v7, 10);
        let v8 = 0;
        while (v8 < v7) {
            assert!(*0x1::vector::borrow<u8>(&v5, v8) == *0x1::vector::borrow<u8>(&v6, v8), 10);
            v8 = v8 + 1;
        };
        while (v8 < 0x1::vector::length<u8>(&v5)) {
            let v9 = *0x1::vector::borrow<u8>(&v5, v8);
            assert!(v9 >= 48 && v9 <= 57, 10);
            v8 = v8 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

