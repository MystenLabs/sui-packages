module 0xdad281e49fbc50efb7756039d25f487f0d0a16837d691ae55de29d87f0936df::multi_vault {
    struct MULTI_VAULT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MultiTokenVault has key {
        id: 0x2::object::UID,
        token_balances: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        token_stores: 0x2::bag::Bag,
        discovered_tokens: vector<0x1::type_name::TypeName>,
        user_deposit_tokens: vector<0x1::type_name::TypeName>,
        suix_treasury: 0x2::coin::TreasuryCap<MULTI_VAULT>,
        suix_supply: u64,
        deposit_fee_rate: u64,
        withdrawal_fee_rate: u64,
        fee_collector_address: address,
        authorized_operators: vector<address>,
        admin: address,
        paused: bool,
        emergency_mode: bool,
        max_single_withdrawal_bps: u64,
        min_nav_threshold: u64,
        max_nav_threshold: u64,
        total_fees_collected: u64,
        last_health_check_epoch: u64,
        creation_timestamp: u64,
        pending_deposits: 0x2::table::Table<0x2::object::ID, PendingDeposit>,
        pending_withdrawals: 0x2::table::Table<0x2::object::ID, PendingWithdrawal>,
        user_last_action: 0x2::table::Table<address, u64>,
        min_action_interval: u64,
        max_actions_per_interval: u64,
    }

    struct PendingDeposit has drop, store {
        user: address,
        token_type: 0x1::type_name::TypeName,
        net_amount: u64,
        created_epoch: u64,
        timeout_epochs: u64,
    }

    struct PendingWithdrawal has drop, store {
        user: address,
        suix_burned: u64,
        net_amount_owed: u64,
        created_epoch: u64,
        timeout_epochs: u64,
    }

    struct VaultHealth has copy, drop {
        nav_per_suix: u64,
        is_nav_healthy: bool,
        emergency_mode: bool,
        total_sui_balance: u64,
        total_suix_supply: u64,
        pending_deposits_count: u64,
        pending_withdrawals_count: u64,
        last_check_epoch: u64,
    }

    struct PendingDepositCreated has copy, drop {
        deposit_id: 0x2::object::ID,
        user: address,
        token_type: 0x1::type_name::TypeName,
        gross_amount: u64,
        fee_amount: u64,
        net_amount: u64,
        timestamp: u64,
    }

    struct DepositCompleted has copy, drop {
        deposit_id: 0x2::object::ID,
        user: address,
        token_type: 0x1::type_name::TypeName,
        net_amount: u64,
        suix_minted: u64,
        suix_price_in_sui: u64,
        completed_by: address,
        timestamp: u64,
    }

    struct WithdrawalRequested has copy, drop {
        withdrawal_id: 0x2::object::ID,
        user: address,
        suix_burned: u64,
        net_amount_owed: u64,
        timestamp: u64,
    }

    struct WithdrawalCompleted has copy, drop {
        withdrawal_id: 0x2::object::ID,
        user: address,
        suix_burned: u64,
        final_sui_amount: u64,
        completed_by: address,
        timestamp: u64,
    }

    struct TokenRebalancingWithdrawEvent has copy, drop {
        operator: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        purpose: vector<u8>,
        timestamp: u64,
    }

    struct TokenRebalancingDepositEvent has copy, drop {
        operator: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        source: vector<u8>,
        timestamp: u64,
    }

    struct VaultCompositionUpdate has copy, drop {
        operator: address,
        action: vector<u8>,
        details: vector<u8>,
        timestamp: u64,
    }

    struct EmergencyMintExecuted has copy, drop {
        admin: address,
        amount_minted: u64,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct EmergencyModeToggled has copy, drop {
        admin: address,
        enabled: bool,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct VaultHealthCheck has copy, drop {
        operator: address,
        nav_per_suix: u64,
        is_healthy: bool,
        sui_balance: u64,
        suix_supply: u64,
        timestamp: u64,
    }

    struct PendingDepositCancelled has copy, drop {
        deposit_id: 0x2::object::ID,
        user: address,
        token_type: 0x1::type_name::TypeName,
        refunded_amount: u64,
        cancelled_by: address,
        timestamp: u64,
    }

    struct PendingWithdrawalCancelled has copy, drop {
        withdrawal_id: 0x2::object::ID,
        user: address,
        restored_suix: u64,
        cancelled_by: address,
        timestamp: u64,
    }

    struct ExpiredDepositsCleared has copy, drop {
        cleared_count: u64,
        cleared_by: address,
        timestamp: u64,
    }

    struct ExpiredWithdrawalsCleared has copy, drop {
        cleared_count: u64,
        cleared_by: address,
        timestamp: u64,
    }

    public entry fun add_authorized_operator(arg0: &mut MultiTokenVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        0x1::vector::push_back<address>(&mut arg0.authorized_operators, arg1);
    }

    public entry fun add_user_deposit_token<T0>(arg0: &mut MultiTokenVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 100);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.user_deposit_tokens)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.user_deposit_tokens, v1) == v0) {
                return
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.user_deposit_tokens, v0);
        ensure_token_registered<T0>(arg0);
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    fun calculate_nav_per_suix(arg0: &MultiTokenVault) : u64 {
        if (arg0.suix_supply == 0) {
            return 1000000
        };
        get_token_balance(arg0, 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) * 1000000 / arg0.suix_supply
    }

    public entry fun cancel_pending_deposit(arg0: &mut MultiTokenVault, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(0x2::table::contains<0x2::object::ID, PendingDeposit>(&arg0.pending_deposits, arg1), 108);
        let v0 = 0x2::table::remove<0x2::object::ID, PendingDeposit>(&mut arg0.pending_deposits, arg1);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v0.token_type);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v0.token_type, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, v0.token_type) - v0.net_amount);
        let v1 = v0.token_type;
        if (v1 == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.token_stores, v1), v0.net_amount), arg2), v0.user);
        };
        let v2 = PendingDepositCancelled{
            deposit_id      : arg1,
            user            : v0.user,
            token_type      : v0.token_type,
            refunded_amount : v0.net_amount,
            cancelled_by    : arg0.admin,
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<PendingDepositCancelled>(v2);
    }

    public entry fun cancel_pending_withdrawal(arg0: &mut MultiTokenVault, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(0x2::table::contains<0x2::object::ID, PendingWithdrawal>(&arg0.pending_withdrawals, arg1), 110);
        let v0 = 0x2::table::remove<0x2::object::ID, PendingWithdrawal>(&mut arg0.pending_withdrawals, arg1);
        arg0.suix_supply = arg0.suix_supply + v0.suix_burned;
        0x2::transfer::public_transfer<0x2::coin::Coin<MULTI_VAULT>>(0x2::coin::mint<MULTI_VAULT>(&mut arg0.suix_treasury, v0.suix_burned, arg2), v0.user);
        let v1 = PendingWithdrawalCancelled{
            withdrawal_id : arg1,
            user          : v0.user,
            restored_suix : v0.suix_burned,
            cancelled_by  : arg0.admin,
            timestamp     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<PendingWithdrawalCancelled>(v1);
    }

    public entry fun clear_expired_deposits(arg0: &mut MultiTokenVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        let v0 = ExpiredDepositsCleared{
            cleared_count : 0,
            cleared_by    : arg0.admin,
            timestamp     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<ExpiredDepositsCleared>(v0);
    }

    public entry fun clear_expired_withdrawals(arg0: &mut MultiTokenVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        let v0 = ExpiredWithdrawalsCleared{
            cleared_count : 0,
            cleared_by    : arg0.admin,
            timestamp     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<ExpiredWithdrawalsCleared>(v0);
    }

    public entry fun complete_deposit(arg0: &mut MultiTokenVault, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_authorized(arg0, v0), 100);
        assert!(0x2::table::contains<0x2::object::ID, PendingDeposit>(&arg0.pending_deposits, arg1), 108);
        assert!(arg2 > 0, 5);
        let v1 = 0x2::table::remove<0x2::object::ID, PendingDeposit>(&mut arg0.pending_deposits, arg1);
        let v2 = 0x2::tx_context::epoch(arg3);
        assert!(v2 <= v1.created_epoch + v1.timeout_epochs, 109);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1.token_type);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1.token_type, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, v1.token_type) + v1.net_amount);
        arg0.suix_supply = arg0.suix_supply + arg2;
        let v3 = if (arg2 > 0) {
            v1.net_amount * 1000000000 / arg2
        } else {
            1000000000
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<MULTI_VAULT>>(0x2::coin::mint<MULTI_VAULT>(&mut arg0.suix_treasury, arg2, arg3), v1.user);
        let v4 = DepositCompleted{
            deposit_id        : arg1,
            user              : v1.user,
            token_type        : v1.token_type,
            net_amount        : v1.net_amount,
            suix_minted       : arg2,
            suix_price_in_sui : v3,
            completed_by      : v0,
            timestamp         : v2,
        };
        0x2::event::emit<DepositCompleted>(v4);
    }

    public entry fun complete_withdrawal(arg0: &mut MultiTokenVault, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_authorized(arg0, v0), 100);
        assert!(0x2::table::contains<0x2::object::ID, PendingWithdrawal>(&arg0.pending_withdrawals, arg1), 110);
        assert!(arg2 > 0, 5);
        let v1 = 0x2::table::remove<0x2::object::ID, PendingWithdrawal>(&mut arg0.pending_withdrawals, arg1);
        let v2 = calculate_fee(arg2, arg0.withdrawal_fee_rate);
        let v3 = arg2 - v2;
        let v4 = 0x1::type_name::with_defining_ids<0x2::sui::SUI>();
        let v5 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.token_stores, v4);
        assert!(0x2::balance::value<0x2::sui::SUI>(v5) >= arg2, 103);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v5, v2), arg3), arg0.fee_collector_address);
            arg0.total_fees_collected = arg0.total_fees_collected + v2;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v5, v3), arg3), v1.user);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v4);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v4, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, v4) - arg2);
        let v6 = WithdrawalCompleted{
            withdrawal_id    : arg1,
            user             : v1.user,
            suix_burned      : v1.suix_burned,
            final_sui_amount : v3,
            completed_by     : v0,
            timestamp        : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<WithdrawalCompleted>(v6);
    }

    public entry fun deposit_token_from_rebalancing<T0>(arg0: &mut MultiTokenVault, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_authorized(arg0, v0), 100);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        ensure_token_registered<T0>(arg0);
        let v2 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v1), 0x2::coin::into_balance<T0>(arg1));
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, v1) + v2);
        let v3 = TokenRebalancingDepositEvent{
            operator   : v0,
            token_type : v1,
            amount     : v2,
            source     : arg2,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<TokenRebalancingDepositEvent>(v3);
    }

    public entry fun emergency_burn_suix(arg0: &mut MultiTokenVault, arg1: 0x2::coin::Coin<MULTI_VAULT>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 100);
        let v0 = 0x2::coin::value<MULTI_VAULT>(&arg1);
        assert!(v0 > 0, 5);
        assert!(arg0.suix_supply >= v0, 103);
        0x2::coin::burn<MULTI_VAULT>(&mut arg0.suix_treasury, arg1);
        arg0.suix_supply = arg0.suix_supply - v0;
        let v1 = EmergencyMintExecuted{
            admin         : arg0.admin,
            amount_minted : v0,
            reason        : arg2,
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<EmergencyMintExecuted>(v1);
    }

    public entry fun emergency_mint_suix(arg0: &mut MultiTokenVault, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 100);
        assert!(arg1 > 0, 5);
        arg0.suix_supply = arg0.suix_supply + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<MULTI_VAULT>>(0x2::coin::mint<MULTI_VAULT>(&mut arg0.suix_treasury, arg1, arg3), arg0.admin);
        let v0 = EmergencyMintExecuted{
            admin         : arg0.admin,
            amount_minted : arg1,
            reason        : arg2,
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<EmergencyMintExecuted>(v0);
    }

    public entry fun emergency_withdraw_all<T0>(arg0: &mut MultiTokenVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 100);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.token_stores, v0)) {
            return
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        if (v2 > 0) {
            if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_balances, v0)) {
                0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v0);
                0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v0, 0);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, v2, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    fun ensure_token_registered<T0>(arg0: &mut MultiTokenVault) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_balances, v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.discovered_tokens, v0);
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v0, 0);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v0, 0x2::balance::zero<T0>());
        };
    }

    public fun get_audit_data(arg0: &MultiTokenVault) : (u64, u64, u64) {
        (arg0.total_fees_collected, arg0.creation_timestamp, arg0.last_health_check_epoch)
    }

    public fun get_emergency_status(arg0: &MultiTokenVault) : (bool, bool) {
        (arg0.paused, arg0.emergency_mode)
    }

    public fun get_fee_rates(arg0: &MultiTokenVault) : (u64, u64) {
        (arg0.deposit_fee_rate, arg0.withdrawal_fee_rate)
    }

    public fun get_pending_operations_count(arg0: &MultiTokenVault) : (u64, u64) {
        (0x2::table::length<0x2::object::ID, PendingDeposit>(&arg0.pending_deposits), 0x2::table::length<0x2::object::ID, PendingWithdrawal>(&arg0.pending_withdrawals))
    }

    public fun get_portfolio_composition(arg0: &MultiTokenVault) : (vector<0x1::type_name::TypeName>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.discovered_tokens)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.discovered_tokens, v2);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, get_token_balance(arg0, v3));
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_safety_limits(arg0: &MultiTokenVault) : (u64, u64, u64) {
        (arg0.max_single_withdrawal_bps, arg0.min_nav_threshold, arg0.max_nav_threshold)
    }

    public fun get_suix_supply(arg0: &MultiTokenVault) : u64 {
        arg0.suix_supply
    }

    public fun get_token_balance(arg0: &MultiTokenVault, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_balances, arg1)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, arg1)
        } else {
            0
        }
    }

    public fun get_vault_health(arg0: &MultiTokenVault) : VaultHealth {
        let v0 = calculate_nav_per_suix(arg0);
        let v1 = v0 >= arg0.min_nav_threshold && v0 <= arg0.max_nav_threshold;
        VaultHealth{
            nav_per_suix              : v0,
            is_nav_healthy            : v1,
            emergency_mode            : arg0.emergency_mode,
            total_sui_balance         : get_token_balance(arg0, 0x1::type_name::with_defining_ids<0x2::sui::SUI>()),
            total_suix_supply         : arg0.suix_supply,
            pending_deposits_count    : 0x2::table::length<0x2::object::ID, PendingDeposit>(&arg0.pending_deposits),
            pending_withdrawals_count : 0x2::table::length<0x2::object::ID, PendingWithdrawal>(&arg0.pending_withdrawals),
            last_check_epoch          : arg0.last_health_check_epoch,
        }
    }

    public fun get_vault_nav_data(arg0: &MultiTokenVault) : (vector<0x1::type_name::TypeName>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.discovered_tokens)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.discovered_tokens, v2);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, get_token_balance(arg0, v3));
            v2 = v2 + 1;
        };
        (v0, v1, arg0.suix_supply)
    }

    fun init(arg0: MULTI_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MULTI_VAULT>(arg0, 9, b"SUIX", b"SuiX Multi-Token Vault", b"Decentralized multi-token index fund for the Sui ecosystem with NAV-based pricing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://indigo-elaborate-bovid-600.mypinata.cloud/ipfs/bafybeihu7h7l47owwfzkzm7242cszjer6emgtvbvme6sig72fhb72ldhsu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MULTI_VAULT>>(v1);
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, v2);
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::with_defining_ids<0x2::sui::SUI>());
        let v5 = MultiTokenVault{
            id                        : 0x2::object::new(arg1),
            token_balances            : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            token_stores              : 0x2::bag::new(arg1),
            discovered_tokens         : 0x1::vector::empty<0x1::type_name::TypeName>(),
            user_deposit_tokens       : v4,
            suix_treasury             : v0,
            suix_supply               : 0,
            deposit_fee_rate          : 25,
            withdrawal_fee_rate       : 25,
            fee_collector_address     : v2,
            authorized_operators      : 0x1::vector::empty<address>(),
            admin                     : v2,
            paused                    : false,
            emergency_mode            : false,
            max_single_withdrawal_bps : 2500,
            min_nav_threshold         : 300000,
            max_nav_threshold         : 3000000,
            total_fees_collected      : 0,
            last_health_check_epoch   : 0x2::tx_context::epoch(arg1),
            creation_timestamp        : 0x2::tx_context::epoch(arg1),
            pending_deposits          : 0x2::table::new<0x2::object::ID, PendingDeposit>(arg1),
            pending_withdrawals       : 0x2::table::new<0x2::object::ID, PendingWithdrawal>(arg1),
            user_last_action          : 0x2::table::new<address, u64>(arg1),
            min_action_interval       : 0,
            max_actions_per_interval  : 0,
        };
        0x2::transfer::share_object<MultiTokenVault>(v5);
    }

    public entry fun initiate_deposit<T0>(arg0: &mut MultiTokenVault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 107);
        assert!(!arg0.emergency_mode, 112);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(is_user_deposit_allowed(arg0, v1), 102);
        ensure_token_registered<T0>(arg0);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 5);
        let v3 = calculate_fee(v2, arg0.deposit_fee_rate);
        let v4 = v2 - v3;
        let v5 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v1);
        0x2::balance::join<T0>(v5, 0x2::coin::into_balance<T0>(arg1));
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v5, v3), arg2), arg0.fee_collector_address);
            arg0.total_fees_collected = arg0.total_fees_collected + v3;
        };
        let v6 = 0x2::object::new(arg2);
        let v7 = 0x2::object::uid_to_inner(&v6);
        0x2::object::delete(v6);
        let v8 = PendingDeposit{
            user           : v0,
            token_type     : v1,
            net_amount     : v4,
            created_epoch  : 0x2::tx_context::epoch(arg2),
            timeout_epochs : 10,
        };
        0x2::table::add<0x2::object::ID, PendingDeposit>(&mut arg0.pending_deposits, v7, v8);
        let v9 = PendingDepositCreated{
            deposit_id   : v7,
            user         : v0,
            token_type   : v1,
            gross_amount : v2,
            fee_amount   : v3,
            net_amount   : v4,
            timestamp    : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<PendingDepositCreated>(v9);
    }

    public entry fun initiate_withdrawal(arg0: &mut MultiTokenVault, arg1: 0x2::coin::Coin<MULTI_VAULT>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 107);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<MULTI_VAULT>(&arg1);
        assert!(v1 > 0, 5);
        validate_withdrawal_size(arg0, v1);
        0x2::coin::burn<MULTI_VAULT>(&mut arg0.suix_treasury, arg1);
        arg0.suix_supply = arg0.suix_supply - v1;
        let v2 = 0x2::object::new(arg2);
        let v3 = 0x2::object::uid_to_inner(&v2);
        0x2::object::delete(v2);
        let v4 = PendingWithdrawal{
            user            : v0,
            suix_burned     : v1,
            net_amount_owed : v1,
            created_epoch   : 0x2::tx_context::epoch(arg2),
            timeout_epochs  : 100,
        };
        0x2::table::add<0x2::object::ID, PendingWithdrawal>(&mut arg0.pending_withdrawals, v3, v4);
        let v5 = WithdrawalRequested{
            withdrawal_id   : v3,
            user            : v0,
            suix_burned     : v1,
            net_amount_owed : v1,
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<WithdrawalRequested>(v5);
    }

    fun is_authorized(arg0: &MultiTokenVault, arg1: address) : bool {
        if (arg1 == arg0.admin) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.authorized_operators)) {
            if (*0x1::vector::borrow<address>(&arg0.authorized_operators, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_nav_healthy(arg0: &MultiTokenVault) : bool {
        let v0 = calculate_nav_per_suix(arg0);
        v0 >= arg0.min_nav_threshold && v0 <= arg0.max_nav_threshold
    }

    fun is_user_deposit_allowed(arg0: &MultiTokenVault, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.user_deposit_tokens)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.user_deposit_tokens, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_vault_paused(arg0: &MultiTokenVault) : bool {
        arg0.paused
    }

    public entry fun log_composition_update(arg0: &mut MultiTokenVault, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_authorized(arg0, v0), 100);
        let v1 = VaultCompositionUpdate{
            operator  : v0,
            action    : arg1,
            details   : arg2,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<VaultCompositionUpdate>(v1);
    }

    public entry fun pause_vault(arg0: &mut MultiTokenVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 100);
        arg0.paused = true;
    }

    public entry fun remove_authorized_operator(arg0: &mut MultiTokenVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.authorized_operators)) {
            if (*0x1::vector::borrow<address>(&arg0.authorized_operators, v0) == arg1) {
                0x1::vector::remove<address>(&mut arg0.authorized_operators, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public entry fun remove_user_deposit_token<T0>(arg0: &mut MultiTokenVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 100);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.user_deposit_tokens)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.user_deposit_tokens, v0) == 0x1::type_name::with_defining_ids<T0>()) {
                0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.user_deposit_tokens, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public entry fun toggle_emergency_mode(arg0: &mut MultiTokenVault, arg1: bool, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 100);
        arg0.emergency_mode = arg1;
        let v0 = EmergencyModeToggled{
            admin     : arg0.admin,
            enabled   : arg1,
            reason    : arg2,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<EmergencyModeToggled>(v0);
    }

    public entry fun unpause_vault(arg0: &mut MultiTokenVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 100);
        arg0.paused = false;
    }

    public entry fun update_fee_collector(arg0: &mut MultiTokenVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(arg1 != @0x0, 111);
        arg0.fee_collector_address = arg1;
    }

    public entry fun update_fee_rates(arg0: &mut MultiTokenVault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 100);
        assert!(arg1 <= 1000, 106);
        assert!(arg2 <= 1000, 106);
        arg0.deposit_fee_rate = arg1;
        arg0.withdrawal_fee_rate = arg2;
    }

    public entry fun update_rate_limits(arg0: &mut MultiTokenVault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 100);
        arg0.min_action_interval = arg1;
        arg0.max_actions_per_interval = arg2;
    }

    public entry fun update_safety_limits(arg0: &mut MultiTokenVault, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 100);
        assert!(arg1 <= 5000, 115);
        assert!(arg2 < arg3, 115);
        assert!(arg2 > 0 && arg3 > 0, 115);
        arg0.max_single_withdrawal_bps = arg1;
        arg0.min_nav_threshold = arg2;
        arg0.max_nav_threshold = arg3;
    }

    public entry fun validate_vault_health(arg0: &mut MultiTokenVault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_authorized(arg0, v0), 100);
        let v1 = calculate_nav_per_suix(arg0);
        let v2 = v1 >= arg0.min_nav_threshold && v1 <= arg0.max_nav_threshold;
        arg0.last_health_check_epoch = 0x2::tx_context::epoch(arg1);
        let v3 = VaultHealthCheck{
            operator     : v0,
            nav_per_suix : v1,
            is_healthy   : v2,
            sui_balance  : get_token_balance(arg0, 0x1::type_name::with_defining_ids<0x2::sui::SUI>()),
            suix_supply  : arg0.suix_supply,
            timestamp    : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<VaultHealthCheck>(v3);
        if (!v2 && !arg0.emergency_mode) {
            arg0.emergency_mode = true;
            let v4 = EmergencyModeToggled{
                admin     : v0,
                enabled   : true,
                reason    : b"Unhealthy NAV detected during validation",
                timestamp : 0x2::tx_context::epoch(arg1),
            };
            0x2::event::emit<EmergencyModeToggled>(v4);
        };
        assert!(v2 || arg0.emergency_mode, 113);
    }

    public fun validate_withdrawal_safety(arg0: &MultiTokenVault, arg1: u64) : bool {
        if (arg0.emergency_mode || arg0.paused) {
            return false
        };
        if (arg1 == 0) {
            return false
        };
        if (arg0.suix_supply == 0) {
            return true
        };
        arg1 * 10000 / arg0.suix_supply <= arg0.max_single_withdrawal_bps
    }

    fun validate_withdrawal_size(arg0: &MultiTokenVault, arg1: u64) {
        if (arg0.suix_supply == 0) {
            return
        };
        assert!(arg1 * 10000 / arg0.suix_supply <= arg0.max_single_withdrawal_bps, 114);
    }

    public entry fun withdraw_token_for_rebalancing<T0>(arg0: &mut MultiTokenVault, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_authorized(arg0, v0), 100);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.token_stores, v1), 102);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 103);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, v1) - arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v2, arg1, arg3), v0);
        let v3 = TokenRebalancingWithdrawEvent{
            operator   : v0,
            token_type : v1,
            amount     : arg1,
            purpose    : arg2,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<TokenRebalancingWithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

