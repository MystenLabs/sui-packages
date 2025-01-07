module 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::arena {
    struct ArenaPool<phantom T0> has key {
        id: 0x2::object::UID,
        ticker: vector<u8>,
        decimals: u8,
        treasury: 0x2::balance::Balance<T0>,
        pool_type: u16,
        pool_cfg_id: 0x2::object::ID,
        fund_addr: address,
        fee_cut: u32,
        expired_ms: u64,
        all_pool_users: u32,
        pool_count: u32,
        latest_pools: 0x2::table::Table<u32, 0x2::object::ID>,
        pool_index_map: 0x2::table::Table<u32, 0x2::object::ID>,
        is_deleted: bool,
    }

    struct PoolDetail has store, key {
        id: 0x2::object::UID,
        pool_index: u32,
        arena_pool_id: 0x2::object::ID,
        cost_in_usd: u32,
        raised_amount: u64,
        winner_amount: u64,
        num_users: u32,
        users_map: vector<address>,
        user_amounts_map: 0x2::table::Table<address, u64>,
        winner: u32,
        expired_ms: u64,
        expired_at: u64,
        is_claimed: bool,
    }

    struct JoinEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        raised_amount: u64,
        user: address,
        amount: u64,
        decimals: u8,
        max_users: u32,
        num_users: u32,
        created_at: u64,
    }

    struct JoinedUserCountEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        user: address,
        num_users: u32,
        joined_at: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        created_at: u64,
    }

    struct ClaimEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        created_at: u64,
    }

    struct ArenaPoolCreateEvent has copy, drop, store {
        arena_pool_id: 0x2::object::ID,
        ticker: 0x1::option::Option<0x1::string::String>,
        token_address: 0x1::ascii::String,
        decimals: u8,
        pool_type: u16,
        fund_addr: address,
        expired_ms: u64,
        created_by: address,
        created_at: u64,
    }

    struct ArenaPoolUpdatedEvent has copy, drop, store {
        arena_pool_id: 0x2::object::ID,
        fund_addr: address,
        expired_ms: u64,
        updated_by: address,
        updated_at: u64,
    }

    struct ArenaPoolDeleteEvent has copy, drop, store {
        arena_pool_id: 0x2::object::ID,
        created_by: address,
        created_at: u64,
    }

    struct PoolDetailCreateEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_index: u32,
        arena_pool_id: 0x2::object::ID,
        cost_in_usd: u32,
        raised_amount: u64,
        expired_at: u64,
        created_by: address,
        created_at: u64,
    }

    struct PoolWinnerEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_type: u16,
        winner: address,
        amount: u64,
        created_by: address,
        created_at: u64,
    }

    struct PoolOwnerCutEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        receiver: address,
        amount: u64,
        created_at: u64,
    }

    fun add_pool<T0>(arg0: &mut ArenaPool<T0>, arg1: PoolDetail, arg2: u32) {
        let v0 = 0x2::object::id<PoolDetail>(&arg1);
        0x2::table::add<0x2::object::ID, PoolDetail>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&mut arg0.id, b"pools"), v0, arg1);
        0x2::table::add<u32, 0x2::object::ID>(&mut arg0.pool_index_map, arg2, v0);
        add_pool_map<T0>(arg0, v0, arg1.cost_in_usd);
    }

    fun add_pool_map<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: u32) {
        let v0 = get_key_for_pool_map(arg0.pool_type, arg2);
        if (0x2::table::contains<u32, 0x2::object::ID>(&arg0.latest_pools, v0)) {
            0x2::table::remove<u32, 0x2::object::ID>(&mut arg0.latest_pools, v0);
        };
        0x2::table::add<u32, 0x2::object::ID>(&mut arg0.latest_pools, v0, arg1);
    }

    public fun changeArenaPoolConfig<T0>(arg0: &mut ArenaPool<T0>, arg1: address, arg2: u64, arg3: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg4: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::assert_current_version(arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg3, v0), 3);
        assert!(arg2 >= 300000, 6);
        arg0.expired_ms = arg2;
        arg0.fund_addr = arg1;
        let v1 = ArenaPoolUpdatedEvent{
            arena_pool_id : 0x2::object::id<ArenaPool<T0>>(arg0),
            fund_addr     : arg1,
            expired_ms    : arg2,
            updated_by    : v0,
            updated_at    : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<ArenaPoolUpdatedEvent>(v1);
    }

    fun check_and_create_pool<T0>(arg0: &mut ArenaPool<T0>, arg1: &mut 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::PoolConfig, arg2: u32, arg3: u32, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = get_latest_pool_id<T0>(arg0, arg2);
        let v1 = false;
        if (0x1::option::is_none<0x2::object::ID>(&v0)) {
            v1 = true;
        } else {
            let v2 = 0x1::option::extract<0x2::object::ID>(&mut v0);
            if (!check_pool_available<T0>(arg0, v2, arg3, arg4)) {
                v1 = true;
            } else {
                v0 = 0x1::option::some<0x2::object::ID>(v2);
            };
        };
        if (v1) {
            let v3 = 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::pool_count(arg1);
            let (v4, v5) = new_pool(0x2::object::id<ArenaPool<T0>>(arg0), arg2, arg0.expired_ms, arg4, v3, arg5);
            add_pool<T0>(arg0, v5, v3);
            arg0.pool_count = arg0.pool_count + 1;
            0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::increase_pcount(arg1);
            v0 = 0x1::option::some<0x2::object::ID>(v4);
        };
        0x1::option::extract<0x2::object::ID>(&mut v0)
    }

    fun check_pool_available<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID, arg2: u32, arg3: u64) : bool {
        let v0 = true;
        if (!pool_exists<T0>(arg0, arg1)) {
            v0 = false;
        } else {
            let v1 = get_pool<T0>(arg0, arg1);
            if (v1.num_users >= arg2) {
                v0 = false;
            };
            if (v1.expired_at <= arg3) {
                v0 = false;
            };
            if (v1.winner > 0) {
                v0 = false;
            };
        };
        v0
    }

    fun check_user_joined(arg0: &PoolDetail, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.users_map, &arg1)
    }

    public entry fun claimWinner<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::assert_current_version(arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::balance::value<T0>(&arg0.treasury) > 0, 4);
        assert!(pool_exists<T0>(arg0, arg1), 41);
        let v1 = get_pool<T0>(arg0, arg1);
        assert!(!v1.is_claimed, 21);
        assert!(v1.winner > 0, 22);
        assert!(&v0 == 0x1::vector::borrow<address>(&v1.users_map, ((v1.winner - 1) as u64)), 20);
        let v2 = v1.winner_amount;
        let v3 = v1.raised_amount - v2;
        let v4 = arg0.fund_addr;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v2, arg3), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v3, arg3), v4);
        get_pool_mut<T0>(arg0, arg1).is_claimed = true;
        let v5 = ClaimEvent{
            pool_id    : arg1,
            user       : v0,
            amount     : v2,
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<ClaimEvent>(v5);
        let v6 = PoolOwnerCutEvent{
            pool_id    : arg1,
            receiver   : v4,
            amount     : v3,
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolOwnerCutEvent>(v6);
    }

    entry fun deleteArenaPool<T0>(arg0: &mut ArenaPool<T0>, arg1: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg2: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::Version, arg3: &0x2::tx_context::TxContext) {
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::assert_current_version(arg2);
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg1, 0x2::tx_context::sender(arg3)), 3);
        assert!(!arg0.is_deleted, 40);
        arg0.is_deleted = true;
        let v0 = ArenaPoolDeleteEvent{
            arena_pool_id : 0x2::object::id<ArenaPool<T0>>(arg0),
            created_by    : 0x2::tx_context::sender(arg3),
            created_at    : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<ArenaPoolDeleteEvent>(v0);
    }

    public fun getArenaData<T0>(arg0: &ArenaPool<T0>) : (u16, 0x2::object::ID, address, u32, u64, u32, u32, bool) {
        (arg0.pool_type, arg0.pool_cfg_id, arg0.fund_addr, arg0.fee_cut, arg0.expired_ms, arg0.all_pool_users, arg0.pool_count, arg0.is_deleted)
    }

    public fun getPoolData<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : (0x2::object::ID, u32, u32, u64, u64, u32, u32, u64, bool) {
        get_pool_data<T0>(arg0, arg1)
    }

    public fun getPoolDataByIndex<T0>(arg0: &ArenaPool<T0>, arg1: u32, arg2: &0x2::tx_context::TxContext) : (0x2::object::ID, u32, u32, u64, u64, u32, u32, u64, bool) {
        let v0 = get_pool_id_by_index<T0>(arg0, arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 41);
        get_pool_data<T0>(arg0, 0x1::option::extract<0x2::object::ID>(&mut v0))
    }

    fun get_key_for_pool_map(arg0: u16, arg1: u32) : u32 {
        arg1 + (arg0 as u32)
    }

    fun get_latest_pool_id<T0>(arg0: &ArenaPool<T0>, arg1: u32) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x1::option::none<0x2::object::ID>();
        let v1 = get_key_for_pool_map(arg0.pool_type, arg1);
        if (0x2::table::contains<u32, 0x2::object::ID>(&arg0.latest_pools, v1)) {
            v0 = 0x1::option::some<0x2::object::ID>(*0x2::table::borrow<u32, 0x2::object::ID>(&arg0.latest_pools, v1));
        };
        v0
    }

    fun get_pool<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID) : &PoolDetail {
        0x2::table::borrow<0x2::object::ID, PoolDetail>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&arg0.id, b"pools"), arg1)
    }

    fun get_pool_data<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID) : (0x2::object::ID, u32, u32, u64, u64, u32, u32, u64, bool) {
        assert!(pool_exists<T0>(arg0, arg1), 41);
        let v0 = get_pool<T0>(arg0, arg1);
        (v0.arena_pool_id, v0.pool_index, v0.cost_in_usd, v0.raised_amount, v0.winner_amount, v0.num_users, v0.winner, v0.expired_at, v0.is_claimed)
    }

    fun get_pool_id_by_index<T0>(arg0: &ArenaPool<T0>, arg1: u32) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x1::option::none<0x2::object::ID>();
        if (0x2::table::contains<u32, 0x2::object::ID>(&arg0.pool_index_map, arg1)) {
            v0 = 0x1::option::some<0x2::object::ID>(*0x2::table::borrow<u32, 0x2::object::ID>(&arg0.pool_index_map, arg1));
        };
        v0
    }

    fun get_pool_mut<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID) : &mut PoolDetail {
        0x2::table::borrow_mut<0x2::object::ID, PoolDetail>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&mut arg0.id, b"pools"), arg1)
    }

    fun get_real_amount(arg0: u32, arg1: u64, arg2: u64, arg3: u8) : u64 {
        let v0 = (((arg0 as u128) * (0x2::math::pow(10, arg3) as u128) * (0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::constant::BPS() as u128) / (arg2 as u128)) as u64);
        assert!(arg1 + v0 * 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::constant::SLIPPAGED_PERCENT() / 100 >= v0, 6);
        let v1 = arg1;
        if (arg1 > v0 + (((arg1 as u128) * (0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::constant::OVER_PERCENT() as u128) / 100) as u64)) {
            v1 = v0;
        };
        v1
    }

    public fun initArenaPool<T0>(arg0: &mut 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::PoolConfig, arg1: vector<u8>, arg2: u8, arg3: u16, arg4: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg5: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::assert_current_version(arg5);
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg4, 0x2::tx_context::sender(arg6)), 3);
        new_arena_pool<T0>(0x2::object::id<0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::PoolConfig>(arg0), arg1, arg2, 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::fund_addr(arg0), 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::expired_ms(arg0), arg3, 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::fee_cut(arg0), arg6);
    }

    entry fun joinPool<T0>(arg0: &mut 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::PoolConfig, arg1: &mut ArenaPool<T0>, arg2: u32, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::random::Random, arg9: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::assert_current_version(arg9);
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::is_use_native_random(arg0), 42);
        let (v0, v1, v2) = validate_data<T0>(arg1, arg0, arg2, 0x2::coin::value<T0>(&arg3), arg4, arg5, arg6, arg7, arg10);
        let (v3, v4) = join_pool<T0>(arg1, v0, v1, arg3, v2, 0x2::clock::timestamp_ms(arg7), arg10);
        if (v4) {
            let v5 = 0x2::tx_context::sender(arg10);
            random_winner<T0>(arg1, arg8, v0, v5, 0x2::clock::timestamp_ms(arg7), arg10);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    entry fun joinPool_v2<T0>(arg0: &mut 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::PoolConfig, arg1: &mut ArenaPool<T0>, arg2: u32, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::assert_current_version(arg8);
        assert!(!0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::is_use_native_random(arg0), 42);
        let (v0, v1, v2) = validate_data<T0>(arg1, arg0, arg2, 0x2::coin::value<T0>(&arg3), arg4, arg5, arg6, arg7, arg9);
        let (v3, v4) = join_pool<T0>(arg1, v0, v1, arg3, v2, 0x2::clock::timestamp_ms(arg7), arg9);
        if (v4) {
            random_winner_v2<T0>(arg1, v0, 0x2::tx_context::sender(arg9), 0x2::clock::timestamp_ms(arg7));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    fun join_pool<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: u32, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, bool) {
        assert!(pool_exists<T0>(arg0, arg1), 41);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg0.decimals;
        let v2 = get_pool<T0>(arg0, arg1);
        assert!(!check_user_joined(v2, v0), 25);
        let v3 = get_real_amount(v2.cost_in_usd, 0x2::coin::value<T0>(&arg3), arg4, v1);
        0x2::coin::put<T0>(&mut arg0.treasury, 0x2::coin::split<T0>(&mut arg3, v3, arg6));
        arg0.all_pool_users = arg0.all_pool_users + 1;
        let v4 = JoinedUserCountEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            user          : v0,
            num_users     : arg0.all_pool_users,
            joined_at     : arg5,
        };
        0x2::event::emit<JoinedUserCountEvent>(v4);
        let v5 = get_pool_mut<T0>(arg0, arg1);
        let v6 = v5.raised_amount + v3;
        let v7 = v5.num_users + 1;
        v5.num_users = v7;
        v5.raised_amount = v6;
        0x1::vector::push_back<address>(&mut v5.users_map, v0);
        0x2::table::add<address, u64>(&mut v5.user_amounts_map, v0, v3);
        let v8 = JoinEvent{
            pool_id       : arg1,
            raised_amount : v6,
            user          : v0,
            amount        : v3,
            decimals      : v1,
            max_users     : arg2,
            num_users     : v7,
            created_at    : arg5,
        };
        0x2::event::emit<JoinEvent>(v8);
        (arg3, v7 == arg2)
    }

    fun new_arena_pool<T0>(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u8, arg3: address, arg4: u64, arg5: u16, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg7);
        let v1 = ArenaPool<T0>{
            id             : v0,
            ticker         : arg1,
            decimals       : arg2,
            treasury       : 0x2::balance::zero<T0>(),
            pool_type      : arg5,
            pool_cfg_id    : arg0,
            fund_addr      : arg3,
            fee_cut        : arg6,
            expired_ms     : arg4,
            all_pool_users : 0,
            pool_count     : 0,
            latest_pools   : 0x2::table::new<u32, 0x2::object::ID>(arg7),
            pool_index_map : 0x2::table::new<u32, 0x2::object::ID>(arg7),
            is_deleted     : false,
        };
        0x2::dynamic_object_field::add<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&mut v1.id, b"pools", 0x2::table::new<0x2::object::ID, PoolDetail>(arg7));
        let v2 = ArenaPoolCreateEvent{
            arena_pool_id : 0x2::object::uid_to_inner(&v0),
            ticker        : 0x1::string::try_utf8(arg1),
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            decimals      : arg2,
            pool_type     : arg5,
            fund_addr     : arg3,
            expired_ms    : arg4,
            created_by    : 0x2::tx_context::sender(arg7),
            created_at    : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        0x2::transfer::share_object<ArenaPool<T0>>(v1);
        0x2::event::emit<ArenaPoolCreateEvent>(v2);
    }

    fun new_pool(arg0: 0x2::object::ID, arg1: u32, arg2: u64, arg3: u64, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, PoolDetail) {
        let v0 = PoolDetail{
            id               : 0x2::object::new(arg5),
            pool_index       : arg4,
            arena_pool_id    : arg0,
            cost_in_usd      : arg1,
            raised_amount    : 0,
            winner_amount    : 0,
            num_users        : 0,
            users_map        : 0x1::vector::empty<address>(),
            user_amounts_map : 0x2::table::new<address, u64>(arg5),
            winner           : 0,
            expired_ms       : arg2,
            expired_at       : arg3 + arg2,
            is_claimed       : false,
        };
        let v1 = 0x2::object::id<PoolDetail>(&v0);
        let v2 = PoolDetailCreateEvent{
            pool_id       : v1,
            pool_index    : arg4,
            arena_pool_id : arg0,
            cost_in_usd   : arg1,
            raised_amount : v0.raised_amount,
            expired_at    : v0.expired_at,
            created_by    : 0x2::tx_context::sender(arg5),
            created_at    : arg3,
        };
        0x2::event::emit<PoolDetailCreateEvent>(v2);
        (v1, v0)
    }

    fun pool_exists<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, PoolDetail>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&arg0.id, b"pools"), arg1)
    }

    fun random_winner<T0>(arg0: &mut ArenaPool<T0>, arg1: &0x2::random::Random, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(pool_exists<T0>(arg0, arg2), 41);
        let v0 = (arg0.fee_cut as u64);
        let v1 = get_pool_mut<T0>(arg0, arg2);
        let v2 = 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::sui_random::get_lucky_number(arg1, 1, v1.num_users, arg5);
        let v3 = v1.raised_amount;
        let v4 = v3 - ((v3 * v0 / 100) as u64);
        v1.winner = v2;
        v1.winner_amount = v4;
        let v5 = PoolWinnerEvent{
            pool_id    : arg2,
            pool_type  : arg0.pool_type,
            winner     : *0x1::vector::borrow<address>(&v1.users_map, ((v2 - 1) as u64)),
            amount     : v4,
            created_by : arg3,
            created_at : arg4,
        };
        0x2::event::emit<PoolWinnerEvent>(v5);
    }

    fun random_winner_v2<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        assert!(pool_exists<T0>(arg0, arg1), 41);
        let v0 = (arg0.fee_cut as u64);
        let v1 = get_pool_mut<T0>(arg0, arg1);
        let v2 = 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::custom_random::get_lucky_number(arg1, arg3, arg2, v1.num_users);
        let v3 = v1.raised_amount;
        let v4 = v3 - ((v3 * v0 / 100) as u64);
        v1.winner = ((v2 + 1) as u32);
        v1.winner_amount = v4;
        let v5 = PoolWinnerEvent{
            pool_id    : arg1,
            pool_type  : arg0.pool_type,
            winner     : *0x1::vector::borrow<address>(&v1.users_map, v2),
            amount     : v4,
            created_by : arg2,
            created_at : arg3,
        };
        0x2::event::emit<PoolWinnerEvent>(v5);
    }

    entry fun spinPool<T0>(arg0: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::PoolConfig, arg1: &mut ArenaPool<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::assert_current_version(arg5);
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::is_use_native_random(arg0), 42);
        assert!(pool_exists<T0>(arg1, arg2), 41);
        let v0 = get_pool<T0>(arg1, arg2);
        assert!(v0.expired_at < 0x2::clock::timestamp_ms(arg3), 23);
        assert!(v0.num_users >= 2, 27);
        assert!(v0.winner == 0, 24);
        let v1 = 0x2::tx_context::sender(arg6);
        random_winner<T0>(arg1, arg4, arg2, v1, 0x2::clock::timestamp_ms(arg3), arg6);
    }

    entry fun spinPool_v2<T0>(arg0: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::PoolConfig, arg1: &mut ArenaPool<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::assert_current_version(arg4);
        assert!(!0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::is_use_native_random(arg0), 42);
        assert!(pool_exists<T0>(arg1, arg2), 41);
        let v0 = get_pool<T0>(arg1, arg2);
        assert!(v0.expired_at < 0x2::clock::timestamp_ms(arg3), 23);
        assert!(v0.num_users >= 2, 27);
        assert!(v0.winner == 0, 24);
        random_winner_v2<T0>(arg1, arg2, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg3));
    }

    fun validate_data<T0>(arg0: &mut ArenaPool<T0>, arg1: &mut 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::PoolConfig, arg2: u32, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u32, u64) {
        assert!(!0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::is_paused(arg1), 101);
        assert!(!arg0.is_deleted, 40);
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::check_cost_support(arg1, arg2), 26);
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg7), 105);
        assert!(!0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::is_executed(arg1, arg6), 104);
        assert!(arg3 > 0, 0);
        assert!(arg4 > 0, 102);
        let v0 = 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::max_user(arg1, arg0.pool_type);
        assert!(v0 > 0, 28);
        if (0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::is_verify_sig(arg1)) {
            assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::signer::verify_signature(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::signer_pk(arg1), 0x2::tx_context::sender(arg8), arg4, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg5, arg6), 100);
        };
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config::set_executed(arg1, arg6);
        (check_and_create_pool<T0>(arg0, arg1, arg2, v0, 0x2::clock::timestamp_ms(arg7), arg8), v0, arg4)
    }

    public entry fun withdraw<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::version::assert_current_version(arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(pool_exists<T0>(arg0, arg1), 41);
        let v1 = get_pool_mut<T0>(arg0, arg1);
        assert!(v1.winner == 0, 24);
        if (v1.num_users > 1) {
            assert!(v1.expired_at + 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::constant::PENDING_WITHDRAW_MS() <= 0x2::clock::timestamp_ms(arg2), 23);
        };
        let v2 = 0;
        if (0x2::table::contains<address, u64>(&v1.user_amounts_map, v0)) {
            v2 = *0x2::table::borrow<address, u64>(&v1.user_amounts_map, v0);
        };
        assert!(v2 > 0, 2);
        0x2::table::remove<address, u64>(&mut v1.user_amounts_map, v0);
        let v3 = 0x2::balance::value<T0>(&arg0.treasury);
        if (v3 < v2) {
            v2 = v3;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v2, arg4), v0);
        let v4 = WithdrawEvent{
            pool_id    : arg1,
            user       : v0,
            amount     : v2,
            created_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

