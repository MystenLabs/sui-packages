module 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::sui_safe {
    struct Lock<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
        start_time: u64,
        duration: u64,
        strategy: u8,
    }

    struct YieldLock<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        start_time: u64,
        duration: u64,
        principal_amount: u64,
        strategy: u8,
        market_coin: 0x2::coin::Coin<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::MarketCoin<T0>>,
    }

    struct Platform has store, key {
        id: 0x2::object::UID,
        admin: address,
        fees: 0x2::bag::Bag,
        yield_fees: 0x2::bag::Bag,
        supported_tokens: vector<0x1::type_name::TypeName>,
        version: 0x2::object::ID,
        market: 0x2::object::ID,
    }

    struct UserRegistry has store, key {
        id: 0x2::object::UID,
        locks: 0x2::vec_map::VecMap<address, vector<0x2::object::ID>>,
        yield_locks: 0x2::vec_map::VecMap<address, vector<0x2::object::ID>>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct LockCreated<phantom T0> has copy, drop, store {
        owner: address,
        amount: u64,
        start_time: u64,
        duration: u64,
        strategy: u8,
    }

    struct LockExtended<phantom T0> has copy, drop, store {
        owner: address,
        added_amount: u64,
        new_total: u64,
        strategy: u8,
    }

    struct LockWithdrawn<phantom T0> has copy, drop, store {
        owner: address,
        amount_withdrawn: u64,
        withdrawn_time: u64,
        strategy: u8,
    }

    struct YieldLockCreated<phantom T0> has copy, drop, store {
        owner: address,
        principal_amount: u64,
        start_time: u64,
        duration: u64,
        market_coin_amount: u64,
    }

    struct YieldLockWithdrawn<phantom T0> has copy, drop, store {
        owner: address,
        principal_withdrawn: u64,
        yield_earned: u64,
        platform_yield_fee: u64,
        user_yield_amount: u64,
        withdrawn_time: u64,
    }

    struct TokenAdded has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
        admin: address,
    }

    public entry fun add_to_lock<T0>(arg0: &mut Lock<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 1);
        assert!(arg0.strategy == 0, 3);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.balance, v1);
        let v2 = LockExtended<T0>{
            owner        : v0,
            added_amount : 0x2::balance::value<T0>(&v1),
            new_total    : 0x2::balance::value<T0>(&arg0.balance),
            strategy     : arg0.strategy,
        };
        0x2::event::emit<LockExtended<T0>>(v2);
    }

    public entry fun add_token_support<T0>(arg0: &mut AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        let v1 = 0x1::type_name::get<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.supported_tokens, v1);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::vec_map::VecMap<address, 0x2::balance::Balance<T0>>>(&mut arg1.fees, v1, 0x2::vec_map::empty<address, 0x2::balance::Balance<T0>>());
            0x2::bag::add<0x1::type_name::TypeName, 0x2::vec_map::VecMap<address, 0x2::balance::Balance<T0>>>(&mut arg1.yield_fees, v1, 0x2::vec_map::empty<address, 0x2::balance::Balance<T0>>());
            let v2 = TokenAdded{
                token_type : v1,
                admin      : v0,
            };
            0x2::event::emit<TokenAdded>(v2);
        };
    }

    public entry fun collect_fees<T0>(arg0: &mut AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1), 2);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<address, 0x2::balance::Balance<T0>>>(&mut arg1.fees, v1);
        let v3 = 0x2::balance::zero<T0>();
        while (!0x2::vec_map::is_empty<address, 0x2::balance::Balance<T0>>(v2)) {
            let (_, v5) = 0x2::vec_map::pop<address, 0x2::balance::Balance<T0>>(v2);
            0x2::balance::join<T0>(&mut v3, v5);
        };
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg2), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
    }

    public entry fun collect_yield_fees<T0>(arg0: &mut AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1), 2);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<address, 0x2::balance::Balance<T0>>>(&mut arg1.yield_fees, v1);
        let v3 = 0x2::balance::zero<T0>();
        while (!0x2::vec_map::is_empty<address, 0x2::balance::Balance<T0>>(v2)) {
            let (_, v5) = 0x2::vec_map::pop<address, 0x2::balance::Balance<T0>>(v2);
            0x2::balance::join<T0>(&mut v3, v5);
        };
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg2), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
    }

    public entry fun create_lock<T0>(arg0: &Platform, arg1: &mut UserRegistry, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        assert!(arg4 == 0, 3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0), 2);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = 0x2::coin::into_balance<T0>(arg2);
        let v4 = Lock<T0>{
            id         : 0x2::object::new(arg6),
            balance    : v3,
            owner      : v2,
            start_time : v1,
            duration   : arg3,
            strategy   : arg4,
        };
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg1.locks, &v2)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<address, vector<0x2::object::ID>>(&mut arg1.locks, &v2), 0x2::object::id<Lock<T0>>(&v4));
        } else {
            let v5 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x2::object::id<Lock<T0>>(&v4));
            0x2::vec_map::insert<address, vector<0x2::object::ID>>(&mut arg1.locks, v2, v5);
        };
        0x2::transfer::public_transfer<Lock<T0>>(v4, v2);
        let v6 = LockCreated<T0>{
            owner      : v2,
            amount     : 0x2::balance::value<T0>(&v3),
            start_time : v1,
            duration   : arg3,
            strategy   : arg4,
        };
        0x2::event::emit<LockCreated<T0>>(v6);
    }

    public entry fun create_yield_lock<T0>(arg0: &Platform, arg1: &mut UserRegistry, arg2: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::version::Version, arg3: &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::Market, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0), 2);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = 0x2::coin::value<T0>(&arg4);
        let v4 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::mint::mint<T0>(arg2, arg3, arg4, arg6, arg7);
        let v5 = YieldLock<T0>{
            id               : 0x2::object::new(arg7),
            owner            : v2,
            start_time       : v1,
            duration         : arg5,
            principal_amount : v3,
            strategy         : 1,
            market_coin      : v4,
        };
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg1.yield_locks, &v2)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<address, vector<0x2::object::ID>>(&mut arg1.yield_locks, &v2), 0x2::object::id<YieldLock<T0>>(&v5));
        } else {
            let v6 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<YieldLock<T0>>(&v5));
            0x2::vec_map::insert<address, vector<0x2::object::ID>>(&mut arg1.yield_locks, v2, v6);
        };
        0x2::transfer::public_transfer<YieldLock<T0>>(v5, v2);
        let v7 = YieldLockCreated<T0>{
            owner              : v2,
            principal_amount   : v3,
            start_time         : v1,
            duration           : arg5,
            market_coin_amount : 0x2::coin::value<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::MarketCoin<T0>>(&v4),
        };
        0x2::event::emit<YieldLockCreated<T0>>(v7);
    }

    public fun get_supported_tokens(arg0: &Platform) : vector<0x1::type_name::TypeName> {
        arg0.supported_tokens
    }

    public fun get_user_locks(arg0: &UserRegistry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg0.locks, &arg1)) {
            *0x2::vec_map::get<address, vector<0x2::object::ID>>(&arg0.locks, &arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_user_yield_locks(arg0: &UserRegistry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg0.yield_locks, &arg1)) {
            *0x2::vec_map::get<address, vector<0x2::object::ID>>(&arg0.yield_locks, &arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = UserRegistry{
            id          : 0x2::object::new(arg0),
            locks       : 0x2::vec_map::empty<address, vector<0x2::object::ID>>(),
            yield_locks : 0x2::vec_map::empty<address, vector<0x2::object::ID>>(),
        };
        0x2::transfer::share_object<UserRegistry>(v1);
        let v2 = Platform{
            id               : 0x2::object::new(arg0),
            admin            : 0x2::tx_context::sender(arg0),
            fees             : 0x2::bag::new(arg0),
            yield_fees       : 0x2::bag::new(arg0),
            supported_tokens : 0x1::vector::empty<0x1::type_name::TypeName>(),
            version          : 0x2::object::id_from_address(@0x0),
            market           : 0x2::object::id_from_address(@0x0),
        };
        0x2::transfer::share_object<Platform>(v2);
    }

    public fun is_token_supported<T0>(arg0: &Platform) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0)
    }

    public entry fun set_scallop_objects(arg0: &mut AdminCap, arg1: &mut Platform, arg2: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::version::Version, arg3: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::Market, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 1);
        arg1.version = 0x2::object::id<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::version::Version>(arg2);
        arg1.market = 0x2::object::id<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::Market>(arg3);
    }

    public entry fun withdraw<T0>(arg0: Lock<T0>, arg1: &mut Platform, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 1);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1), 2);
        let Lock {
            id         : v2,
            balance    : v3,
            owner      : _,
            start_time : v5,
            duration   : v6,
            strategy   : v7,
        } = arg0;
        let v8 = v3;
        assert!(v7 == 0, 3);
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::clock::timestamp_ms(arg2);
        let (v11, v12) = if (v10 >= v5 + v6) {
            (v9, 0)
        } else {
            let v13 = v9 * 200 / 10000;
            (v9 - v13, v13)
        };
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v8, v11, arg3), v0);
        };
        if (v12 > 0) {
            let v14 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<address, 0x2::balance::Balance<T0>>>(&mut arg1.fees, v1);
            if (0x2::vec_map::contains<address, 0x2::balance::Balance<T0>>(v14, &v0)) {
                0x2::balance::join<T0>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(v14, &v0), 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut v8, v12, arg3)));
            } else {
                0x2::vec_map::insert<address, 0x2::balance::Balance<T0>>(v14, v0, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut v8, v12, arg3)));
            };
        };
        let v15 = LockWithdrawn<T0>{
            owner            : v0,
            amount_withdrawn : v11,
            withdrawn_time   : v10,
            strategy         : v7,
        };
        0x2::event::emit<LockWithdrawn<T0>>(v15);
        0x2::balance::destroy_zero<T0>(v8);
        0x2::object::delete(v2);
    }

    public entry fun withdraw_yield_lock<T0>(arg0: YieldLock<T0>, arg1: &mut Platform, arg2: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::version::Version, arg3: &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.owner, 1);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1), 2);
        let YieldLock {
            id               : v2,
            owner            : _,
            start_time       : v4,
            duration         : v5,
            principal_amount : v6,
            strategy         : _,
            market_coin      : v8,
        } = arg0;
        let v9 = 0x2::clock::timestamp_ms(arg4);
        let v10 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::redeem::redeem<T0>(arg2, arg3, v8, arg4, arg5);
        let v11 = 0x2::coin::value<T0>(&v10);
        let v12 = if (v11 > v6) {
            v11 - v6
        } else {
            0
        };
        let v13 = v12 * 3000 / 10000;
        let v14 = v12 - v13;
        let (v15, v16) = if (v9 >= v4 + v5) {
            (v6, 0)
        } else {
            let v17 = v6 * 200 / 10000;
            (v6 - v17, v17)
        };
        let v18 = v15 + v14;
        let v19 = v16 + v13;
        let v20 = 0x2::coin::zero<T0>(arg5);
        let v21 = 0x2::coin::zero<T0>(arg5);
        if (v18 > 0) {
            0x2::coin::join<T0>(&mut v20, 0x2::coin::split<T0>(&mut v10, v18, arg5));
        };
        if (v19 > 0) {
            0x2::coin::join<T0>(&mut v21, 0x2::coin::split<T0>(&mut v10, v19, arg5));
        };
        if (0x2::coin::value<T0>(&v20) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v20, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v20);
        };
        if (0x2::coin::value<T0>(&v21) > 0) {
            let v22 = 0x2::coin::into_balance<T0>(v21);
            let v23 = 0x2::balance::zero<T0>();
            let v24 = 0x2::balance::zero<T0>();
            if (v16 > 0) {
                0x2::balance::join<T0>(&mut v23, 0x2::balance::split<T0>(&mut v22, v16));
            };
            if (v13 > 0) {
                0x2::balance::join<T0>(&mut v24, v22);
            } else {
                0x2::balance::destroy_zero<T0>(v22);
            };
            if (0x2::balance::value<T0>(&v23) > 0) {
                let v25 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<address, 0x2::balance::Balance<T0>>>(&mut arg1.fees, v1);
                if (0x2::vec_map::contains<address, 0x2::balance::Balance<T0>>(v25, &v0)) {
                    0x2::balance::join<T0>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(v25, &v0), v23);
                } else {
                    0x2::vec_map::insert<address, 0x2::balance::Balance<T0>>(v25, v0, v23);
                };
            } else {
                0x2::balance::destroy_zero<T0>(v23);
            };
            if (0x2::balance::value<T0>(&v24) > 0) {
                let v26 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<address, 0x2::balance::Balance<T0>>>(&mut arg1.yield_fees, v1);
                if (0x2::vec_map::contains<address, 0x2::balance::Balance<T0>>(v26, &v0)) {
                    0x2::balance::join<T0>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<T0>>(v26, &v0), v24);
                } else {
                    0x2::vec_map::insert<address, 0x2::balance::Balance<T0>>(v26, v0, v24);
                };
            } else {
                0x2::balance::destroy_zero<T0>(v24);
            };
        } else {
            0x2::coin::destroy_zero<T0>(v21);
        };
        if (0x2::coin::value<T0>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v10);
        };
        let v27 = YieldLockWithdrawn<T0>{
            owner               : v0,
            principal_withdrawn : v15,
            yield_earned        : v12,
            platform_yield_fee  : v13,
            user_yield_amount   : v14,
            withdrawn_time      : v9,
        };
        0x2::event::emit<YieldLockWithdrawn<T0>>(v27);
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

