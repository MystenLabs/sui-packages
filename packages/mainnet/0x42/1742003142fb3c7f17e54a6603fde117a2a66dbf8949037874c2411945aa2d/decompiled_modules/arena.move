module 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::arena {
    struct ArenaPool<phantom T0> has key {
        id: 0x2::object::UID,
        ticker: vector<u8>,
        decimals: u8,
        treasury: 0x2::balance::Balance<T0>,
        pool_cfg_id: 0x2::object::ID,
        fund_addr: address,
        fee_cut: u32,
        fee_cut_creator: u32,
        all_pool_users: u32,
        pool_count: u32,
        pool_index_map: 0x2::table::Table<u32, 0x2::object::ID>,
        is_deleted: bool,
    }

    struct PoolDetail has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        pool_index: u32,
        arena_pool_id: 0x2::object::ID,
        amount_to_join: u64,
        raised_amount: u64,
        winner_amount: u64,
        creator_amount: u64,
        max_user: u32,
        num_users: u32,
        users_map: vector<address>,
        user_amounts_map: 0x2::table::Table<address, u64>,
        winner: u32,
        spin_by_creator: bool,
        creator: address,
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
        max_user: u32,
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

    struct CreatorShareFeeEvent has copy, drop, store {
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
        fund_addr: address,
        created_by: address,
        created_at: u64,
    }

    struct ArenaPoolDeleteEvent has copy, drop, store {
        arena_pool_id: 0x2::object::ID,
        created_by: address,
        created_at: u64,
    }

    struct PoolDetailCreateEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        name: vector<u8>,
        pool_index: u32,
        arena_pool_id: 0x2::object::ID,
        spin_by_creator: bool,
        amount_to_join: u64,
        raised_amount: u64,
        max_user: u32,
        expired_at: u64,
        created_by: address,
        created_at: u64,
    }

    struct PoolWinnerEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        max_user: u32,
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
    }

    fun calc_price(arg0: u64, arg1: u64, arg2: u8) : u32 {
        (((arg0 as u128) * (arg1 as u128) / (0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::constant::BPS() as u128) * (0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::constant::BPS_FOR_COST() as u128) / (0x2::math::pow(10, arg2) as u128)) as u32)
    }

    fun check_user_joined(arg0: &PoolDetail, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.users_map, &arg1)
    }

    public entry fun claimWinner<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::assert_current_version(arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(pool_exists<T0>(arg0, arg1), 41);
        assert!(0x2::balance::value<T0>(&arg0.treasury) > 0, 4);
        let v1 = get_pool<T0>(arg0, arg1);
        assert!(v1.winner > 0, 22);
        assert!(!v1.is_claimed, 21);
        assert!(&v0 == 0x1::vector::borrow<address>(&v1.users_map, ((v1.winner - 1) as u64)), 20);
        let v2 = v1.winner_amount;
        let v3 = v1.creator_amount;
        let v4 = v1.creator;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v2, arg4), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v3, arg4), v4);
        get_pool_mut<T0>(arg0, arg1).is_claimed = true;
        let v5 = ClaimEvent{
            pool_id    : arg1,
            user       : v0,
            amount     : v2,
            created_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ClaimEvent>(v5);
        let v6 = CreatorShareFeeEvent{
            pool_id    : arg1,
            user       : v4,
            amount     : v3,
            created_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CreatorShareFeeEvent>(v6);
    }

    entry fun createPool<T0>(arg0: &mut 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::PoolConfig, arg1: &mut ArenaPool<T0>, arg2: vector<u8>, arg3: u32, arg4: u64, arg5: bool, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::Version, arg12: &mut 0x2::tx_context::TxContext) {
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::assert_current_version(arg11);
        let v0 = validate_and_create_pool<T0>(arg1, arg0, arg2, arg4, arg5, arg3, 0x2::coin::value<T0>(&arg6), arg7, arg8, arg9, arg10, arg12);
        let (v1, _) = join_pool<T0>(arg1, v0, arg6, 0x2::clock::timestamp_ms(arg10), arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg12));
    }

    fun create_pool_detail<T0>(arg0: &mut ArenaPool<T0>, arg1: &mut 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::PoolConfig, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u32, arg6: bool, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::pool_count(arg1);
        let (v1, v2) = new_pool(0x2::object::id<ArenaPool<T0>>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, v0, arg8);
        add_pool<T0>(arg0, v2, v0);
        arg0.pool_count = arg0.pool_count + 1;
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::increase_pcount(arg1);
        v1
    }

    entry fun deleteArenaPool<T0>(arg0: &mut ArenaPool<T0>, arg1: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg2: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::assert_current_version(arg2);
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg1, 0x2::tx_context::sender(arg4)), 3);
        assert!(!arg0.is_deleted, 40);
        arg0.is_deleted = true;
        let v0 = ArenaPoolDeleteEvent{
            arena_pool_id : 0x2::object::id<ArenaPool<T0>>(arg0),
            created_by    : 0x2::tx_context::sender(arg4),
            created_at    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ArenaPoolDeleteEvent>(v0);
    }

    public fun getArenaData<T0>(arg0: &ArenaPool<T0>) : (0x2::object::ID, address, u32, u32, u32, u32, bool) {
        (arg0.pool_cfg_id, arg0.fund_addr, arg0.fee_cut, arg0.fee_cut_creator, arg0.all_pool_users, arg0.pool_count, arg0.is_deleted)
    }

    public fun getPoolData<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID) : (0x2::object::ID, vector<u8>, u32, u64, u64, u64, u64, u32, u32, u32, u64, bool) {
        get_pool_data<T0>(arg0, arg1)
    }

    public fun getPoolDataByIndex<T0>(arg0: &ArenaPool<T0>, arg1: u32) : (0x2::object::ID, vector<u8>, u32, u64, u64, u64, u64, u32, u32, u32, u64, bool) {
        let v0 = get_pool_id_by_index<T0>(arg0, arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 41);
        get_pool_data<T0>(arg0, 0x1::option::extract<0x2::object::ID>(&mut v0))
    }

    fun get_pool<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID) : &PoolDetail {
        0x2::table::borrow<0x2::object::ID, PoolDetail>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&arg0.id, b"pools"), arg1)
    }

    fun get_pool_data<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID) : (0x2::object::ID, vector<u8>, u32, u64, u64, u64, u64, u32, u32, u32, u64, bool) {
        assert!(pool_exists<T0>(arg0, arg1), 41);
        let v0 = get_pool<T0>(arg0, arg1);
        (v0.arena_pool_id, v0.name, v0.pool_index, v0.amount_to_join, v0.raised_amount, v0.winner_amount, v0.creator_amount, v0.max_user, v0.num_users, v0.winner, v0.expired_at, v0.is_claimed)
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

    public fun initArenaPool<T0>(arg0: &mut 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::PoolConfig, arg1: vector<u8>, arg2: u8, arg3: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg4: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::assert_current_version(arg4);
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg3, 0x2::tx_context::sender(arg6)), 3);
        new_arena_pool<T0>(0x2::object::id<0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::PoolConfig>(arg0), arg1, arg2, 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::fund_addr(arg0), 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::fee_cut(arg0), 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::fee_cut_creator(arg0), arg5, arg6);
    }

    entry fun joinPool<T0>(arg0: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::PoolConfig, arg1: &mut ArenaPool<T0>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::assert_current_version(arg6);
        validate_join<T0>(arg1, arg0, arg2, 0x2::coin::value<T0>(&arg3), arg4, arg7);
        let (v0, v1) = join_pool<T0>(arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4), arg7);
        if (v1) {
            let v2 = if (0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::is_use_native_random(arg0)) {
                let v3 = 0x2::tx_context::sender(arg7);
                random_winner<T0>(arg1, arg5, arg2, v3, 0x2::clock::timestamp_ms(arg4), arg7)
            } else {
                random_winner_v2<T0>(arg1, arg2, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg4))
            };
            transfer_amount<T0>(arg1, arg2, v2, arg4, arg7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
    }

    fun join_pool<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, bool) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = get_pool<T0>(arg0, arg1);
        let v2 = v1.max_user;
        let v3 = v1.amount_to_join;
        0x2::coin::put<T0>(&mut arg0.treasury, 0x2::coin::split<T0>(&mut arg2, v3, arg4));
        arg0.all_pool_users = arg0.all_pool_users + 1;
        let v4 = JoinedUserCountEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            user          : v0,
            num_users     : arg0.all_pool_users,
            joined_at     : arg3,
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
            decimals      : arg0.decimals,
            max_user      : v2,
            num_users     : v7,
            created_at    : arg3,
        };
        0x2::event::emit<JoinEvent>(v8);
        (arg2, v7 == v2)
    }

    fun new_arena_pool<T0>(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u8, arg3: address, arg4: u32, arg5: u32, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg7);
        let v1 = ArenaPool<T0>{
            id              : v0,
            ticker          : arg1,
            decimals        : arg2,
            treasury        : 0x2::balance::zero<T0>(),
            pool_cfg_id     : arg0,
            fund_addr       : arg3,
            fee_cut         : arg4,
            fee_cut_creator : arg5,
            all_pool_users  : 0,
            pool_count      : 0,
            pool_index_map  : 0x2::table::new<u32, 0x2::object::ID>(arg7),
            is_deleted      : false,
        };
        0x2::dynamic_object_field::add<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&mut v1.id, b"pools", 0x2::table::new<0x2::object::ID, PoolDetail>(arg7));
        let v2 = ArenaPoolCreateEvent{
            arena_pool_id : 0x2::object::uid_to_inner(&v0),
            ticker        : 0x1::string::try_utf8(arg1),
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            decimals      : arg2,
            fund_addr     : arg3,
            created_by    : 0x2::tx_context::sender(arg7),
            created_at    : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::transfer::share_object<ArenaPool<T0>>(v1);
        0x2::event::emit<ArenaPoolCreateEvent>(v2);
    }

    fun new_pool(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u32, arg5: bool, arg6: u64, arg7: u32, arg8: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, PoolDetail) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = PoolDetail{
            id               : 0x2::object::new(arg8),
            name             : arg1,
            pool_index       : arg7,
            arena_pool_id    : arg0,
            amount_to_join   : arg3,
            raised_amount    : 0,
            winner_amount    : 0,
            creator_amount   : 0,
            max_user         : arg4,
            num_users        : 0,
            users_map        : 0x1::vector::empty<address>(),
            user_amounts_map : 0x2::table::new<address, u64>(arg8),
            winner           : 0,
            spin_by_creator  : arg5,
            creator          : v0,
            expired_ms       : arg2,
            expired_at       : arg6 + arg2,
            is_claimed       : false,
        };
        let v2 = 0x2::object::id<PoolDetail>(&v1);
        let v3 = PoolDetailCreateEvent{
            pool_id         : v2,
            name            : arg1,
            pool_index      : arg7,
            arena_pool_id   : arg0,
            spin_by_creator : arg5,
            amount_to_join  : arg3,
            raised_amount   : 0,
            max_user        : arg4,
            expired_at      : v1.expired_at,
            created_by      : v0,
            created_at      : arg6,
        };
        0x2::event::emit<PoolDetailCreateEvent>(v3);
        (v2, v1)
    }

    fun pool_exists<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, PoolDetail>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&arg0.id, b"pools"), arg1)
    }

    fun random_winner<T0>(arg0: &mut ArenaPool<T0>, arg1: &0x2::random::Random, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(pool_exists<T0>(arg0, arg2), 41);
        let v0 = (arg0.fee_cut as u64);
        let v1 = (arg0.fee_cut_creator as u64);
        let v2 = get_pool_mut<T0>(arg0, arg2);
        let v3 = 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::sui_random::get_lucky_number(arg1, 1, v2.num_users, arg5);
        let v4 = v2.raised_amount;
        let v5 = ((v4 * v1 / 100) as u64);
        let v6 = ((v4 * v0 / 100) as u64);
        let v7 = v4 - v6 - v5;
        v2.winner = v3;
        v2.winner_amount = v7;
        v2.creator_amount = v5;
        let v8 = PoolWinnerEvent{
            pool_id    : arg2,
            max_user   : v2.max_user,
            winner     : *0x1::vector::borrow<address>(&v2.users_map, ((v3 - 1) as u64)),
            amount     : v7,
            created_by : arg3,
            created_at : arg4,
        };
        0x2::event::emit<PoolWinnerEvent>(v8);
        v6
    }

    fun random_winner_v2<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64) : u64 {
        assert!(pool_exists<T0>(arg0, arg1), 41);
        let v0 = (arg0.fee_cut as u64);
        let v1 = (arg0.fee_cut_creator as u64);
        let v2 = get_pool_mut<T0>(arg0, arg1);
        let v3 = 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::custom_random::get_lucky_number(arg1, arg3, arg2, v2.num_users);
        let v4 = v2.raised_amount;
        let v5 = ((v4 * v1 / 100) as u64);
        let v6 = ((v4 * v0 / 100) as u64);
        let v7 = v4 - v6 - v5;
        v2.winner = ((v3 + 1) as u32);
        v2.winner_amount = v7;
        v2.creator_amount = v5;
        let v8 = PoolWinnerEvent{
            pool_id    : arg1,
            max_user   : v2.max_user,
            winner     : *0x1::vector::borrow<address>(&v2.users_map, v3),
            amount     : v7,
            created_by : arg2,
            created_at : arg3,
        };
        0x2::event::emit<PoolWinnerEvent>(v8);
        v6
    }

    entry fun spinPool<T0>(arg0: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::PoolConfig, arg1: &mut ArenaPool<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::assert_current_version(arg5);
        assert!(pool_exists<T0>(arg1, arg2), 41);
        let v0 = get_pool<T0>(arg1, arg2);
        assert!(v0.num_users >= 2, 27);
        let v1 = 0x2::tx_context::sender(arg6);
        if (0x2::clock::timestamp_ms(arg3) < v0.expired_at) {
            assert!(!0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::prevent_spin_early(arg0), 23);
            if (v0.num_users < v0.max_user) {
                let v2 = true;
                if (v0.spin_by_creator && v1 != v0.creator) {
                    v2 = false;
                };
                assert!(v2, 30);
            };
        };
        assert!(v0.winner == 0, 24);
        let v3 = if (0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::is_use_native_random(arg0)) {
            random_winner<T0>(arg1, arg4, arg2, v1, 0x2::clock::timestamp_ms(arg3), arg6)
        } else {
            random_winner_v2<T0>(arg1, arg2, v1, 0x2::clock::timestamp_ms(arg3))
        };
        transfer_amount<T0>(arg1, arg2, v3, arg3, arg6);
    }

    fun transfer_amount<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.treasury) > 0, 4);
        let v0 = arg0.fund_addr;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, arg2, arg4), v0);
        let v1 = PoolOwnerCutEvent{
            pool_id    : arg1,
            receiver   : v0,
            amount     : arg2,
            created_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PoolOwnerCutEvent>(v1);
    }

    fun validate_and_create_pool<T0>(arg0: &mut ArenaPool<T0>, arg1: &mut 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::PoolConfig, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: u32, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::is_paused(arg1), 101);
        assert!(!arg0.is_deleted, 40);
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::check_time_to_join_support(arg1, arg3), 31);
        assert!(arg5 > 1, 32);
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::check_max_user_support(arg1, arg5), 28);
        assert!(0x2::clock::timestamp_ms(arg10) < arg8, 105);
        assert!(arg6 > 0, 0);
        assert!(arg7 > 0, 102);
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::check_required_cost(arg1, calc_price(arg6, arg7, arg0.decimals)), 103);
        if (0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::is_verify_sig(arg1)) {
            assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::signer::verify_signature(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::signer_pk(arg1), 0x2::tx_context::sender(arg11), arg7, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg8, arg9), 100);
        };
        assert!(!0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::is_executed(arg1, arg9), 104);
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::set_executed(arg1, arg9);
        create_pool_detail<T0>(arg0, arg1, arg2, arg3, arg6, arg5, arg4, 0x2::clock::timestamp_ms(arg10), arg11)
    }

    fun validate_join<T0>(arg0: &ArenaPool<T0>, arg1: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::PoolConfig, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config::is_paused(arg1), 101);
        assert!(!arg0.is_deleted, 40);
        assert!(pool_exists<T0>(arg0, arg2), 41);
        let v0 = get_pool<T0>(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg4) < v0.expired_at, 29);
        assert!(arg3 > 0, 0);
        assert!(arg3 >= v0.amount_to_join, 34);
        assert!(!check_user_joined(v0, 0x2::tx_context::sender(arg5)), 25);
        assert!(v0.winner == 0, 24);
        assert!(v0.num_users < v0.max_user, 33);
        arg2
    }

    public entry fun withdraw<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::version::assert_current_version(arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(pool_exists<T0>(arg0, arg1), 41);
        let v1 = get_pool_mut<T0>(arg0, arg1);
        assert!(v1.winner == 0, 24);
        if (v1.num_users > 1) {
            assert!(v1.expired_at + 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::constant::PENDING_WITHDRAW_MS() <= 0x2::clock::timestamp_ms(arg2), 23);
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

