module 0xd2a65413411e6be258c940ec8d15af798340bd62b6d17416a9018e2c03f23b01::arena {
    struct ArenaPool<phantom T0> has key {
        id: 0x2::object::UID,
        ticker: vector<u8>,
        treasury: 0x2::balance::Balance<T0>,
        pool_type: u16,
        pool_cfg_id: 0x2::object::ID,
        fund_addr: address,
        fee_cut: u32,
        expired_ms: u64,
        all_pool_users: u32,
        pool_count: u32,
        latest_pools: 0x2::table::Table<u32, 0x2::object::ID>,
        is_deleted: bool,
    }

    struct PoolDetail has store, key {
        id: 0x2::object::UID,
        arena_pool_id: 0x2::object::ID,
        cost_in_usd: u32,
        num_users: u32,
        users_map: vector<address>,
        user_amounts_map: 0x2::table::Table<address, u64>,
        winner: u32,
        expired_ms: u64,
        expired_at: u64,
        is_claimed: bool,
    }

    struct PoolConfig has key {
        id: 0x2::object::UID,
        owner: address,
        fund_addr: address,
        expired_ms: u64,
        fee_cut: u32,
        is_paused: bool,
        is_check_price: bool,
        cost_supports: vector<u32>,
    }

    struct JoinEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        max_users: u32,
        num_users: u32,
        created_at: u64,
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
        pool_type: u16,
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
        arena_pool_id: 0x2::object::ID,
        cost_in_usd: u32,
        expired_at: u64,
        created_by: address,
        created_at: u64,
    }

    struct PoolConfigUpdateEvent has copy, drop, store {
        owner: address,
        expired_ms: u64,
        fee_cut: u32,
        fund_addr: address,
        updated_at: u64,
    }

    struct PauseSystemEvent has copy, drop, store {
        value: bool,
        updated_by: address,
        updated_at: u64,
    }

    struct PoolWinnerEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_type: u16,
        winner: address,
        created_by: address,
        created_at: u64,
    }

    struct PoolOwnerCutEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        receiver: address,
        amount: u64,
        created_at: u64,
    }

    fun add_pool<T0>(arg0: &mut ArenaPool<T0>, arg1: PoolDetail) {
        let v0 = 0x2::object::id<PoolDetail>(&arg1);
        0x2::table::add<0x2::object::ID, PoolDetail>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&mut arg0.id, b"pools"), v0, arg1);
        arg0.pool_count = arg0.pool_count + 1;
        add_pool_map<T0>(arg0, v0, arg1.cost_in_usd);
    }

    fun add_pool_map<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: u32) {
        let v0 = get_key_for_pool_map(arg0.pool_type, arg2);
        if (0x2::table::contains<u32, 0x2::object::ID>(&arg0.latest_pools, v0)) {
            0x2::table::remove<u32, 0x2::object::ID>(&mut arg0.latest_pools, v0);
        };
        0x2::table::add<u32, 0x2::object::ID>(&mut arg0.latest_pools, v0, arg1);
    }

    public fun changeConfig(arg0: &mut PoolConfig, arg1: u32, arg2: u32, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(has_right(arg0, arg4), 3);
        assert!(arg1 > 1, 6);
        assert!(arg1 < 30, 5);
        let v0 = (arg1 as u64) * 86400000;
        arg0.expired_ms = v0;
        arg0.fee_cut = arg2;
        arg0.fund_addr = arg3;
        let v1 = PoolConfigUpdateEvent{
            owner      : arg0.owner,
            expired_ms : v0,
            fee_cut    : arg2,
            fund_addr  : arg3,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<PoolConfigUpdateEvent>(v1);
    }

    public fun changeOwner(arg0: &mut PoolConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : address {
        assert!(has_right(arg0, arg2), 3);
        assert!(arg0.owner != arg1, 16);
        arg0.owner = arg1;
        let v0 = PoolConfigUpdateEvent{
            owner      : arg0.owner,
            expired_ms : arg0.expired_ms,
            fee_cut    : arg0.fee_cut,
            fund_addr  : arg0.fund_addr,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<PoolConfigUpdateEvent>(v0);
        arg1
    }

    fun check_and_create_pool<T0>(arg0: &PoolConfig, arg1: &mut ArenaPool<T0>, arg2: u32, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = get_latest_pool_id<T0>(arg1, arg2);
        let v1 = false;
        if (0x1::option::is_none<0x2::object::ID>(&v0)) {
            v1 = true;
        } else {
            let v2 = 0x1::option::extract<0x2::object::ID>(&mut v0);
            if (!check_pool_available<T0>(arg0, arg1, v2, arg3)) {
                v1 = true;
            } else {
                v0 = 0x1::option::some<0x2::object::ID>(v2);
            };
        };
        if (v1) {
            let (v3, v4) = new_pool(0x2::object::id<ArenaPool<T0>>(arg1), arg2, arg1.expired_ms, arg3, arg4);
            add_pool<T0>(arg1, v4);
            v0 = 0x1::option::some<0x2::object::ID>(v3);
        };
        0x1::option::extract<0x2::object::ID>(&mut v0)
    }

    fun check_cost_support(arg0: &PoolConfig, arg1: u32) : bool {
        0x1::vector::contains<u32>(&arg0.cost_supports, &arg1)
    }

    fun check_pool_available<T0>(arg0: &PoolConfig, arg1: &ArenaPool<T0>, arg2: 0x2::object::ID, arg3: u64) : bool {
        let v0 = true;
        if (!pool_exists<T0>(arg1, arg2)) {
            v0 = false;
        } else {
            let v1 = get_pool<T0>(arg1, arg2);
            if (v1.num_users >= get_max_player(arg1.pool_type)) {
                v0 = false;
            };
            if (v1.expired_at <= arg3) {
                v0 = false;
            };
        };
        v0
    }

    fun check_user_joined(arg0: &PoolDetail, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.users_map, &arg1)
    }

    public entry fun claimWinner<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::balance::value<T0>(&arg0.treasury);
        assert!(v1 > 0, 4);
        assert!(pool_exists<T0>(arg0, arg1), 15);
        let v2 = get_pool_mut<T0>(arg0, arg1);
        assert!(!v2.is_claimed, 8);
        assert!(v2.winner > 0, 9);
        assert!(&v0 == 0x1::vector::borrow<address>(&v2.users_map, ((v2.winner - 1) as u64)), 7);
        v2.is_claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v1, arg2), v0);
        let v3 = ClaimEvent{
            pool_id    : arg1,
            user       : v0,
            amount     : v1,
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<ClaimEvent>(v3);
    }

    public fun deleteArenaPool<T0>(arg0: &PoolConfig, arg1: &mut ArenaPool<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(has_right(arg0, arg2), 3);
        assert!(arg1.all_pool_users == 0, 10);
        assert!(!arg1.is_deleted, 14);
        arg1.is_deleted = true;
        let v0 = ArenaPoolDeleteEvent{
            arena_pool_id : 0x2::object::id<ArenaPool<T0>>(arg1),
            created_by    : 0x2::tx_context::sender(arg2),
            created_at    : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<ArenaPoolDeleteEvent>(v0);
    }

    fun fee_owner_cut<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.fund_addr;
        let v1 = ((0x2::balance::value<T0>(&arg0.treasury) * (arg0.fee_cut as u64) / 100) as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v1, arg3), v0);
        let v2 = PoolOwnerCutEvent{
            pool_id    : arg1,
            receiver   : v0,
            amount     : v1,
            created_at : arg2,
        };
        0x2::event::emit<PoolOwnerCutEvent>(v2);
    }

    public fun getArenaData<T0>(arg0: &ArenaPool<T0>) : (u16, 0x2::object::ID, address, u32, u64, u32, u32, bool) {
        (arg0.pool_type, arg0.pool_cfg_id, arg0.fund_addr, arg0.fee_cut, arg0.expired_ms, arg0.all_pool_users, arg0.pool_count, arg0.is_deleted)
    }

    public fun getConfig(arg0: &PoolConfig) : (address, address, u64, u32, bool) {
        (arg0.owner, arg0.fund_addr, arg0.expired_ms, arg0.fee_cut, arg0.is_paused)
    }

    public fun getPoolData<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : (0x2::object::ID, u32, u32, u32, u64, bool) {
        assert!(pool_exists<T0>(arg0, arg1), 15);
        let v0 = get_pool<T0>(arg0, arg1);
        (v0.arena_pool_id, v0.cost_in_usd, v0.num_users, v0.winner, v0.expired_at, v0.is_claimed)
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

    fun get_max_player(arg0: u16) : u32 {
        let v0 = 0;
        if (arg0 == 0) {
            v0 = 2;
        } else if (arg0 == 1) {
            v0 = 10;
        } else if (arg0 == 2) {
            v0 = 100;
        };
        v0
    }

    fun get_pool<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID) : &PoolDetail {
        0x2::table::borrow<0x2::object::ID, PoolDetail>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&arg0.id, b"pools"), arg1)
    }

    fun get_pool_mut<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID) : &mut PoolDetail {
        0x2::table::borrow_mut<0x2::object::ID, PoolDetail>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&mut arg0.id, b"pools"), arg1)
    }

    fun get_price_token<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: u16) : u64 {
        if (arg1 == 0) {
            let (v0, v1) = 0x4dcb1a74837e2cb655c89155451242985020d9916b0a8374f0e1476500f7f105::prices::get_price<T0, T1>(arg0);
            return v1 / v0
        };
        let (v2, v3) = 0x4dcb1a74837e2cb655c89155451242985020d9916b0a8374f0e1476500f7f105::prices::get_price<T1, T0>(arg0);
        v2 / v3
    }

    fun has_right(arg0: &PoolConfig, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::sender(arg1) == arg0.owner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = PoolConfig{
            id             : 0x2::object::new(arg0),
            owner          : v0,
            fund_addr      : v0,
            expired_ms     : 604800000,
            fee_cut        : 10,
            is_paused      : false,
            is_check_price : false,
            cost_supports  : init_cost_support(),
        };
        let v2 = PoolConfigUpdateEvent{
            owner      : v0,
            expired_ms : v1.expired_ms,
            fee_cut    : v1.fee_cut,
            fund_addr  : v0,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<PoolConfigUpdateEvent>(v2);
        0x2::transfer::share_object<PoolConfig>(v1);
    }

    public fun initArenaPool<T0>(arg0: &mut PoolConfig, arg1: vector<u8>, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_right(arg0, arg3), 3);
        new_arena_pool<T0>(0x2::object::id<PoolConfig>(arg0), arg1, arg0.fund_addr, arg0.expired_ms, arg2, arg0.fee_cut, arg3);
    }

    fun init_cost_support() : vector<u32> {
        let v0 = 0x1::vector::empty<u32>();
        0x1::vector::push_back<u32>(&mut v0, 10);
        0x1::vector::push_back<u32>(&mut v0, 100);
        0x1::vector::push_back<u32>(&mut v0, 500);
        v0
    }

    entry fun joinPool<T0, T1>(arg0: &PoolConfig, arg1: &mut ArenaPool<T0>, arg2: u32, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg7: u16, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 17);
        assert!(!arg1.is_deleted, 14);
        assert!(check_cost_support(arg0, arg2), 13);
        let v0 = check_and_create_pool<T0>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg4), arg8);
        let v1 = 0;
        if (arg0.is_check_price == true) {
            v1 = get_price_token<T0, T1>(arg6, arg7);
        };
        join_pool<T0>(arg1, v0, arg3, v1, 0x2::clock::timestamp_ms(arg4), arg5, arg8);
    }

    fun join_pool<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg0.pool_type;
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > 0, 0);
        0x2::coin::put<T0>(&mut arg0.treasury, arg2);
        arg0.all_pool_users = arg0.all_pool_users + 1;
        assert!(pool_exists<T0>(arg0, arg1), 15);
        let v3 = get_pool_mut<T0>(arg0, arg1);
        assert!(!check_user_joined(v3, v0), 12);
        if (arg3 > 0) {
            assert!(v2 + v2 * 1 / 100 >= (v3.cost_in_usd as u64) / arg3, 6);
        };
        let v4 = v3.num_users + 1;
        v3.num_users = v4;
        0x1::vector::push_back<address>(&mut v3.users_map, v0);
        0x2::table::add<address, u64>(&mut v3.user_amounts_map, v0, v2);
        let v5 = get_max_player(v1);
        let v6 = JoinEvent{
            pool_id    : arg1,
            user       : v0,
            amount     : v2,
            max_users  : v5,
            num_users  : v4,
            created_at : arg4,
        };
        0x2::event::emit<JoinEvent>(v6);
        if (v3.num_users == v5) {
            random_winner<T0>(arg5, arg0, arg1, v0, arg4, arg6);
        };
    }

    fun new_arena_pool<T0>(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u16, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        let v1 = ArenaPool<T0>{
            id             : v0,
            ticker         : arg1,
            treasury       : 0x2::balance::zero<T0>(),
            pool_type      : arg4,
            pool_cfg_id    : arg0,
            fund_addr      : arg2,
            fee_cut        : arg5,
            expired_ms     : arg3,
            all_pool_users : 0,
            pool_count     : 0,
            latest_pools   : 0x2::table::new<u32, 0x2::object::ID>(arg6),
            is_deleted     : false,
        };
        0x2::dynamic_object_field::add<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&mut v1.id, b"pools", 0x2::table::new<0x2::object::ID, PoolDetail>(arg6));
        let v2 = ArenaPoolCreateEvent{
            arena_pool_id : 0x2::object::uid_to_inner(&v0),
            ticker        : 0x1::string::try_utf8(arg1),
            pool_type     : arg4,
            fund_addr     : arg2,
            created_by    : 0x2::tx_context::sender(arg6),
            created_at    : 0x2::tx_context::epoch_timestamp_ms(arg6),
        };
        0x2::transfer::share_object<ArenaPool<T0>>(v1);
        0x2::event::emit<ArenaPoolCreateEvent>(v2);
    }

    fun new_pool(arg0: 0x2::object::ID, arg1: u32, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, PoolDetail) {
        let v0 = PoolDetail{
            id               : 0x2::object::new(arg4),
            arena_pool_id    : arg0,
            cost_in_usd      : arg1,
            num_users        : 0,
            users_map        : 0x1::vector::empty<address>(),
            user_amounts_map : 0x2::table::new<address, u64>(arg4),
            winner           : 0,
            expired_ms       : arg2,
            expired_at       : arg3 + arg2,
            is_claimed       : false,
        };
        let v1 = 0x2::object::id<PoolDetail>(&v0);
        let v2 = PoolDetailCreateEvent{
            pool_id       : v1,
            arena_pool_id : arg0,
            cost_in_usd   : arg1,
            expired_at    : v0.expired_at,
            created_by    : 0x2::tx_context::sender(arg4),
            created_at    : arg3,
        };
        0x2::event::emit<PoolDetailCreateEvent>(v2);
        (v1, v0)
    }

    public entry fun pauseSystem(arg0: &mut PoolConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(has_right(arg0, arg1), 3);
        arg0.is_paused = true;
        let v0 = PauseSystemEvent{
            value      : true,
            updated_by : 0x2::tx_context::sender(arg1),
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<PauseSystemEvent>(v0);
    }

    fun pool_exists<T0>(arg0: &ArenaPool<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, PoolDetail>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0x2::object::ID, PoolDetail>>(&arg0.id, b"pools"), arg1)
    }

    fun random_winner<T0>(arg0: &0x2::random::Random, arg1: &mut ArenaPool<T0>, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(pool_exists<T0>(arg1, arg2), 15);
        let v0 = get_pool_mut<T0>(arg1, arg2);
        let v1 = 0xd2a65413411e6be258c940ec8d15af798340bd62b6d17416a9018e2c03f23b01::random::get_lucky_number(arg0, 0, v0.num_users, arg5);
        v0.winner = v1 + 1;
        fee_owner_cut<T0>(arg1, arg2, arg4, arg5);
        let v2 = PoolWinnerEvent{
            pool_id    : arg2,
            pool_type  : arg1.pool_type,
            winner     : *0x1::vector::borrow<address>(&v0.users_map, (v1 as u64)),
            created_by : arg3,
            created_at : arg4,
        };
        0x2::event::emit<PoolWinnerEvent>(v2);
    }

    public fun setIsCheckPrice(arg0: &mut PoolConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_right(arg0, arg2), 3);
        arg0.is_check_price = arg1;
    }

    entry fun spinPool<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = arg0.pool_type;
        assert!(pool_exists<T0>(arg0, arg1), 15);
        let v2 = get_pool_mut<T0>(arg0, arg1);
        assert!(v2.num_users < get_max_player(v1), 10);
        assert!(v2.winner > 0, 11);
        random_winner<T0>(arg3, arg0, arg1, v0, 0x2::clock::timestamp_ms(arg2), arg4);
    }

    public entry fun unPauseSystem(arg0: &mut PoolConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(has_right(arg0, arg1), 3);
        arg0.is_paused = false;
        let v0 = PauseSystemEvent{
            value      : false,
            updated_by : 0x2::tx_context::sender(arg1),
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<PauseSystemEvent>(v0);
    }

    public entry fun withdraw<T0>(arg0: &mut ArenaPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(pool_exists<T0>(arg0, arg1), 15);
        let v1 = get_pool_mut<T0>(arg0, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1.expired_at <= v2, 10);
        let v3 = 0;
        if (0x2::table::contains<address, u64>(&v1.user_amounts_map, v0)) {
            v3 = *0x2::table::borrow<address, u64>(&v1.user_amounts_map, v0);
        };
        assert!(v3 > 0, 2);
        0x2::table::remove<address, u64>(&mut v1.user_amounts_map, v0);
        let v4 = 0x2::balance::value<T0>(&arg0.treasury);
        if (v4 < v3) {
            v3 = v4;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v3, arg3), v0);
        let v5 = WithdrawEvent{
            pool_id    : arg1,
            user       : v0,
            amount     : v3,
            created_at : v2,
        };
        0x2::event::emit<WithdrawEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

