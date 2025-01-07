module 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::controller {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolCreatedEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        base: 0x1::ascii::String,
        quote: 0x1::ascii::String,
        max_lot_size: u64,
        min_lot_size: u64,
        max_order_size: u64,
        min_order_size: u64,
    }

    struct DepositEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
    }

    struct PauseEvent has copy, drop, store {
        sender: address,
    }

    struct UnpauseEvent has copy, drop, store {
        sender: address,
    }

    struct UpgradeEvent has copy, drop, store {
        sender: address,
        from_version: u64,
        to_version: u64,
    }

    public entry fun create_pool<T0, T1>(arg0: &AdminCap, arg1: &0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::State, arg2: &mut 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::registry::Registry, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::assert_version(arg1);
        let v0 = 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::create_pool<T0, T1>(arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x2::object::id<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::Pool<T0, T1>>(&v0);
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::registry::register_pool<T0, T1>(arg2, v1);
        0x2::transfer::public_share_object<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::Pool<T0, T1>>(v0);
        let v2 = PoolCreatedEvent{
            sender         : 0x2::tx_context::sender(arg7),
            pool_id        : v1,
            base           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote          : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            max_lot_size   : arg3,
            min_lot_size   : arg4,
            max_order_size : arg5,
            min_order_size : arg6,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
    }

    public entry fun deposit<T0, T1>(arg0: &AdminCap, arg1: &0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::State, arg2: &mut 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::tx_context::TxContext) {
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::assert_version(arg1);
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::deposit<T0, T1>(arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4));
        let v0 = DepositEvent{
            sender       : 0x2::tx_context::sender(arg5),
            pool_id      : 0x2::object::id<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::Pool<T0, T1>>(arg2),
            base_amount  : 0x2::coin::value<T0>(&arg3),
            quote_amount : 0x2::coin::value<T1>(&arg4),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun pause(arg0: &AdminCap, arg1: &mut 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::State, arg2: &0x2::tx_context::TxContext) {
        if (!0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::is_paused(arg1)) {
            0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::pause(arg1);
            let v0 = PauseEvent{sender: 0x2::tx_context::sender(arg2)};
            0x2::event::emit<PauseEvent>(v0);
        };
    }

    public entry fun set_guardians(arg0: &AdminCap, arg1: &mut 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::State, arg2: vector<vector<u8>>) {
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::assert_version(arg1);
        assert!(0x1::vector::length<vector<u8>>(&arg2) > 0, 1);
        let v0 = 0x1::vector::empty<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian::Guardian>();
        0x1::vector::reverse<vector<u8>>(&mut arg2);
        while (0x1::vector::length<vector<u8>>(&arg2) != 0) {
            0x1::vector::push_back<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian::Guardian>(&mut v0, 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian::new(0x1::vector::pop_back<vector<u8>>(&mut arg2)));
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::set_guardians(arg1, v0);
    }

    public entry fun set_quote_seconds_to_live(arg0: &AdminCap, arg1: &mut 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::State, arg2: u32) {
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::assert_version(arg1);
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::set_quote_seconds_to_live(arg1, arg2);
    }

    public entry fun setup(arg0: &AdminCap, arg1: u32, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg2) > 0, 1);
        let v0 = 0x1::vector::empty<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian::Guardian>();
        0x1::vector::reverse<vector<u8>>(&mut arg2);
        while (0x1::vector::length<vector<u8>>(&arg2) != 0) {
            0x1::vector::push_back<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian::Guardian>(&mut v0, 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian::new(0x1::vector::pop_back<vector<u8>>(&mut arg2)));
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        0x2::transfer::public_share_object<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::State>(0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::new(arg1, v0, arg3));
    }

    public entry fun unpause(arg0: &AdminCap, arg1: &mut 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::State, arg2: &0x2::tx_context::TxContext) {
        if (0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::is_paused(arg1)) {
            0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::unpause(arg1);
            let v0 = UnpauseEvent{sender: 0x2::tx_context::sender(arg2)};
            0x2::event::emit<UnpauseEvent>(v0);
        };
    }

    public entry fun update_pool_config<T0, T1>(arg0: &AdminCap, arg1: &0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::State, arg2: &mut 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::assert_version(arg1);
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::update_pool_config<T0, T1>(arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun upgrade(arg0: &AdminCap, arg1: &mut 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::State, arg2: &0x2::tx_context::TxContext) {
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::upgrade(arg1);
        let v0 = UpgradeEvent{
            sender       : 0x2::tx_context::sender(arg2),
            from_version : 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::version(arg1),
            to_version   : 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::version(arg1),
        };
        0x2::event::emit<UpgradeEvent>(v0);
    }

    public entry fun withdraw<T0, T1>(arg0: &AdminCap, arg1: &0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::State, arg2: &mut 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state::assert_version(arg1);
        let v0 = 0x1::u64::min(0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::base_balance<T0, T1>(arg2), arg3);
        let v1 = 0x1::u64::min(0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::quote_balance<T0, T1>(arg2), arg4);
        let (v2, v3) = 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::withdraw<T0, T1>(arg2, v0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg5), 0x2::tx_context::sender(arg5));
        let v4 = WithdrawEvent{
            sender       : 0x2::tx_context::sender(arg5),
            pool_id      : 0x2::object::id<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool::Pool<T0, T1>>(arg2),
            base_amount  : v0,
            quote_amount : v1,
        };
        0x2::event::emit<WithdrawEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

