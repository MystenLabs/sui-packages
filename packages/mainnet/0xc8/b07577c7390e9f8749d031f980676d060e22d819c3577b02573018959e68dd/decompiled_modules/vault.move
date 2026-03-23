module 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BorrowReceipt {
        vault_id: 0x2::object::ID,
        borrowed_amount: u64,
    }

    struct CapReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        idle_balance: 0x2::balance::Balance<USDC>,
        invested_assets: 0x2::bag::Bag,
        total_receipts: u64,
        current_strategy: u8,
        last_heartbeat_tvl: u64,
        max_tvl_cap: u64,
        performance_fee_bps: u64,
        fee_recipient: address,
        treasury_cap: 0x2::coin::TreasuryCap<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT>,
        vote_locks: 0x2::table::Table<address, u64>,
        auto_paused: bool,
    }

    struct USDC has drop {
        dummy_field: bool,
    }

    struct DepositEvent has copy, drop {
        user: address,
        usdc_amount: u64,
        receipts_minted: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        receipts_burned: u64,
        usdc_returned: u64,
    }

    struct RerouteEvent has copy, drop {
        from_strategy: u8,
        to_strategy: u8,
    }

    struct AutoPauseEvent has copy, drop {
        paused: bool,
    }

    struct HeartbeatTvlEvent has copy, drop {
        tvl: u64,
    }

    public fun borrow_all_for_strategy(arg0: &mut Vault) : (0x2::balance::Balance<USDC>, BorrowReceipt) {
        assert!(!arg0.auto_paused, 204);
        let v0 = BorrowReceipt{
            vault_id        : 0x2::object::id<Vault>(arg0),
            borrowed_amount : 0x2::balance::value<USDC>(&arg0.idle_balance),
        };
        (0x2::balance::withdraw_all<USDC>(&mut arg0.idle_balance), v0)
    }

    public fun borrow_idle_balance_mut(arg0: &mut Vault) : &mut 0x2::balance::Balance<USDC> {
        &mut arg0.idle_balance
    }

    public fun borrow_protocol_cap<T0: store + key>(arg0: &mut Vault, arg1: 0x1::string::String) : (T0, CapReceipt<T0>) {
        let v0 = CapReceipt<T0>{vault_id: 0x2::object::id<Vault>(arg0)};
        (0x2::dynamic_object_field::remove<0x1::string::String, T0>(&mut arg0.id, arg1), v0)
    }

    public fun borrow_treasury_ref(arg0: &Vault, arg1: &AdminCap) : &0x2::coin::TreasuryCap<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT> {
        &arg0.treasury_cap
    }

    public fun burn_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun cleanup_expired_lock(arg0: &mut Vault, arg1: address, arg2: &0x2::clock::Clock) {
        if (0x2::table::contains<address, u64>(&arg0.vote_locks, arg1)) {
            if (0x2::clock::timestamp_ms(arg2) > *0x2::table::borrow<address, u64>(&arg0.vote_locks, arg1)) {
                0x2::table::remove<address, u64>(&mut arg0.vote_locks, arg1);
            };
        };
    }

    public fun commit_strategy<T0>(arg0: &mut Vault, arg1: BorrowReceipt, arg2: 0x2::balance::Balance<T0>, arg3: u8, arg4: u64) {
        assert!(0x2::object::id<Vault>(arg0) == arg1.vault_id, 201);
        assert!(arg3 != 0, 202);
        let v0 = arg1.borrowed_amount;
        if (v0 > 0) {
            assert!(arg4 >= v0 - v0 * 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::max_slippage_ceil() / 10000, 207);
        };
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.invested_assets, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.invested_assets, v1), arg2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.invested_assets, v1, arg2);
        };
        arg0.current_strategy = arg3;
        let v2 = RerouteEvent{
            from_strategy : 0,
            to_strategy   : arg3,
        };
        0x2::event::emit<RerouteEvent>(v2);
        let BorrowReceipt {
            vault_id        : _,
            borrowed_amount : _,
        } = arg1;
    }

    public fun create_vault(arg0: 0x2::coin::TreasuryCap<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id                  : 0x2::object::new(arg3),
            idle_balance        : 0x2::balance::zero<USDC>(),
            invested_assets     : 0x2::bag::new(arg3),
            total_receipts      : 0,
            current_strategy    : 0,
            last_heartbeat_tvl  : 0,
            max_tvl_cap         : arg2,
            performance_fee_bps : 0,
            fee_recipient       : arg1,
            treasury_cap        : arg0,
            vote_locks          : 0x2::table::new<address, u64>(arg3),
            auto_paused         : false,
        };
        0x2::transfer::share_object<Vault>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun current_strategy(arg0: &Vault) : u8 {
        arg0.current_strategy
    }

    public fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<USDC>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT> {
        assert!(!arg0.auto_paused, 204);
        let v0 = 0x2::coin::value<USDC>(&arg1);
        assert!(v0 > 0, 200);
        let v1 = if (arg0.last_heartbeat_tvl == 0) {
            0x2::balance::value<USDC>(&arg0.idle_balance)
        } else {
            arg0.last_heartbeat_tvl
        };
        assert!(v1 + v0 <= arg0.max_tvl_cap, 205);
        let v2 = if (arg0.last_heartbeat_tvl == 0) {
            0x2::balance::value<USDC>(&arg0.idle_balance)
        } else {
            arg0.last_heartbeat_tvl
        };
        let v3 = if (arg0.total_receipts == 0 || v2 == 0) {
            v0
        } else {
            (((v0 as u128) * (arg0.total_receipts as u128) / (v2 as u128)) as u64)
        };
        0x2::coin::put<USDC>(&mut arg0.idle_balance, arg1);
        arg0.total_receipts = arg0.total_receipts + v3;
        let v4 = DepositEvent{
            user            : 0x2::tx_context::sender(arg2),
            usdc_amount     : v0,
            receipts_minted : v3,
        };
        0x2::event::emit<DepositEvent>(v4);
        0x2::token::mint<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT>(&mut arg0.treasury_cap, v3, arg2)
    }

    public fun fee_recipient(arg0: &Vault) : address {
        arg0.fee_recipient
    }

    public fun idle_balance(arg0: &Vault) : u64 {
        0x2::balance::value<USDC>(&arg0.idle_balance)
    }

    public fun is_auto_paused(arg0: &Vault) : bool {
        arg0.auto_paused
    }

    public fun last_heartbeat_tvl(arg0: &Vault) : u64 {
        arg0.last_heartbeat_tvl
    }

    public fun max_tvl_cap(arg0: &Vault) : u64 {
        arg0.max_tvl_cap
    }

    public fun performance_fee_bps(arg0: &Vault) : u64 {
        arg0.performance_fee_bps
    }

    public fun repay_withdraw(arg0: &mut Vault, arg1: BorrowReceipt, arg2: 0x2::coin::Coin<USDC>) {
        assert!(0x2::object::id<Vault>(arg0) == arg1.vault_id, 201);
        0x2::balance::join<USDC>(&mut arg0.idle_balance, 0x2::coin::into_balance<USDC>(arg2));
        arg0.current_strategy = 0;
        let BorrowReceipt {
            vault_id        : _,
            borrowed_amount : _,
        } = arg1;
    }

    public fun return_protocol_cap<T0: store + key>(arg0: &mut Vault, arg1: 0x1::string::String, arg2: T0, arg3: CapReceipt<T0>) {
        assert!(0x2::object::id<Vault>(arg0) == arg3.vault_id, 201);
        let CapReceipt {  } = arg3;
        0x2::dynamic_object_field::add<0x1::string::String, T0>(&mut arg0.id, arg1, arg2);
    }

    public fun set_vote_lock(arg0: &mut Vault, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = if (arg2 > v0) {
            arg2 - v0
        } else {
            0
        };
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_vote_lock_duration(v1);
        if (0x2::table::contains<address, u64>(&arg0.vote_locks, arg1)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.vote_locks, arg1);
            if (arg2 > *v2) {
                *v2 = arg2;
            };
        } else {
            0x2::table::add<address, u64>(&mut arg0.vote_locks, arg1, arg2);
        };
    }

    public fun store_protocol_cap<T0: store + key>(arg0: &mut Vault, arg1: &AdminCap, arg2: 0x1::string::String, arg3: T0) {
        0x2::dynamic_object_field::add<0x1::string::String, T0>(&mut arg0.id, arg2, arg3);
    }

    public fun take_yield_balance<T0>(arg0: &mut Vault) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.invested_assets, v0)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.invested_assets, v0)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun total_receipts(arg0: &Vault) : u64 {
        arg0.total_receipts
    }

    public fun trigger_auto_pause(arg0: &mut Vault) {
        assert!(!arg0.auto_paused, 208);
        arg0.auto_paused = true;
        let v0 = AutoPauseEvent{paused: true};
        0x2::event::emit<AutoPauseEvent>(v0);
    }

    public fun trigger_auto_unpause(arg0: &mut Vault) {
        assert!(arg0.auto_paused, 209);
        arg0.auto_paused = false;
        let v0 = AutoPauseEvent{paused: false};
        0x2::event::emit<AutoPauseEvent>(v0);
    }

    public fun update_fee_recipient(arg0: &mut Vault, arg1: &AdminCap, arg2: address) {
        arg0.fee_recipient = arg2;
    }

    public fun update_heartbeat_tvl(arg0: &mut Vault, arg1: u64) {
        let v0 = 0x2::balance::value<USDC>(&arg0.idle_balance) + arg1;
        let v1 = arg0.last_heartbeat_tvl;
        if (v1 > 0) {
            let v2 = if (v0 > v1) {
                v0 - v1
            } else {
                v1 - v0
            };
            0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_tvl_delta((((v2 as u128) * 10000 / (v1 as u128)) as u64));
        };
        arg0.last_heartbeat_tvl = v0;
        let v3 = HeartbeatTvlEvent{tvl: arg0.last_heartbeat_tvl};
        0x2::event::emit<HeartbeatTvlEvent>(v3);
    }

    public fun update_performance_fee(arg0: &mut Vault, arg1: &AdminCap, arg2: u64) {
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_rewards_fee(arg2);
        arg0.performance_fee_bps = arg2;
    }

    public fun update_tvl_cap(arg0: &mut Vault, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 >= arg0.max_tvl_cap, 202);
        arg0.max_tvl_cap = arg2;
    }

    public fun withdraw(arg0: &mut Vault, arg1: 0x2::token::Token<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, u64>(&arg0.vote_locks, v0)) {
            assert!(0x2::clock::timestamp_ms(arg3) > *0x2::table::borrow<address, u64>(&arg0.vote_locks, v0), 206);
            0x2::table::remove<address, u64>(&mut arg0.vote_locks, v0);
        };
        let v1 = 0x2::token::value<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT>(&arg1);
        assert!(v1 > 0, 200);
        0x2::token::burn<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT>(&mut arg0.treasury_cap, arg1);
        let v2 = if (arg0.total_receipts == 0) {
            0
        } else {
            (((v1 as u128) * (0x2::balance::value<USDC>(&arg0.idle_balance) as u128) / (arg0.total_receipts as u128)) as u64)
        };
        assert!(v2 >= arg2, 203);
        arg0.total_receipts = arg0.total_receipts - v1;
        let v3 = WithdrawEvent{
            user            : v0,
            receipts_burned : v1,
            usdc_returned   : v2,
        };
        0x2::event::emit<WithdrawEvent>(v3);
        0x2::coin::take<USDC>(&mut arg0.idle_balance, v2, arg4)
    }

    // decompiled from Move bytecode v6
}

