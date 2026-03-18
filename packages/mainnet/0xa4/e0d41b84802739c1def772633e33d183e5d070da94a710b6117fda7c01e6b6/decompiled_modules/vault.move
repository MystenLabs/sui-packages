module 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct StrategyCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct BorrowReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        borrowed_amount: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        idle_balance: 0x2::balance::Balance<T0>,
        invested_assets: 0x2::bag::Bag,
        user_balances: 0x2::table::Table<address, u64>,
        total_invested: u64,
        total_shares: u64,
        current_strategy: u8,
        treasury_cap: 0x2::coin::TreasuryCap<0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc::AQUSDC>,
    }

    struct WithdrawalRequest has key {
        id: 0x2::object::UID,
        user: address,
        shares: u64,
        usdc_owed: u64,
        min_usdc: u64,
    }

    struct DepositEvent has copy, drop {
        user: address,
        usdc_amount: u64,
        aqua_minted: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        aqua_burned: u64,
        usdc_returned: u64,
    }

    struct RerouteEvent has copy, drop {
        from_strategy: u8,
        to_strategy: u8,
        amount_moved: u64,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        user: address,
        shares_burned: u64,
        usdc_returned: u64,
    }

    struct WithdrawalRequestedEvent has copy, drop {
        request_id: 0x2::object::ID,
        user: address,
        shares: u64,
        usdc_owed: u64,
        min_usdc: u64,
    }

    struct WithdrawalFulfilledEvent has copy, drop {
        request_id: 0x2::object::ID,
        user: address,
        usdc_returned: u64,
    }

    struct HeartbeatEvent has copy, drop {
        timestamp_ms: u64,
    }

    public fun admin_bag_contains<T0, T1>(arg0: &KeeperCap, arg1: &Vault<T0>) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg1.invested_assets, 0x1::type_name::get<T1>())
    }

    public fun admin_cancel_withdrawal<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: WithdrawalRequest) {
        let WithdrawalRequest {
            id        : v0,
            user      : _,
            shares    : _,
            usdc_owed : v3,
            min_usdc  : _,
        } = arg2;
        0x2::object::delete(v0);
        let v5 = get_pending_withdrawals<T0>(arg1);
        let v6 = if (v5 > v3) {
            v5 - v3
        } else {
            0
        };
        set_pending_withdrawals<T0>(arg1, v6);
    }

    public fun admin_drain_bag_entry<T0, T1>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.invested_assets, 0x1::type_name::get<T1>()), arg2)
    }

    public fun admin_drain_bag_usdc<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.invested_assets, v0)) {
            0x2::balance::join<T0>(&mut arg1.idle_balance, 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.invested_assets, v0));
        };
    }

    public fun admin_drain_dust<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(&mut arg1.idle_balance, 0x2::balance::value<T0>(&arg1.idle_balance), arg2)
    }

    public fun admin_pause<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>) {
        let v0 = &mut arg1.id;
        set_paused(v0, true);
        let v1 = PauseEvent{paused: true};
        0x2::event::emit<PauseEvent>(v1);
    }

    public fun admin_remove_user_balance<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: address) {
        if (0x2::table::contains<address, u64>(&arg1.user_balances, arg2)) {
            0x2::table::remove<address, u64>(&mut arg1.user_balances, arg2);
        };
    }

    public fun admin_set_invested<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: u64) {
        arg1.total_invested = arg2;
    }

    public fun admin_set_invested_by_admin<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64) {
        arg1.total_invested = arg2;
    }

    public fun admin_set_keeper_timeout<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64) {
        let v0 = 0x1::string::utf8(b"keeper_timeout_ms");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg1.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg1.id, v0, arg2);
        };
    }

    public fun admin_set_strategy<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: u8) {
        arg1.current_strategy = arg2;
    }

    public fun admin_set_total_shares<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: u64) {
        arg1.total_shares = arg2;
    }

    public fun admin_set_whitelist_enabled<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: bool) {
        let v0 = 0x1::string::utf8(b"whitelist_enabled");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, bool>(&mut arg1.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, bool>(&mut arg1.id, v0, arg2);
        };
    }

    public fun admin_unpause<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>) {
        let v0 = &mut arg1.id;
        set_paused(v0, false);
        let v1 = PauseEvent{paused: false};
        0x2::event::emit<PauseEvent>(v1);
    }

    public fun admin_whitelist_add<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"deposit_whitelist");
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0)) {
            0x2::dynamic_field::add<0x1::string::String, 0x2::table::Table<address, bool>>(&mut arg1.id, v0, 0x2::table::new<address, bool>(arg3));
        };
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, bool>>(&mut arg1.id, v0);
        if (!0x2::table::contains<address, bool>(v1, arg2)) {
            0x2::table::add<address, bool>(v1, arg2, true);
        };
    }

    public fun admin_whitelist_remove<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: address) {
        let v0 = 0x1::string::utf8(b"deposit_whitelist");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, bool>>(&mut arg1.id, v0);
            if (0x2::table::contains<address, bool>(v1, arg2)) {
                0x2::table::remove<address, bool>(v1, arg2);
            };
        };
    }

    public fun admin_zero_invested<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>) {
        arg1.total_invested = 0;
    }

    public fun admin_zero_invested_by_admin<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>) {
        arg1.total_invested = 0;
    }

    public fun borrow_all_for_strategy<T0>(arg0: &mut Vault<T0>, arg1: &StrategyCap) : (0x2::balance::Balance<T0>, BorrowReceipt<T0>) {
        assert!(!is_paused(&arg0.id), 6);
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        let v0 = 0x2::balance::value<T0>(&arg0.idle_balance);
        arg0.total_invested = arg0.total_invested + v0;
        let v1 = if (v0 == 0) {
            arg0.total_invested
        } else {
            v0
        };
        let v2 = BorrowReceipt<T0>{
            vault_id        : 0x2::object::id<Vault<T0>>(arg0),
            borrowed_amount : v1,
        };
        (0x2::balance::withdraw_all<T0>(&mut arg0.idle_balance), v2)
    }

    public fun borrow_for_strategy<T0>(arg0: &mut Vault<T0>, arg1: &StrategyCap, arg2: u64) : (0x2::balance::Balance<T0>, BorrowReceipt<T0>) {
        assert!(!is_paused(&arg0.id), 6);
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        arg0.total_invested = arg0.total_invested + arg2;
        let v0 = BorrowReceipt<T0>{
            vault_id        : 0x2::object::id<Vault<T0>>(arg0),
            borrowed_amount : arg2,
        };
        (0x2::balance::split<T0>(&mut arg0.idle_balance, arg2), v0)
    }

    public fun borrow_treasury_cap<T0>(arg0: &AdminCap, arg1: &Vault<T0>) : &0x2::coin::TreasuryCap<0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc::AQUSDC> {
        &arg1.treasury_cap
    }

    public fun check_keeper_liveness<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"last_heartbeat_ms");
        let v1 = 0x1::string::utf8(b"keeper_timeout_ms");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0) && 0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v1)) {
            if (0x2::clock::timestamp_ms(arg1) - *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0) > *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v1)) {
                let v2 = &mut arg0.id;
                set_paused(v2, true);
                let v3 = PauseEvent{paused: true};
                0x2::event::emit<PauseEvent>(v3);
            };
        };
    }

    public fun commit_strategy<T0, T1>(arg0: &mut Vault<T0>, arg1: BorrowReceipt<T0>, arg2: 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.invested_assets, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.invested_assets, v0), arg2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.invested_assets, v0, arg2);
        };
        let BorrowReceipt {
            vault_id        : _,
            borrowed_amount : _,
        } = arg1;
    }

    public fun create_strategy_cap<T0>(arg0: &AdminCap, arg1: &Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : StrategyCap {
        StrategyCap{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<Vault<T0>>(arg1),
        }
    }

    public fun create_vault<T0>(arg0: 0x2::coin::TreasuryCap<0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc::AQUSDC>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id               : 0x2::object::new(arg1),
            idle_balance     : 0x2::balance::zero<T0>(),
            invested_assets  : 0x2::bag::new(arg1),
            user_balances    : 0x2::table::new<address, u64>(arg1),
            total_invested   : 0,
            total_shares     : 0,
            current_strategy : 0,
            treasury_cap     : arg0,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = KeeperCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<KeeperCap>(v2, @0x954ee376568ab84a439cf3c7548f7bba7c2e923d0e333ea055b397ca2f34ada9);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc::AQUSDC> {
        assert!(!is_paused(&arg0.id), 6);
        let v0 = 0x2::tx_context::sender(arg2);
        if (is_whitelist_enabled(&arg0.id)) {
            assert!(is_whitelisted(&arg0.id, v0), 8);
        };
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 1);
        if (0x2::table::contains<address, u64>(&arg0.user_balances, v0)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v0);
            *v2 = *v2 + v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_balances, v0, v1);
        };
        let v3 = 0x2::balance::value<T0>(&arg0.idle_balance) + arg0.total_invested;
        let v4 = if (arg0.total_shares == 0 || v3 == 0) {
            v1
        } else {
            v1 * arg0.total_shares / v3
        };
        0x2::coin::put<T0>(&mut arg0.idle_balance, arg1);
        arg0.total_shares = arg0.total_shares + v4;
        let v5 = DepositEvent{
            user        : v0,
            usdc_amount : v1,
            aqua_minted : v4,
        };
        0x2::event::emit<DepositEvent>(v5);
        0x2::coin::mint<0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc::AQUSDC>(&mut arg0.treasury_cap, v4, arg2)
    }

    public fun destroy_strategy_cap(arg0: &AdminCap, arg1: StrategyCap) {
        let StrategyCap {
            id       : v0,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun do_reroute<T0>(arg0: &mut Vault<T0>, arg1: u8) {
        if (arg1 != 0) {
            assert!(!is_paused(&arg0.id), 6);
        };
        assert!(arg1 <= 8, 3);
        arg0.current_strategy = arg1;
        let v0 = RerouteEvent{
            from_strategy : arg0.current_strategy,
            to_strategy   : arg1,
            amount_moved  : 0x2::balance::value<T0>(&arg0.idle_balance),
        };
        0x2::event::emit<RerouteEvent>(v0);
    }

    public fun emergency_withdraw<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc::AQUSDC>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_paused(&arg0.id), 7);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::burn<0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc::AQUSDC>(&mut arg0.treasury_cap, arg1);
        assert!(v1 > 0, 1);
        let v2 = if (arg0.total_shares == 0) {
            0
        } else {
            (((v1 as u128) * (0x2::balance::value<T0>(&arg0.idle_balance) as u128) / (arg0.total_shares as u128)) as u64)
        };
        arg0.total_shares = arg0.total_shares - v1;
        if (0x2::table::contains<address, u64>(&arg0.user_balances, v0)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v0);
            if (*v3 > v2) {
                *v3 = *v3 - v2;
            } else {
                *v3 = 0;
            };
        };
        let v4 = EmergencyWithdrawEvent{
            user          : v0,
            shares_burned : v1,
            usdc_returned : v2,
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v4);
        0x2::coin::take<T0>(&mut arg0.idle_balance, v2, arg2)
    }

    public fun fulfill_withdrawal<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: WithdrawalRequest, arg3: &mut 0x2::tx_context::TxContext) {
        let WithdrawalRequest {
            id        : v0,
            user      : v1,
            shares    : _,
            usdc_owed : v3,
            min_usdc  : _,
        } = arg2;
        let v5 = v0;
        0x2::object::delete(v5);
        let v6 = 0x2::balance::value<T0>(&arg1.idle_balance);
        let v7 = if (v3 > v6) {
            v6
        } else {
            v3
        };
        let v8 = get_pending_withdrawals<T0>(arg1);
        let v9 = if (v8 > v3) {
            v8 - v3
        } else {
            0
        };
        set_pending_withdrawals<T0>(arg1, v9);
        let v10 = WithdrawalFulfilledEvent{
            request_id    : 0x2::object::uid_to_inner(&v5),
            user          : v1,
            usdc_returned : v7,
        };
        0x2::event::emit<WithdrawalFulfilledEvent>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.idle_balance, v7, arg3), v1);
    }

    public fun get_current_strategy<T0>(arg0: &Vault<T0>) : u8 {
        arg0.current_strategy
    }

    public fun get_exchange_rate<T0>(arg0: &Vault<T0>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.idle_balance) + arg0.total_invested, arg0.total_shares)
    }

    fun get_pending_withdrawals<T0>(arg0: &Vault<T0>) : u64 {
        let v0 = 0x1::string::utf8(b"pending_withdrawals");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun get_total_invested<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_invested
    }

    public fun get_total_shares<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_shares
    }

    public fun get_vault_idle_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.idle_balance)
    }

    public fun has_protocol_cap<T0>(arg0: &Vault<T0>, arg1: 0x1::string::String) : bool {
        0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1)
    }

    public fun instant_withdraw<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc::AQUSDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!is_paused(&arg0.id), 6);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::burn<0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc::AQUSDC>(&mut arg0.treasury_cap, arg1);
        assert!(v1 > 0, 1);
        let v2 = 0x2::balance::value<T0>(&arg0.idle_balance) + arg0.total_invested;
        let v3 = get_pending_withdrawals<T0>(arg0);
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        let v5 = if (arg0.total_shares == 0) {
            0
        } else {
            (((v1 as u128) * (v4 as u128) / (arg0.total_shares as u128)) as u64)
        };
        assert!(v5 >= arg2, 5);
        arg0.total_shares = arg0.total_shares - v1;
        if (0x2::table::contains<address, u64>(&arg0.user_balances, v0)) {
            let v6 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v0);
            if (*v6 > v5) {
                *v6 = *v6 - v5;
            } else {
                *v6 = 0;
            };
        };
        assert!(0x2::balance::value<T0>(&arg0.idle_balance) >= v5, 1);
        let v7 = WithdrawalFulfilledEvent{
            request_id    : 0x2::object::id<Vault<T0>>(arg0),
            user          : v0,
            usdc_returned : v5,
        };
        0x2::event::emit<WithdrawalFulfilledEvent>(v7);
        0x2::coin::take<T0>(&mut arg0.idle_balance, v5, arg3)
    }

    fun is_paused(arg0: &0x2::object::UID) : bool {
        let v0 = 0x1::string::utf8(b"paused");
        0x2::dynamic_field::exists_<0x1::string::String>(arg0, v0) && *0x2::dynamic_field::borrow<0x1::string::String, bool>(arg0, v0)
    }

    public fun is_vault_paused<T0>(arg0: &Vault<T0>) : bool {
        is_paused(&arg0.id)
    }

    fun is_whitelist_enabled(arg0: &0x2::object::UID) : bool {
        let v0 = 0x1::string::utf8(b"whitelist_enabled");
        0x2::dynamic_field::exists_<0x1::string::String>(arg0, v0) && *0x2::dynamic_field::borrow<0x1::string::String, bool>(arg0, v0)
    }

    fun is_whitelisted(arg0: &0x2::object::UID, arg1: address) : bool {
        let v0 = 0x1::string::utf8(b"deposit_whitelist");
        0x2::dynamic_field::exists_<0x1::string::String>(arg0, v0) && 0x2::table::contains<address, bool>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<address, bool>>(arg0, v0), arg1)
    }

    public fun keeper_heartbeat<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: &0x2::clock::Clock) {
        record_heartbeat<T0>(arg1, arg2);
    }

    public fun permissionless_fulfill_withdrawal<T0>(arg0: &mut Vault<T0>, arg1: WithdrawalRequest, arg2: &mut 0x2::tx_context::TxContext) {
        let WithdrawalRequest {
            id        : v0,
            user      : v1,
            shares    : _,
            usdc_owed : v3,
            min_usdc  : _,
        } = arg1;
        let v5 = v0;
        0x2::object::delete(v5);
        let v6 = 0x2::balance::value<T0>(&arg0.idle_balance);
        let v7 = if (v3 > v6) {
            v6
        } else {
            v3
        };
        let v8 = get_pending_withdrawals<T0>(arg0);
        let v9 = if (v8 > v3) {
            v8 - v3
        } else {
            0
        };
        set_pending_withdrawals<T0>(arg0, v9);
        let v10 = WithdrawalFulfilledEvent{
            request_id    : 0x2::object::uid_to_inner(&v5),
            user          : v1,
            usdc_returned : v7,
        };
        0x2::event::emit<WithdrawalFulfilledEvent>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.idle_balance, v7, arg2), v1);
    }

    public fun permissionless_heartbeat<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock) {
        record_heartbeat<T0>(arg0, arg1);
    }

    public fun permissionless_reroute<T0>(arg0: &mut Vault<T0>, arg1: u8) {
        do_reroute<T0>(arg0, arg1);
    }

    fun record_heartbeat<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"last_heartbeat_ms");
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, v0) = v1;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, v0, v1);
        };
        let v2 = 0x1::string::utf8(b"keeper_timeout_ms");
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v2)) {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, v2, 14400000);
        };
        let v3 = HeartbeatEvent{timestamp_ms: v1};
        0x2::event::emit<HeartbeatEvent>(v3);
    }

    public fun repay_rebalance<T0>(arg0: &mut Vault<T0>, arg1: &StrategyCap, arg2: BorrowReceipt<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg2.vault_id, 2);
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        assert!(0x2::coin::value<T0>(&arg3) >= arg4, 1);
        0x2::balance::join<T0>(&mut arg0.idle_balance, 0x2::coin::into_balance<T0>(arg3));
        if (arg0.total_invested >= arg2.borrowed_amount) {
            arg0.total_invested = arg0.total_invested - arg2.borrowed_amount;
        } else {
            arg0.total_invested = 0;
        };
        let BorrowReceipt {
            vault_id        : _,
            borrowed_amount : _,
        } = arg2;
    }

    public fun repay_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &StrategyCap, arg2: BorrowReceipt<T0>, arg3: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg2.vault_id, 2);
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        assert!(0x2::coin::value<T0>(&arg3) >= arg2.borrowed_amount, 1);
        0x2::balance::join<T0>(&mut arg0.idle_balance, 0x2::coin::into_balance<T0>(arg3));
        if (arg0.total_invested >= arg2.borrowed_amount) {
            arg0.total_invested = arg0.total_invested - arg2.borrowed_amount;
        } else {
            arg0.total_invested = 0;
        };
        let BorrowReceipt {
            vault_id        : _,
            borrowed_amount : _,
        } = arg2;
    }

    public fun request_withdrawal<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc::AQUSDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::burn<0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc::AQUSDC>(&mut arg0.treasury_cap, arg1);
        assert!(v1 > 0, 1);
        let v2 = 0x2::balance::value<T0>(&arg0.idle_balance) + arg0.total_invested;
        let v3 = get_pending_withdrawals<T0>(arg0);
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        let v5 = if (arg0.total_shares == 0) {
            0
        } else {
            (((v1 as u128) * (v4 as u128) / (arg0.total_shares as u128)) as u64)
        };
        assert!(v5 >= arg2, 5);
        arg0.total_shares = arg0.total_shares - v1;
        set_pending_withdrawals<T0>(arg0, v3 + v5);
        if (0x2::table::contains<address, u64>(&arg0.user_balances, v0)) {
            let v6 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v0);
            if (*v6 > v5) {
                *v6 = *v6 - v5;
            } else {
                *v6 = 0;
            };
        };
        let v7 = WithdrawalRequest{
            id        : 0x2::object::new(arg3),
            user      : v0,
            shares    : v1,
            usdc_owed : v5,
            min_usdc  : arg2,
        };
        let v8 = WithdrawalRequestedEvent{
            request_id : 0x2::object::id<WithdrawalRequest>(&v7),
            user       : v0,
            shares     : v1,
            usdc_owed  : v5,
            min_usdc   : arg2,
        };
        0x2::event::emit<WithdrawalRequestedEvent>(v8);
        0x2::transfer::share_object<WithdrawalRequest>(v7);
    }

    public fun reroute<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        do_reroute<T0>(arg1, arg2);
    }

    fun set_paused(arg0: &mut 0x2::object::UID, arg1: bool) {
        let v0 = 0x1::string::utf8(b"paused");
        if (0x2::dynamic_field::exists_<0x1::string::String>(arg0, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, bool>(arg0, v0) = arg1;
        } else {
            0x2::dynamic_field::add<0x1::string::String, bool>(arg0, v0, arg1);
        };
    }

    fun set_pending_withdrawals<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        let v0 = 0x1::string::utf8(b"pending_withdrawals");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, v0, arg1);
        };
    }

    public fun store_protocol_cap<T0, T1: store + key>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: 0x1::string::String, arg3: T1) {
        0x2::dynamic_object_field::add<0x1::string::String, T1>(&mut arg1.id, arg2, arg3);
    }

    public fun take_protocol_cap<T0, T1: store + key>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: 0x1::string::String) : T1 {
        0x2::dynamic_object_field::remove<0x1::string::String, T1>(&mut arg1.id, arg2)
    }

    public fun take_yield_balance<T0, T1>(arg0: &mut Vault<T0>, arg1: &StrategyCap) : 0x2::balance::Balance<T1> {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.invested_assets, v0)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.invested_assets, v0)
        } else {
            0x2::balance::zero<T1>()
        }
    }

    // decompiled from Move bytecode v6
}

