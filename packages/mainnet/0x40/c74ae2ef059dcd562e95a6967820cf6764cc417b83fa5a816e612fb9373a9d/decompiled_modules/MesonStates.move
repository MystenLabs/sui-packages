module 0x40c74ae2ef059dcd562e95a6967820cf6764cc417b83fa5a816e612fb9373a9d::MesonStates {
    struct GeneralStore has store, key {
        id: 0x2::object::UID,
        supported_coins: 0x2::table::Table<u8, 0x1::type_name::TypeName>,
        pool_owners: 0x2::table::Table<u64, address>,
        pool_of_authorized_addr: 0x2::table::Table<address, u64>,
        posted_swaps: 0x2::table::Table<vector<u8>, PostedSwap>,
        locked_swaps: 0x2::table::Table<vector<u8>, LockedSwap>,
        in_pool_coins: 0x2::bag::Bag,
        pending_coins: 0x2::bag::Bag,
    }

    struct PostedSwap has store {
        pool_index: u64,
        initiator: vector<u8>,
        from_address: address,
    }

    struct LockedSwap has store {
        pool_index: u64,
        until: u64,
        recipient: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun addSupportToken<T0>(arg0: &AdminCap, arg1: u8, arg2: &mut GeneralStore, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2.supported_coins;
        if (0x2::table::contains<u8, 0x1::type_name::TypeName>(v0, arg1)) {
            0x2::table::remove<u8, 0x1::type_name::TypeName>(v0, arg1);
        };
        0x2::table::add<u8, 0x1::type_name::TypeName>(v0, arg1, 0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::get<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::table::Table<u64, 0x2::coin::Coin<T0>>>(&mut arg2.in_pool_coins, v1, 0x2::table::new<u64, 0x2::coin::Coin<T0>>(arg3));
        0x2::bag::add<0x1::type_name::TypeName, 0x2::table::Table<vector<u8>, 0x2::coin::Coin<T0>>>(&mut arg2.pending_coins, v1, 0x2::table::new<vector<u8>, 0x2::coin::Coin<T0>>(arg3));
    }

    public(friend) fun add_authorized(arg0: u64, arg1: address, arg2: &mut GeneralStore) {
        assert!(arg0 != 0, 16);
        assert!(!0x2::table::contains<address, u64>(&arg2.pool_of_authorized_addr, arg1), 22);
        0x2::table::add<address, u64>(&mut arg2.pool_of_authorized_addr, arg1, arg0);
    }

    public(friend) fun add_locked_swap(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: address, arg4: &mut GeneralStore) {
        let v0 = &mut arg4.locked_swaps;
        assert!(!0x2::table::contains<vector<u8>, LockedSwap>(v0, arg0), 35);
        let v1 = LockedSwap{
            pool_index : arg1,
            until      : arg2,
            recipient  : arg3,
        };
        0x2::table::add<vector<u8>, LockedSwap>(v0, arg0, v1);
    }

    public(friend) fun add_posted_swap(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: address, arg4: &mut GeneralStore) {
        let v0 = &mut arg4.posted_swaps;
        assert!(!0x2::table::contains<vector<u8>, PostedSwap>(v0, arg0), 35);
        let v1 = PostedSwap{
            pool_index   : arg1,
            initiator    : arg2,
            from_address : arg3,
        };
        0x2::table::add<vector<u8>, PostedSwap>(v0, arg0, v1);
    }

    public(friend) fun assert_is_premium_manager(arg0: address, arg1: &GeneralStore) {
        assert!(arg0 == owner_of_pool(0, arg1), 1);
    }

    public(friend) fun bond_posted_swap(arg0: vector<u8>, arg1: u64, arg2: &mut GeneralStore) {
        let v0 = 0x2::table::borrow_mut<vector<u8>, PostedSwap>(&mut arg2.posted_swaps, arg0);
        assert!(v0.from_address != @0x0, 34);
        assert!(v0.pool_index == 0, 44);
        v0.pool_index = arg1;
    }

    public(friend) fun coin_type_for_index(arg0: u8, arg1: &GeneralStore) : 0x1::type_name::TypeName {
        *0x2::table::borrow<u8, 0x1::type_name::TypeName>(&arg1.supported_coins, arg0)
    }

    public(friend) fun coins_from_pending<T0>(arg0: vector<u8>, arg1: &mut GeneralStore) : 0x2::coin::Coin<T0> {
        0x2::table::remove<vector<u8>, 0x2::coin::Coin<T0>>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<vector<u8>, 0x2::coin::Coin<T0>>>(&mut arg1.pending_coins, 0x1::type_name::get<T0>()), arg0)
    }

    public(friend) fun coins_from_pool<T0>(arg0: u64, arg1: u64, arg2: &mut GeneralStore, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(0x2::table::borrow_mut<u64, 0x2::coin::Coin<T0>>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<u64, 0x2::coin::Coin<T0>>>(&mut arg2.in_pool_coins, 0x1::type_name::get<T0>()), arg0), arg1, arg3)
    }

    public(friend) fun coins_to_pending<T0>(arg0: vector<u8>, arg1: 0x2::coin::Coin<T0>, arg2: &mut GeneralStore) {
        0x2::table::add<vector<u8>, 0x2::coin::Coin<T0>>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<vector<u8>, 0x2::coin::Coin<T0>>>(&mut arg2.pending_coins, 0x1::type_name::get<T0>()), arg0, arg1);
    }

    public(friend) fun coins_to_pool<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut GeneralStore) {
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<u64, 0x2::coin::Coin<T0>>>(&mut arg2.in_pool_coins, 0x1::type_name::get<T0>());
        if (0x2::table::contains<u64, 0x2::coin::Coin<T0>>(v0, arg0)) {
            0x2::coin::join<T0>(0x2::table::borrow_mut<u64, 0x2::coin::Coin<T0>>(v0, arg0), arg1);
        } else {
            0x2::table::add<u64, 0x2::coin::Coin<T0>>(v0, arg0, arg1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = GeneralStore{
            id                      : 0x2::object::new(arg0),
            supported_coins         : 0x2::table::new<u8, 0x1::type_name::TypeName>(arg0),
            pool_owners             : 0x2::table::new<u64, address>(arg0),
            pool_of_authorized_addr : 0x2::table::new<address, u64>(arg0),
            posted_swaps            : 0x2::table::new<vector<u8>, PostedSwap>(arg0),
            locked_swaps            : 0x2::table::new<vector<u8>, LockedSwap>(arg0),
            in_pool_coins           : 0x2::bag::new(arg0),
            pending_coins           : 0x2::bag::new(arg0),
        };
        0x2::table::add<u64, address>(&mut v2.pool_owners, 0, v0);
        0x2::transfer::share_object<GeneralStore>(v2);
    }

    public(friend) fun match_coin_type<T0>(arg0: u8, arg1: &GeneralStore) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::type_name::into_string(coin_type_for_index(arg0, arg1)), 38);
    }

    public(friend) fun merge_coins_and_split<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0, 39);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        while (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) != 0) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<T0>(&mut v0, arg1, arg2)
    }

    public(friend) fun owner_of_pool(arg0: u64, arg1: &GeneralStore) : address {
        let v0 = &arg1.pool_owners;
        assert!(0x2::table::contains<u64, address>(v0, arg0), 18);
        *0x2::table::borrow<u64, address>(v0, arg0)
    }

    public(friend) fun pool_index_if_owner(arg0: address, arg1: &GeneralStore) : u64 {
        let v0 = pool_index_of(arg0, arg1);
        assert!(arg0 == owner_of_pool(v0, arg1), 20);
        v0
    }

    public(friend) fun pool_index_of(arg0: address, arg1: &GeneralStore) : u64 {
        let v0 = &arg1.pool_of_authorized_addr;
        assert!(0x2::table::contains<address, u64>(v0, arg0), 21);
        *0x2::table::borrow<address, u64>(v0, arg0)
    }

    public(friend) fun register_pool_index(arg0: u64, arg1: address, arg2: &mut GeneralStore) {
        assert!(arg0 != 0, 16);
        assert!(!0x2::table::contains<u64, address>(&arg2.pool_owners, arg0), 19);
        assert!(!0x2::table::contains<address, u64>(&arg2.pool_of_authorized_addr, arg1), 22);
        0x2::table::add<u64, address>(&mut arg2.pool_owners, arg0, arg1);
        0x2::table::add<address, u64>(&mut arg2.pool_of_authorized_addr, arg1, arg0);
    }

    public(friend) fun remove_authorized(arg0: u64, arg1: address, arg2: &mut GeneralStore) {
        assert!(arg0 == 0x2::table::remove<address, u64>(&mut arg2.pool_of_authorized_addr, arg1), 23);
    }

    public(friend) fun remove_locked_swap(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut GeneralStore) : (u64, u64, address) {
        let v0 = &mut arg2.locked_swaps;
        let v1 = 0x2::table::borrow<vector<u8>, LockedSwap>(v0, arg0);
        assert!(v1.until != 0, 34);
        let v2 = v1.until;
        if (v2 > 0x2::clock::timestamp_ms(arg1) / 1000) {
            0x2::table::borrow_mut<vector<u8>, LockedSwap>(v0, arg0).until = 0;
        } else {
            let LockedSwap {
                pool_index : _,
                until      : _,
                recipient  : _,
            } = 0x2::table::remove<vector<u8>, LockedSwap>(v0, arg0);
        };
        (v1.pool_index, v2, v1.recipient)
    }

    public(friend) fun remove_posted_swap(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut GeneralStore) : (u64, vector<u8>, address) {
        let v0 = &mut arg2.posted_swaps;
        assert!(0x2::table::contains<vector<u8>, PostedSwap>(v0, arg0), 34);
        if (0x40c74ae2ef059dcd562e95a6967820cf6764cc417b83fa5a816e612fb9373a9d::MesonHelpers::expire_ts_from(arg0) < 0x2::clock::timestamp_ms(arg1) / 1000 + 0x40c74ae2ef059dcd562e95a6967820cf6764cc417b83fa5a816e612fb9373a9d::MesonHelpers::get_MIN_BOND_TIME_PERIOD()) {
            let PostedSwap {
                pool_index   : v4,
                initiator    : v5,
                from_address : v6,
            } = 0x2::table::remove<vector<u8>, PostedSwap>(v0, arg0);
            assert!(v6 != @0x0, 34);
            (v4, v5, v6)
        } else {
            let v7 = 0x2::table::borrow_mut<vector<u8>, PostedSwap>(v0, arg0);
            let v8 = v7.from_address;
            assert!(v8 != @0x0, 34);
            v7.from_address = @0x0;
            (v7.pool_index, v7.initiator, v8)
        }
    }

    public entry fun transferPremiumManager(arg0: address, arg1: &mut GeneralStore, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.pool_owners;
        assert!(0x2::tx_context::sender(arg2) == 0x2::table::remove<u64, address>(v0, 0), 1);
        0x2::table::add<u64, address>(v0, 0, arg0);
    }

    public(friend) fun transfer_pool_owner(arg0: u64, arg1: address, arg2: &mut GeneralStore) {
        assert!(arg0 != 0, 16);
        assert!(0x2::table::contains<address, u64>(&arg2.pool_of_authorized_addr, arg1), 21);
        assert!(arg0 == *0x2::table::borrow<address, u64>(&arg2.pool_of_authorized_addr, arg1), 23);
        0x2::table::remove<u64, address>(&mut arg2.pool_owners, arg0);
        0x2::table::add<u64, address>(&mut arg2.pool_owners, arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

