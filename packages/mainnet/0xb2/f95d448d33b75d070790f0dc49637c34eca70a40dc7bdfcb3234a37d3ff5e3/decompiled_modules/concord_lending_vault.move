module 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_lending_vault {
    struct VaultOperatorCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct LendingVault<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        version: u64,
        request_id: u64,
        admin: address,
        borrower: address,
        principal_token: address,
        collateral_token: address,
        principal_target: u64,
        min_capacity: u64,
        deposit_deadline_ms: u64,
        total_deposited: u64,
        repaid_amount: u64,
        total_shares: u64,
        matched_principal: u64,
        principal_escrow: 0x2::balance::Balance<T0>,
        collateral_escrow: 0x2::balance::Balance<T1>,
        payout_collateral_token: address,
        is_collateral_payout: bool,
        mode: u8,
        lender_balances: 0x2::table::Table<address, u64>,
        share_treasury: 0x2::coin::TreasuryCap<T2>,
    }

    fun assert_version<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) {
        assert!(arg0.version == 5, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_version());
    }

    public fun balance_of<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.lender_balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.lender_balances, arg1)
        } else {
            0
        }
    }

    fun booked_principal_balance<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        if (arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted() && arg0.is_collateral_payout) {
            0
        } else {
            let v1 = if (arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_settled()) {
                true
            } else if (arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted()) {
                true
            } else {
                arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_closed()
            };
            if (v1) {
                0x2::balance::value<T0>(&arg0.principal_escrow)
            } else {
                arg0.total_deposited
            }
        }
    }

    fun collateral_assets_for_shares<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>, arg1: u64) : u64 {
        let v0 = arg0.total_shares;
        if (v0 == 0 || arg1 == 0) {
            return 0
        };
        let v1 = 0x2::balance::value<T1>(&arg0.collateral_escrow);
        if (v1 == 0) {
            return 0
        };
        (((arg1 as u128) * (v1 as u128) / (v0 as u128)) as u64)
    }

    public fun convert_to_assets<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>, arg1: u64) : u64 {
        principal_assets_for_shares<T0, T1, T2>(arg0, arg1)
    }

    public fun convert_to_shares<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>, arg1: u64) : u64 {
        let v0 = arg0.total_shares;
        let v1 = 0x2::balance::value<T0>(&arg0.principal_escrow);
        if (v0 == 0 || v1 == 0) {
            arg1
        } else {
            (((arg1 as u128) * (v0 as u128) / (v1 as u128)) as u64)
        }
    }

    public(friend) fun create_for_request<T0, T1, T2: key>(arg0: u64, arg1: address, arg2: address, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::TreasuryCap<T2>, arg9: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, VaultOperatorCap<T0, T1>) {
        assert!(arg6 > 0 && arg6 <= arg5, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_argument());
        let v0 = LendingVault<T0, T1, T2>{
            id                      : 0x2::object::new(arg9),
            version                 : 5,
            request_id              : arg0,
            admin                   : arg1,
            borrower                : arg2,
            principal_token         : arg3,
            collateral_token        : arg4,
            principal_target        : arg5,
            min_capacity            : arg6,
            deposit_deadline_ms     : arg7,
            total_deposited         : 0,
            repaid_amount           : 0,
            total_shares            : 0,
            matched_principal       : 0,
            principal_escrow        : 0x2::balance::zero<T0>(),
            collateral_escrow       : 0x2::balance::zero<T1>(),
            payout_collateral_token : @0x0,
            is_collateral_payout    : false,
            mode                    : 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_collecting(),
            lender_balances         : 0x2::table::new<address, u64>(arg9),
            share_treasury          : arg8,
        };
        let v1 = 0x2::object::id<LendingVault<T0, T1, T2>>(&v0);
        let v2 = VaultOperatorCap<T0, T1>{
            id       : 0x2::object::new(arg9),
            vault_id : v1,
        };
        0x2::transfer::share_object<LendingVault<T0, T1, T2>>(v0);
        (v1, v2)
    }

    fun credit_lender_balance<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.lender_balances, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.lender_balances, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.lender_balances, arg1, arg2);
        };
    }

    fun debit_lender_balance<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, u64>(&arg0.lender_balances, arg1), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::nothing_to_redeem());
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.lender_balances, arg1);
        assert!(*v0 >= arg2, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::nothing_to_redeem());
        *v0 = *v0 - arg2;
        if (*v0 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.lender_balances, arg1);
        };
    }

    fun deposit_internal<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::OfferBook, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::object::ID, u64, u64, 0x2::object::ID, u64) {
        assert_version<T0, T1, T2>(arg0);
        assert!(arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_collecting(), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode());
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.deposit_deadline_ms, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::deposit_deadline_passed());
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_argument());
        assert!(arg3 != @0x0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_argument());
        assert!(arg3 != arg0.borrower, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::self_match_forbidden());
        assert!(0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::is_lender_allowed(arg1, arg3), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::lender_not_whitelisted());
        assert!(0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::is_request_lender_allowed(arg1, arg0.request_id, arg3), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::lender_not_whitelisted());
        assert!(arg0.total_deposited + v0 <= arg0.principal_target, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::vault_full());
        let v1 = convert_to_shares<T0, T1, T2>(arg0, v0);
        assert!(v1 > 0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::zero_shares());
        arg0.total_deposited = arg0.total_deposited + v0;
        arg0.total_shares = arg0.total_shares + v1;
        credit_lender_balance<T0, T1, T2>(arg0, arg3, v1);
        0x2::balance::join<T0>(&mut arg0.principal_escrow, 0x2::coin::into_balance<T0>(arg2));
        let v2 = 0x2::coin::mint<T2>(&mut arg0.share_treasury, v1, arg5);
        (v2, 0x2::object::id<0x2::coin::Coin<T2>>(&v2), v1, v0, 0x2::object::id<LendingVault<T0, T1, T2>>(arg0), 0x2::clock::timestamp_ms(arg4))
    }

    public fun deposit_principal<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::OfferBook, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2, v3, v4, v5, v6) = deposit_internal<T0, T1, T2>(arg0, arg1, arg2, v0, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, v0);
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_events::emit_lender_share_minted(v5, v2, v0, v4, v3, v6);
    }

    public fun deposit_principal_and_keep<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::OfferBook, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::tx_context::sender(arg4);
        deposit_principal_for_and_keep<T0, T1, T2>(arg0, arg1, arg2, v0, arg3, arg4)
    }

    public fun deposit_principal_for<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::OfferBook, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = deposit_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, arg3);
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_events::emit_lender_share_minted(v4, v1, arg3, v3, v2, v5);
    }

    public fun deposit_principal_for_and_keep<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::OfferBook, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1, v2, v3, v4, v5) = deposit_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_events::emit_lender_share_minted(v4, v1, arg3, v3, v2, v5);
        v0
    }

    public fun get_admin<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : address {
        arg0.admin
    }

    public fun get_borrower<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : address {
        arg0.borrower
    }

    public fun get_collateral_pool<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        0x2::balance::value<T1>(&arg0.collateral_escrow)
    }

    public fun get_collateral_token<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : address {
        arg0.collateral_token
    }

    public fun get_deposit_deadline_ms<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        arg0.deposit_deadline_ms
    }

    public fun get_matched_principal<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        arg0.matched_principal
    }

    public fun get_min_capacity<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        arg0.min_capacity
    }

    public fun get_mode<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u8 {
        arg0.mode
    }

    public fun get_payout_collateral_token<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : address {
        arg0.payout_collateral_token
    }

    public fun get_principal_pool<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.principal_escrow)
    }

    public fun get_principal_target<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        arg0.principal_target
    }

    public fun get_principal_token<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : address {
        arg0.principal_token
    }

    public fun get_repaid_amount<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        arg0.repaid_amount
    }

    public fun get_request_id<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        arg0.request_id
    }

    public fun get_total_deposited<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        arg0.total_deposited
    }

    public fun is_active<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : bool {
        arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_active()
    }

    public fun is_closed<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : bool {
        if (arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_settled()) {
            true
        } else if (arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted()) {
            true
        } else {
            arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_closed()
        }
    }

    public fun is_closed_lifecycle<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : bool {
        arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_closed()
    }

    public fun is_collateral_mode<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : bool {
        arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted() && arg0.is_collateral_payout
    }

    public fun is_collateral_payout<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : bool {
        arg0.is_collateral_payout
    }

    public fun is_collecting<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : bool {
        arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_collecting()
    }

    public fun is_defaulted<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : bool {
        arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted()
    }

    public fun is_matched<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : bool {
        arg0.mode != 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_collecting()
    }

    public fun is_settled<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : bool {
        arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_settled()
    }

    public fun is_soft_match<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : bool {
        let v0 = 0x2::balance::value<T0>(&arg0.principal_escrow);
        v0 >= arg0.min_capacity && v0 < arg0.principal_target
    }

    public(friend) fun mark_closed<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        assert_version<T0, T1, T2>(arg0);
        assert!(arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_collecting(), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode());
        transition_mode<T0, T1, T2>(arg0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_closed(), arg1);
    }

    public(friend) fun mark_default<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: &0x2::clock::Clock) {
        assert_version<T0, T1, T2>(arg0);
        assert!(arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_active(), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode());
        0x2::balance::join<T1>(&mut arg0.collateral_escrow, 0x2::coin::into_balance<T1>(arg1));
        arg0.payout_collateral_token = arg2;
        arg0.is_collateral_payout = true;
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_events::emit_collateral_pool_funded(0x2::object::id<LendingVault<T0, T1, T2>>(arg0), arg0.request_id, arg2, 0x2::coin::value<T1>(&arg1), 0x2::clock::timestamp_ms(arg3));
        transition_mode<T0, T1, T2>(arg0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted(), arg3);
    }

    public(friend) fun mark_default_status<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        assert_version<T0, T1, T2>(arg0);
        if (arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_active()) {
            arg0.is_collateral_payout = false;
            arg0.payout_collateral_token = @0x0;
            transition_mode<T0, T1, T2>(arg0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted(), arg1);
        } else if (arg0.mode != 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted() || arg0.is_collateral_payout) {
            abort 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode()
        };
    }

    public(friend) fun mark_funded<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0, T1, T2>(arg0);
        assert!(arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_collecting(), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode());
        let v0 = 0x2::balance::value<T0>(&arg0.principal_escrow);
        assert!(v0 >= arg0.min_capacity, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::soft_cap_not_reached());
        arg0.matched_principal = v0;
        transition_mode<T0, T1, T2>(arg0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_active(), arg1);
        take_principal<T0, T1, T2>(arg0, v0, arg2)
    }

    public(friend) fun mark_repaid<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        assert_version<T0, T1, T2>(arg0);
        assert!(arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_active(), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode());
        transition_mode<T0, T1, T2>(arg0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_settled(), arg1);
    }

    public fun migrate<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &VaultOperatorCap<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::unauthorized());
        let v0 = arg0.version;
        assert!(v0 < 5, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_state());
        arg0.version = 5;
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_events::emit_object_migrated(0x2::object::id<LendingVault<T0, T1, T2>>(arg0), v0, 5, 0x2::clock::timestamp_ms(arg2));
    }

    public fun preview_claim_collateral<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>, arg1: u64) : u64 {
        if (arg0.mode != 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted() || !arg0.is_collateral_payout) {
            return 0
        };
        collateral_assets_for_shares<T0, T1, T2>(arg0, arg1)
    }

    public fun preview_deposit<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>, arg1: u64) : u64 {
        convert_to_shares<T0, T1, T2>(arg0, arg1)
    }

    public fun preview_redeem<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>, arg1: u64) : u64 {
        if (arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted() && arg0.is_collateral_payout) {
            return 0
        };
        principal_assets_for_shares<T0, T1, T2>(arg0, arg1)
    }

    fun principal_assets_for_shares<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>, arg1: u64) : u64 {
        let v0 = arg0.total_shares;
        if (v0 == 0 || arg1 == 0) {
            return 0
        };
        let v1 = 0x2::balance::value<T0>(&arg0.principal_escrow);
        if (v1 == 0) {
            return 0
        };
        (((arg1 as u128) * (v1 as u128) / (v0 as u128)) as u64)
    }

    public(friend) fun receive_cancel_penalty<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>) {
        assert_version<T0, T1, T2>(arg0);
        assert!(arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_collecting() || arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_closed(), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode());
        0x2::balance::join<T0>(&mut arg0.principal_escrow, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun record_default_buyout<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) {
        assert_version<T0, T1, T2>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_argument());
        assert!(arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_active() || arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted() && !arg0.is_collateral_payout, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode());
        0x2::balance::join<T0>(&mut arg0.principal_escrow, 0x2::coin::into_balance<T0>(arg1));
        if (arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_active()) {
            arg0.is_collateral_payout = false;
            arg0.payout_collateral_token = @0x0;
            transition_mode<T0, T1, T2>(arg0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted(), arg2);
        };
    }

    public(friend) fun record_repayment<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>) : u64 {
        assert_version<T0, T1, T2>(arg0);
        assert!(arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_active(), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode());
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_argument());
        let v1 = if (arg0.total_deposited > arg0.repaid_amount) {
            arg0.total_deposited - arg0.repaid_amount
        } else {
            0
        };
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        arg0.repaid_amount = arg0.repaid_amount + v2;
        0x2::balance::join<T0>(&mut arg0.principal_escrow, 0x2::coin::into_balance<T0>(arg1));
        v0
    }

    public fun redeem<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted() && arg0.is_collateral_payout) {
            let v0 = redeem_collateral<T0, T1, T2>(arg0, arg1, arg2, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            let v1 = redeem_principal<T0, T1, T2>(arg0, arg1, arg2, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg3));
        };
    }

    public fun redeem_collateral<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg3);
        redeem_collateral_for<T0, T1, T2>(arg0, arg1, v0, arg2, arg3)
    }

    public fun redeem_collateral_for<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T2>(&arg1);
        0x2::coin::burn<T2>(&mut arg0.share_treasury, arg1);
        assert!(v0 > 0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::zero_shares());
        assert!(arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted() && arg0.is_collateral_payout, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode());
        debit_lender_balance<T0, T1, T2>(arg0, arg2, v0);
        let v1 = collateral_assets_for_shares<T0, T1, T2>(arg0, v0);
        assert!(arg0.total_shares >= v0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_state());
        arg0.total_shares = arg0.total_shares - v0;
        let v2 = take_collateral<T0, T1, T2>(arg0, v1, arg4);
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_events::emit_lender_collateral_claimed(0x2::object::id<LendingVault<T0, T1, T2>>(arg0), 0x2::object::id<LendingVault<T0, T1, T2>>(arg0), arg2, v0, arg0.payout_collateral_token, v1, 0x2::clock::timestamp_ms(arg3));
        v2
    }

    public fun redeem_principal<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        redeem_principal_for<T0, T1, T2>(arg0, arg1, v0, arg2, arg3)
    }

    public fun redeem_principal_for<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T2>(&arg1);
        0x2::coin::burn<T2>(&mut arg0.share_treasury, arg1);
        assert!(v0 > 0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::zero_shares());
        assert!(0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::is_principal_redeemable_mode(arg0.mode), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode());
        debit_lender_balance<T0, T1, T2>(arg0, arg2, v0);
        let v1 = principal_assets_for_shares<T0, T1, T2>(arg0, v0);
        assert!(arg0.total_shares >= v0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_state());
        arg0.total_shares = arg0.total_shares - v0;
        let v2 = take_principal<T0, T1, T2>(arg0, v1, arg4);
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_events::emit_lender_share_redeemed(0x2::object::id<LendingVault<T0, T1, T2>>(arg0), 0x2::object::id<LendingVault<T0, T1, T2>>(arg0), arg2, v0, v1, 0x2::clock::timestamp_ms(arg3));
        v2
    }

    public fun share_amount<T0: key>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public(friend) fun sweep_mistaken_principal<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0, T1, T2>(arg0);
        let v0 = 0x2::balance::value<T0>(&arg0.principal_escrow);
        let v1 = booked_principal_balance<T0, T1, T2>(arg0);
        assert!(v0 > v1, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::no_surplus_to_sweep());
        take_principal<T0, T1, T2>(arg0, v0 - v1, arg1)
    }

    public(friend) fun sweep_surplus<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0, T1, T2>(arg0);
        assert!(is_closed<T0, T1, T2>(arg0), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_vault_mode());
        assert!(arg0.total_shares == 0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_state());
        let v0 = 0x2::balance::value<T0>(&arg0.principal_escrow);
        assert!(v0 > 0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::no_surplus_to_sweep());
        take_principal<T0, T1, T2>(arg0, v0, arg1)
    }

    fun take_collateral<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.collateral_escrow, arg1), arg2)
    }

    fun take_principal<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.principal_escrow, arg1), arg2)
    }

    public fun total_assets<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        if (arg0.mode == 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_types::vault_mode_defaulted() && arg0.is_collateral_payout) {
            0
        } else {
            0x2::balance::value<T0>(&arg0.principal_escrow)
        }
    }

    public fun total_collateral<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        0x2::balance::value<T1>(&arg0.collateral_escrow)
    }

    public fun total_shares<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        arg0.total_shares
    }

    public fun total_supply<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        arg0.total_shares
    }

    public fun transfer_lender_shares<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T2>(&arg1);
        assert!(v0 > 0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::zero_shares());
        debit_lender_balance<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg3), v0);
        credit_lender_balance<T0, T1, T2>(arg0, arg2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg1, arg2);
    }

    fun transition_mode<T0, T1, T2: key>(arg0: &mut LendingVault<T0, T1, T2>, arg1: u8, arg2: &0x2::clock::Clock) {
        arg0.mode = arg1;
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_events::emit_vault_mode_changed(0x2::object::id<LendingVault<T0, T1, T2>>(arg0), arg0.request_id, arg0.mode, arg1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun vault_version<T0, T1, T2: key>(arg0: &LendingVault<T0, T1, T2>) : u64 {
        arg0.version
    }

    public fun version() : u64 {
        5
    }

    // decompiled from Move bytecode v7
}

