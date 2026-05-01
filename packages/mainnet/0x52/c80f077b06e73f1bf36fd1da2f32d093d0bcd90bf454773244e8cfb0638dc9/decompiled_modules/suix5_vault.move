module 0x52c80f077b06e73f1bf36fd1da2f32d093d0bcd90bf454773244e8cfb0638dc9::suix5_vault {
    struct SUIX5_VAULT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SuiX5Vault has key {
        id: 0x2::object::UID,
        token_balances: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        token_stores: 0x2::bag::Bag,
        discovered_tokens: vector<0x1::type_name::TypeName>,
        usdc_reserve: u64,
        suix5_treasury: 0x2::coin::TreasuryCap<SUIX5_VAULT>,
        suix5_supply: u64,
        deposit_fee_rate: u64,
        withdrawal_fee_rate: u64,
        fee_collector_address: address,
        authorized_operators: vector<address>,
        admin: address,
        paused: bool,
        emergency_mode: bool,
        min_nav_threshold: u64,
        max_nav_threshold: u64,
        deposit_timeout_epochs: u64,
        withdrawal_timeout_epochs: u64,
        total_fees_collected_usdc: u64,
        last_nav_reported: u64,
        last_health_check_epoch: u64,
        creation_timestamp: u64,
        pending_deposits: 0x2::table::Table<0x2::object::ID, PendingDeposit>,
        pending_withdrawals: 0x2::table::Table<0x2::object::ID, PendingWithdrawal>,
    }

    struct PendingDeposit has drop, store {
        user: address,
        usdc_net_amount: u64,
        created_epoch: u64,
        timeout_epochs: u64,
    }

    struct PendingWithdrawal has drop, store {
        user: address,
        suix5_burned: u64,
        created_epoch: u64,
        timeout_epochs: u64,
    }

    struct VaultHealth has copy, drop {
        nav_per_suix5_usdc: u64,
        is_nav_healthy: bool,
        emergency_mode: bool,
        paused: bool,
        total_usdc_reserve: u64,
        total_suix5_supply: u64,
        pending_deposits_count: u64,
        pending_withdrawals_count: u64,
        last_check_epoch: u64,
    }

    struct PendingDepositCreated has copy, drop {
        deposit_id: 0x2::object::ID,
        user: address,
        gross_usdc_amount: u64,
        fee_usdc_amount: u64,
        net_usdc_amount: u64,
        timestamp: u64,
    }

    struct DepositCompleted has copy, drop {
        deposit_id: 0x2::object::ID,
        user: address,
        net_usdc_amount: u64,
        suix5_minted: u64,
        nav_per_suix5_usdc: u64,
        completed_by: address,
        timestamp: u64,
    }

    struct DepositExpiredRefunded has copy, drop {
        deposit_id: 0x2::object::ID,
        user: address,
        usdc_refunded: u64,
        timestamp: u64,
    }

    struct PendingDepositCancelled has copy, drop {
        deposit_id: 0x2::object::ID,
        user: address,
        usdc_refunded: u64,
        cancelled_by: address,
        timestamp: u64,
    }

    struct WithdrawalRequested has copy, drop {
        withdrawal_id: 0x2::object::ID,
        user: address,
        suix5_burned: u64,
        timestamp: u64,
    }

    struct WithdrawalCompleted has copy, drop {
        withdrawal_id: 0x2::object::ID,
        user: address,
        suix5_burned: u64,
        gross_usdc_amount: u64,
        fee_usdc_amount: u64,
        net_usdc_to_user: u64,
        completed_by: address,
        timestamp: u64,
    }

    struct PendingWithdrawalCancelled has copy, drop {
        withdrawal_id: 0x2::object::ID,
        user: address,
        restored_suix5: u64,
        cancelled_by: address,
        timestamp: u64,
    }

    struct TokenWithdrawnForRebalancing has copy, drop {
        operator: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp: u64,
    }

    struct TokenDepositedFromRebalancing has copy, drop {
        operator: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp: u64,
    }

    struct TokenWithdrawnForCompositionChange has copy, drop {
        operator: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp: u64,
    }

    struct TokenDepositedFromCompositionChange has copy, drop {
        operator: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp: u64,
    }

    struct TokenDepositedFromDeployment has copy, drop {
        operator: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp: u64,
    }

    struct TokenWithdrawnForRedemption has copy, drop {
        operator: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        withdrawal_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct UsdcDepositedToReserve has copy, drop {
        operator: address,
        usdc_amount: u64,
        purpose: vector<u8>,
        timestamp: u64,
    }

    struct UsdcWithdrawnFromReserve has copy, drop {
        operator: address,
        usdc_amount: u64,
        purpose: vector<u8>,
        timestamp: u64,
    }

    struct VaultCompositionUpdate has copy, drop {
        operator: address,
        action: vector<u8>,
        details: vector<u8>,
        timestamp: u64,
    }

    struct NavReported has copy, drop {
        operator: address,
        nav_per_suix5_usdc: u64,
        total_portfolio_usdc: u64,
        suix5_supply: u64,
        timestamp: u64,
    }

    struct EmergencyMintExecuted has copy, drop {
        admin: address,
        amount_minted: u64,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct EmergencyBurnExecuted has copy, drop {
        admin: address,
        amount_burned: u64,
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
        nav_per_suix5_usdc: u64,
        is_healthy: bool,
        usdc_reserve: u64,
        suix5_supply: u64,
        timestamp: u64,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
        timestamp: u64,
    }

    entry fun add_authorized_operator(arg0: &mut SuiX5Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        0x1::vector::push_back<address>(&mut arg0.authorized_operators, arg1);
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    entry fun cancel_pending_deposit(arg0: &mut SuiX5Vault, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(0x2::table::contains<0x2::object::ID, PendingDeposit>(&arg0.pending_deposits, arg1), 108);
        let v0 = 0x2::table::remove<0x2::object::ID, PendingDeposit>(&mut arg0.pending_deposits, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.token_stores, 0x1::type_name::get<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()), v0.usdc_net_amount), arg2), v0.user);
        arg0.usdc_reserve = arg0.usdc_reserve - v0.usdc_net_amount;
        let v1 = PendingDepositCancelled{
            deposit_id    : arg1,
            user          : v0.user,
            usdc_refunded : v0.usdc_net_amount,
            cancelled_by  : arg0.admin,
            timestamp     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<PendingDepositCancelled>(v1);
    }

    entry fun cancel_pending_withdrawal(arg0: &mut SuiX5Vault, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(0x2::table::contains<0x2::object::ID, PendingWithdrawal>(&arg0.pending_withdrawals, arg1), 110);
        let v0 = 0x2::table::remove<0x2::object::ID, PendingWithdrawal>(&mut arg0.pending_withdrawals, arg1);
        arg0.suix5_supply = arg0.suix5_supply + v0.suix5_burned;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIX5_VAULT>>(0x2::coin::mint<SUIX5_VAULT>(&mut arg0.suix5_treasury, v0.suix5_burned, arg2), v0.user);
        let v1 = PendingWithdrawalCancelled{
            withdrawal_id  : arg1,
            user           : v0.user,
            restored_suix5 : v0.suix5_burned,
            cancelled_by   : arg0.admin,
            timestamp      : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<PendingWithdrawalCancelled>(v1);
    }

    entry fun claim_expired_deposit(arg0: &mut SuiX5Vault, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, PendingDeposit>(&arg0.pending_deposits, arg1), 108);
        let v0 = 0x2::table::remove<0x2::object::ID, PendingDeposit>(&mut arg0.pending_deposits, arg1);
        assert!(0x2::tx_context::sender(arg2) == v0.user, 117);
        let v1 = 0x2::tx_context::epoch(arg2);
        assert!(v1 > v0.created_epoch + v0.timeout_epochs, 116);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.token_stores, 0x1::type_name::get<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>());
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v2) >= v0.usdc_net_amount, 103);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v2, v0.usdc_net_amount), arg2), v0.user);
        arg0.usdc_reserve = arg0.usdc_reserve - v0.usdc_net_amount;
        let v3 = DepositExpiredRefunded{
            deposit_id    : arg1,
            user          : v0.user,
            usdc_refunded : v0.usdc_net_amount,
            timestamp     : v1,
        };
        0x2::event::emit<DepositExpiredRefunded>(v3);
    }

    entry fun complete_deposit(arg0: &mut SuiX5Vault, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_authorized(arg0, v0), 100);
        assert!(0x2::table::contains<0x2::object::ID, PendingDeposit>(&arg0.pending_deposits, arg1), 108);
        assert!(arg2 > 0, 5);
        let v1 = 0x2::table::remove<0x2::object::ID, PendingDeposit>(&mut arg0.pending_deposits, arg1);
        let v2 = 0x2::tx_context::epoch(arg4);
        assert!(v2 <= v1.created_epoch + v1.timeout_epochs, 109);
        arg0.suix5_supply = arg0.suix5_supply + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIX5_VAULT>>(0x2::coin::mint<SUIX5_VAULT>(&mut arg0.suix5_treasury, arg2, arg4), v1.user);
        let v3 = DepositCompleted{
            deposit_id         : arg1,
            user               : v1.user,
            net_usdc_amount    : v1.usdc_net_amount,
            suix5_minted       : arg2,
            nav_per_suix5_usdc : arg3,
            completed_by       : v0,
            timestamp          : v2,
        };
        0x2::event::emit<DepositCompleted>(v3);
    }

    entry fun complete_withdrawal(arg0: &mut SuiX5Vault, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_authorized(arg0, v0), 100);
        assert!(0x2::table::contains<0x2::object::ID, PendingWithdrawal>(&arg0.pending_withdrawals, arg1), 110);
        assert!(arg2 > 0, 5);
        let v1 = 0x2::table::remove<0x2::object::ID, PendingWithdrawal>(&mut arg0.pending_withdrawals, arg1);
        let v2 = calculate_fee(arg2, arg0.withdrawal_fee_rate);
        let v3 = arg2 - v2;
        assert!(arg0.usdc_reserve >= arg2, 120);
        let v4 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.token_stores, 0x1::type_name::get<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>());
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4) >= arg2, 103);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4, v2), arg3), arg0.fee_collector_address);
            arg0.total_fees_collected_usdc = arg0.total_fees_collected_usdc + v2;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4, v3), arg3), v1.user);
        arg0.usdc_reserve = arg0.usdc_reserve - arg2;
        let v5 = WithdrawalCompleted{
            withdrawal_id     : arg1,
            user              : v1.user,
            suix5_burned      : v1.suix5_burned,
            gross_usdc_amount : arg2,
            fee_usdc_amount   : v2,
            net_usdc_to_user  : v3,
            completed_by      : v0,
            timestamp         : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<WithdrawalCompleted>(v5);
    }

    entry fun deposit_from_composition_change<T0>(arg0: &mut SuiX5Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_authorized(arg0, v0), 100);
        let v1 = 0x1::type_name::get<T0>();
        ensure_token_registered<T0>(arg0);
        let v2 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v1), 0x2::coin::into_balance<T0>(arg1));
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, v1) + v2);
        let v3 = TokenDepositedFromCompositionChange{
            operator   : v0,
            token_type : v1,
            amount     : v2,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<TokenDepositedFromCompositionChange>(v3);
    }

    entry fun deposit_from_deployment<T0>(arg0: &mut SuiX5Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_authorized(arg0, v0), 100);
        let v1 = 0x1::type_name::get<T0>();
        ensure_token_registered<T0>(arg0);
        let v2 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v1), 0x2::coin::into_balance<T0>(arg1));
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, v1) + v2);
        let v3 = TokenDepositedFromDeployment{
            operator   : v0,
            token_type : v1,
            amount     : v2,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<TokenDepositedFromDeployment>(v3);
    }

    entry fun deposit_from_rebalancing<T0>(arg0: &mut SuiX5Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_authorized(arg0, v0), 100);
        let v1 = 0x1::type_name::get<T0>();
        ensure_token_registered<T0>(arg0);
        let v2 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v1), 0x2::coin::into_balance<T0>(arg1));
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, v1) + v2);
        let v3 = TokenDepositedFromRebalancing{
            operator   : v0,
            token_type : v1,
            amount     : v2,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<TokenDepositedFromRebalancing>(v3);
    }

    entry fun deposit_usdc_to_reserve(arg0: &mut SuiX5Vault, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_authorized(arg0, v0), 100);
        ensure_token_registered<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v1 > 0, 5);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.token_stores, 0x1::type_name::get<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        arg0.usdc_reserve = arg0.usdc_reserve + v1;
        let v2 = UsdcDepositedToReserve{
            operator    : v0,
            usdc_amount : v1,
            purpose     : arg2,
            timestamp   : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<UsdcDepositedToReserve>(v2);
    }

    entry fun emergency_burn_suix5(arg0: &mut SuiX5Vault, arg1: 0x2::coin::Coin<SUIX5_VAULT>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 100);
        let v0 = 0x2::coin::value<SUIX5_VAULT>(&arg1);
        assert!(v0 > 0, 5);
        assert!(arg0.suix5_supply >= v0, 103);
        0x2::coin::burn<SUIX5_VAULT>(&mut arg0.suix5_treasury, arg1);
        arg0.suix5_supply = arg0.suix5_supply - v0;
        let v1 = EmergencyBurnExecuted{
            admin         : arg0.admin,
            amount_burned : v0,
            reason        : arg2,
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<EmergencyBurnExecuted>(v1);
    }

    entry fun emergency_mint_suix5(arg0: &mut SuiX5Vault, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 100);
        assert!(arg1 > 0, 5);
        arg0.suix5_supply = arg0.suix5_supply + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIX5_VAULT>>(0x2::coin::mint<SUIX5_VAULT>(&mut arg0.suix5_treasury, arg1, arg3), arg0.admin);
        let v0 = EmergencyMintExecuted{
            admin         : arg0.admin,
            amount_minted : arg1,
            reason        : arg2,
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<EmergencyMintExecuted>(v0);
    }

    entry fun emergency_withdraw_all<T0>(arg0: &mut SuiX5Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 100);
        let v0 = 0x1::type_name::get<T0>();
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
            if (v0 == 0x1::type_name::get<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()) {
                arg0.usdc_reserve = 0;
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, v2, arg1), arg0.admin);
        };
    }

    fun ensure_token_registered<T0>(arg0: &mut SuiX5Vault) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_balances, v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.discovered_tokens, v0);
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v0, 0);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v0, 0x2::balance::zero<T0>());
        };
    }

    public fun get_audit_data(arg0: &SuiX5Vault) : (u64, u64, u64) {
        (arg0.total_fees_collected_usdc, arg0.creation_timestamp, arg0.last_health_check_epoch)
    }

    public fun get_emergency_status(arg0: &SuiX5Vault) : (bool, bool) {
        (arg0.paused, arg0.emergency_mode)
    }

    public fun get_fee_rates(arg0: &SuiX5Vault) : (u64, u64) {
        (arg0.deposit_fee_rate, arg0.withdrawal_fee_rate)
    }

    public fun get_last_nav(arg0: &SuiX5Vault) : u64 {
        arg0.last_nav_reported
    }

    public fun get_nav_thresholds(arg0: &SuiX5Vault) : (u64, u64) {
        (arg0.min_nav_threshold, arg0.max_nav_threshold)
    }

    public fun get_pending_operations_count(arg0: &SuiX5Vault) : (u64, u64) {
        (0x2::table::length<0x2::object::ID, PendingDeposit>(&arg0.pending_deposits), 0x2::table::length<0x2::object::ID, PendingWithdrawal>(&arg0.pending_withdrawals))
    }

    public fun get_portfolio_composition(arg0: &SuiX5Vault) : (vector<0x1::type_name::TypeName>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.discovered_tokens)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.discovered_tokens, v2);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, get_token_balance_internal(arg0, v3));
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_suix5_supply(arg0: &SuiX5Vault) : u64 {
        arg0.suix5_supply
    }

    public fun get_timeout_config(arg0: &SuiX5Vault) : (u64, u64) {
        (arg0.deposit_timeout_epochs, arg0.withdrawal_timeout_epochs)
    }

    public fun get_token_balance(arg0: &SuiX5Vault, arg1: 0x1::type_name::TypeName) : u64 {
        get_token_balance_internal(arg0, arg1)
    }

    fun get_token_balance_internal(arg0: &SuiX5Vault, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_balances, arg1)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, arg1)
        } else {
            0
        }
    }

    public fun get_usdc_reserve(arg0: &SuiX5Vault) : u64 {
        arg0.usdc_reserve
    }

    public fun get_vault_health(arg0: &SuiX5Vault) : VaultHealth {
        let v0 = arg0.last_nav_reported;
        let v1 = v0 >= arg0.min_nav_threshold && v0 <= arg0.max_nav_threshold;
        VaultHealth{
            nav_per_suix5_usdc        : v0,
            is_nav_healthy            : v1,
            emergency_mode            : arg0.emergency_mode,
            paused                    : arg0.paused,
            total_usdc_reserve        : arg0.usdc_reserve,
            total_suix5_supply        : arg0.suix5_supply,
            pending_deposits_count    : 0x2::table::length<0x2::object::ID, PendingDeposit>(&arg0.pending_deposits),
            pending_withdrawals_count : 0x2::table::length<0x2::object::ID, PendingWithdrawal>(&arg0.pending_withdrawals),
            last_check_epoch          : arg0.last_health_check_epoch,
        }
    }

    fun init(arg0: SUIX5_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX5_VAULT>(arg0, 6, b"SUIX5", b"SuiX5 Index Vault Token", b"USDC-denominated passive index token tracking the top 5 Sui ecosystem tokens by market cap. Deposit USDC, receive SUIX5. Burn SUIX5, receive USDC. Rebalances every 12 hours. sui-x.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://indigo-elaborate-bovid-600.mypinata.cloud/ipfs/bafkreih4dle5txwovr6nkwmqx3nkq364e6g46yhvbfgzgg733fbvmizcwe")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIX5_VAULT>>(v1);
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, v2);
        let v4 = SuiX5Vault{
            id                        : 0x2::object::new(arg1),
            token_balances            : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            token_stores              : 0x2::bag::new(arg1),
            discovered_tokens         : 0x1::vector::empty<0x1::type_name::TypeName>(),
            usdc_reserve              : 0,
            suix5_treasury            : v0,
            suix5_supply              : 0,
            deposit_fee_rate          : 50,
            withdrawal_fee_rate       : 50,
            fee_collector_address     : v2,
            authorized_operators      : 0x1::vector::empty<address>(),
            admin                     : v2,
            paused                    : false,
            emergency_mode            : false,
            min_nav_threshold         : 100000,
            max_nav_threshold         : 100000000,
            deposit_timeout_epochs    : 2,
            withdrawal_timeout_epochs : 7,
            total_fees_collected_usdc : 0,
            last_nav_reported         : 1000000,
            last_health_check_epoch   : 0x2::tx_context::epoch(arg1),
            creation_timestamp        : 0x2::tx_context::epoch(arg1),
            pending_deposits          : 0x2::table::new<0x2::object::ID, PendingDeposit>(arg1),
            pending_withdrawals       : 0x2::table::new<0x2::object::ID, PendingWithdrawal>(arg1),
        };
        0x2::transfer::share_object<SuiX5Vault>(v4);
    }

    entry fun initiate_deposit(arg0: &mut SuiX5Vault, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 107);
        assert!(!arg0.emergency_mode, 112);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v1 >= 1000000, 121);
        let v2 = calculate_fee(v1, arg0.deposit_fee_rate);
        let v3 = v1 - v2;
        ensure_token_registered<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        let v4 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.token_stores, 0x1::type_name::get<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>());
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4, v2), arg2), arg0.fee_collector_address);
            arg0.total_fees_collected_usdc = arg0.total_fees_collected_usdc + v2;
        };
        arg0.usdc_reserve = arg0.usdc_reserve + v3;
        let v5 = 0x2::object::new(arg2);
        let v6 = 0x2::object::uid_to_inner(&v5);
        0x2::object::delete(v5);
        let v7 = PendingDeposit{
            user            : v0,
            usdc_net_amount : v3,
            created_epoch   : 0x2::tx_context::epoch(arg2),
            timeout_epochs  : arg0.deposit_timeout_epochs,
        };
        0x2::table::add<0x2::object::ID, PendingDeposit>(&mut arg0.pending_deposits, v6, v7);
        let v8 = PendingDepositCreated{
            deposit_id        : v6,
            user              : v0,
            gross_usdc_amount : v1,
            fee_usdc_amount   : v2,
            net_usdc_amount   : v3,
            timestamp         : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<PendingDepositCreated>(v8);
    }

    entry fun initiate_withdrawal(arg0: &mut SuiX5Vault, arg1: 0x2::coin::Coin<SUIX5_VAULT>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 107);
        assert!(!arg0.emergency_mode, 112);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<SUIX5_VAULT>(&arg1);
        assert!(v1 > 0, 5);
        0x2::coin::burn<SUIX5_VAULT>(&mut arg0.suix5_treasury, arg1);
        arg0.suix5_supply = arg0.suix5_supply - v1;
        let v2 = 0x2::object::new(arg2);
        let v3 = 0x2::object::uid_to_inner(&v2);
        0x2::object::delete(v2);
        let v4 = PendingWithdrawal{
            user           : v0,
            suix5_burned   : v1,
            created_epoch  : 0x2::tx_context::epoch(arg2),
            timeout_epochs : arg0.withdrawal_timeout_epochs,
        };
        0x2::table::add<0x2::object::ID, PendingWithdrawal>(&mut arg0.pending_withdrawals, v3, v4);
        let v5 = WithdrawalRequested{
            withdrawal_id : v3,
            user          : v0,
            suix5_burned  : v1,
            timestamp     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<WithdrawalRequested>(v5);
    }

    fun is_authorized(arg0: &SuiX5Vault, arg1: address) : bool {
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

    public fun is_vault_operational(arg0: &SuiX5Vault) : bool {
        !arg0.paused && !arg0.emergency_mode
    }

    public fun is_vault_paused(arg0: &SuiX5Vault) : bool {
        arg0.paused
    }

    entry fun log_composition_update(arg0: &mut SuiX5Vault, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
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

    entry fun pause_vault(arg0: &mut SuiX5Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 100);
        arg0.paused = true;
    }

    entry fun remove_authorized_operator(arg0: &mut SuiX5Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
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

    entry fun report_nav(arg0: &mut SuiX5Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_authorized(arg0, v0), 100);
        assert!(arg1 > 0, 5);
        arg0.last_nav_reported = arg1;
        let v1 = NavReported{
            operator             : v0,
            nav_per_suix5_usdc   : arg1,
            total_portfolio_usdc : arg2,
            suix5_supply         : arg0.suix5_supply,
            timestamp            : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<NavReported>(v1);
    }

    entry fun toggle_emergency_mode(arg0: &mut SuiX5Vault, arg1: bool, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
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

    entry fun transfer_admin(arg0: &mut SuiX5Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(arg1 != @0x0, 122);
        arg0.admin = arg1;
        let v0 = AdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg1,
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    entry fun unpause_vault(arg0: &mut SuiX5Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 100);
        arg0.paused = false;
    }

    entry fun update_deposit_timeout(arg0: &mut SuiX5Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(arg1 >= 1 && arg1 <= 30, 118);
        arg0.deposit_timeout_epochs = arg1;
    }

    entry fun update_fee_collector(arg0: &mut SuiX5Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(arg1 != @0x0, 111);
        arg0.fee_collector_address = arg1;
    }

    entry fun update_fee_rates(arg0: &mut SuiX5Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 100);
        assert!(arg1 <= 1000, 106);
        assert!(arg2 <= 1000, 106);
        arg0.deposit_fee_rate = arg1;
        arg0.withdrawal_fee_rate = arg2;
    }

    entry fun update_nav_thresholds(arg0: &mut SuiX5Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 100);
        assert!(arg1 < arg2, 115);
        assert!(arg1 > 0 && arg2 > 0, 115);
        arg0.min_nav_threshold = arg1;
        arg0.max_nav_threshold = arg2;
    }

    entry fun update_withdrawal_timeout(arg0: &mut SuiX5Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(arg1 >= 1 && arg1 <= 60, 118);
        arg0.withdrawal_timeout_epochs = arg1;
    }

    entry fun validate_vault_health(arg0: &mut SuiX5Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_authorized(arg0, v0), 100);
        let v1 = arg0.last_nav_reported;
        let v2 = v1 >= arg0.min_nav_threshold && v1 <= arg0.max_nav_threshold;
        arg0.last_health_check_epoch = 0x2::tx_context::epoch(arg1);
        let v3 = VaultHealthCheck{
            operator           : v0,
            nav_per_suix5_usdc : v1,
            is_healthy         : v2,
            usdc_reserve       : arg0.usdc_reserve,
            suix5_supply       : arg0.suix5_supply,
            timestamp          : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<VaultHealthCheck>(v3);
    }

    entry fun withdraw_for_composition_change<T0>(arg0: &mut SuiX5Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_authorized(arg0, v0), 100);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.token_stores, v1), 102);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 103);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, v1) - arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v2, arg1, arg2), v0);
        let v3 = TokenWithdrawnForCompositionChange{
            operator   : v0,
            token_type : v1,
            amount     : arg1,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<TokenWithdrawnForCompositionChange>(v3);
    }

    entry fun withdraw_for_rebalancing<T0>(arg0: &mut SuiX5Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_authorized(arg0, v0), 100);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.token_stores, v1), 102);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 103);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, v1) - arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v2, arg1, arg2), v0);
        let v3 = TokenWithdrawnForRebalancing{
            operator   : v0,
            token_type : v1,
            amount     : arg1,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<TokenWithdrawnForRebalancing>(v3);
    }

    entry fun withdraw_for_redemption<T0>(arg0: &mut SuiX5Vault, arg1: u64, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_authorized(arg0, v0), 100);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.token_stores, v1), 102);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.token_stores, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 103);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_balances, v1, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_balances, v1) - arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v2, arg1, arg3), v0);
        let v3 = TokenWithdrawnForRedemption{
            operator      : v0,
            token_type    : v1,
            amount        : arg1,
            withdrawal_id : arg2,
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<TokenWithdrawnForRedemption>(v3);
    }

    entry fun withdraw_usdc_from_reserve(arg0: &mut SuiX5Vault, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_authorized(arg0, v0), 100);
        assert!(arg1 > 0, 5);
        assert!(arg0.usdc_reserve >= arg1, 120);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.token_stores, 0x1::type_name::get<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>());
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1) >= arg1, 103);
        arg0.usdc_reserve = arg0.usdc_reserve - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1, arg1, arg3), v0);
        let v2 = UsdcWithdrawnFromReserve{
            operator    : v0,
            usdc_amount : arg1,
            purpose     : arg2,
            timestamp   : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<UsdcWithdrawnFromReserve>(v2);
    }

    // decompiled from Move bytecode v7
}

