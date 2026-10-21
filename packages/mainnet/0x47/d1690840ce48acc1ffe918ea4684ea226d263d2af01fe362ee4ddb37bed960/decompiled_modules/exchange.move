module 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange {
    struct RewardTreasuryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DelegateKey has copy, drop, store {
        account_id: 0x2::object::ID,
        delegate: address,
    }

    struct ExactTotalsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ExactTotals has store {
        total_owed: u128,
        reserve_upnl: u128,
        reserve_stress: u128,
    }

    struct Exchange<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct ExchangeStateV1<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<T0>,
        user_free: u64,
        locked_margin: u64,
        lp_cash: u64,
        fee_growth: u64,
        open_exposure: u64,
        fee_lp: u64,
        fee_staker: u64,
        fee_dev: u64,
        tracked_lp: u64,
        tail_progress: u64,
        house_minted: u128,
        next_position_id: u64,
        next_claim_id: u64,
        total_owed: u64,
        reserve_upnl: u64,
        reserve_stress: u64,
        last_surplus_ms: u64,
        reserve_epoch: u64,
        oi_set: 0x2::table::Table<0x2::object::ID, bool>,
        pending_basis: 0x2::table::Table<0x2::object::ID, u64>,
        queue: 0x2::linked_table::LinkedTable<u64, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::lp::Claim>,
        free_balances: 0x2::table::Table<0x2::object::ID, u64>,
        referral_owed: u64,
        builder_owed: u64,
    }

    struct ReserveCheck {
        exchange_id: 0x2::object::ID,
        epoch: u64,
        seen: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    fun join<T0>(arg0: &mut Exchange<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut state_mut<T0>(arg0).vault, arg1);
    }

    public fun issue_bound<T0: drop, T1>(arg0: T0, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &Exchange<T1>) : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::issue_bound<T0>(arg0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid(arg1), &arg2.id)
    }

    public fun issue_refund<T0: drop, T1>(arg0: T0, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &Exchange<T1>) : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::issue_refund<T0>(arg0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid(arg1), 0x2::object::id<Exchange<T1>>(arg2))
    }

    public fun grant_delegate<T0>(arg0: &mut Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg1, 0x2::object::id<Exchange<T0>>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::grant_delegate<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = DelegateKey{
            account_id : 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg1),
            delegate   : arg4,
        };
        if (!0x2::dynamic_field::exists<DelegateKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<DelegateKey, bool>(&mut arg0.id, v0, true);
        };
    }

    public fun revoke_delegate<T0>(arg0: &mut Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg1, 0x2::object::id<Exchange<T0>>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::revoke_delegate<T0>(arg1, arg2, arg3, arg4, arg5);
        let v0 = DelegateKey{
            account_id : 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg1),
            delegate   : arg4,
        };
        if (0x2::dynamic_field::exists<DelegateKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<DelegateKey, bool>(&mut arg0.id, v0);
        };
    }

    public fun assert_version<T0>(arg0: &Exchange<T0>) {
        assert!(arg0.version == 1, 13835060997334761473);
    }

    public fun uid<T0>(arg0: &Exchange<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun accrue_builder_owed<T0>(arg0: &mut Exchange<T0>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg0);
        v0.builder_owed = v0.builder_owed + arg1;
    }

    public fun accrue_referral_owed<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        if (arg2 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg1);
        v0.referral_owed = v0.referral_owed + arg2;
    }

    public fun add_fee<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = state_mut<T0>(arg1);
        v0.fee_lp = v0.fee_lp + arg2;
    }

    public fun add_open_exposure<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = state_mut<T0>(arg1);
        v0.open_exposure = v0.open_exposure + arg2;
    }

    public fun add_pending_basis<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: 0x2::object::ID, arg3: u64) {
        assert_auth<T0>(arg0, arg1);
        if (arg3 == 0) {
            return
        };
        let v0 = &mut state_mut<T0>(arg1).pending_basis;
        let v1 = if (0x2::table::contains<0x2::object::ID, u64>(v0, arg2)) {
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, u64>(v0, arg2);
            let v3 = (*v2 as u128) + (arg3 as u128);
            let v4 = if (v3 > 18446744073709551615) {
                18446744073709551615
            } else {
                (v3 as u64)
            };
            *v2 = v4;
            *v2
        } else {
            0x2::table::add<0x2::object::ID, u64>(v0, arg2, arg3);
            arg3
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_pending_basis_event(arg2, arg3, v1);
    }

    public fun adjust_reserve<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool) {
        assert_auth<T0>(arg0, arg1);
        let v0 = state_mut<T0>(arg1);
        let v1 = exact_mut<T0>(v0);
        v1.reserve_upnl = v1.reserve_upnl - (arg3 as u128) + (arg5 as u128);
        v1.reserve_stress = v1.reserve_stress - (arg4 as u128) + (arg6 as u128);
        sync_views<T0>(v0);
        let v2 = 0x2::table::contains<0x2::object::ID, bool>(&v0.oi_set, arg2);
        if (arg7 && !v2) {
            0x2::table::add<0x2::object::ID, bool>(&mut v0.oi_set, arg2, true);
        } else if (v2 && !arg7) {
            0x2::table::remove<0x2::object::ID, bool>(&mut v0.oi_set, arg2);
        };
    }

    public fun alloc_position_id<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>) : u64 {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_on_exchange(arg0, &arg1.id);
        let v0 = state_mut<T0>(arg1);
        let v1 = v0.next_position_id;
        v0.next_position_id = v1 + 1;
        v1
    }

    fun assert_auth<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &Exchange<T0>) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_on_exchange(arg0, &arg1.id);
    }

    public fun assert_identity<T0>(arg0: &Exchange<T0>) {
        let v0 = state<T0>(arg0);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::buckets_conserve(v0.user_free, v0.locked_margin, v0.lp_cash, v0.fee_lp, v0.fee_staker, v0.fee_dev, v0.referral_owed, v0.builder_owed, v0.fee_growth, 0x2::balance::value<T0>(&v0.vault)), 13835342549621014531);
    }

    fun assert_usdc<T0>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC";
        assert!(0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)) == &v1, 13835627005305159685);
    }

    public fun begin_reserve_check<T0>(arg0: &Exchange<T0>) : ReserveCheck {
        assert_version<T0>(arg0);
        ReserveCheck{
            exchange_id : 0x2::object::id<Exchange<T0>>(arg0),
            epoch       : state<T0>(arg0).reserve_epoch,
            seen        : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun builder_owed<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).builder_owed
    }

    public fun burn_reward<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_on_exchange(arg0, &arg1.id);
        let v0 = RewardTreasuryKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(&arg1.id, v0), 13836187210774741001);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v2 = RewardTreasuryKey{dummy_field: false};
        0x2::balance::decrease_supply<T1>(0x2::coin::supply_mut<T1>(0x2::dynamic_field::borrow_mut<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(uid_mut<T0>(&v1, arg1), v2)), arg2);
    }

    public fun carve_builder<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64, arg3: u64, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: 0x1::option::Option<u32>, arg8: u16, arg9: u8) : u64 {
        assert_auth<T0>(arg0, arg1);
        let v0 = if (arg2 == 0) {
            true
        } else if (arg8 == 0) {
            true
        } else {
            0x1::option::is_none<u32>(&arg7)
        };
        if (v0) {
            return 0
        };
        let v1 = *0x1::option::borrow<u32>(&arg7);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::payout(uid<T0>(arg1), v1);
        if (v2 == arg4) {
            return 0
        };
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::floor_cut(arg2, arg8, arg3);
        if (v3 == 0) {
            return 0
        };
        let v4 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        debit_fee_lp<T0>(&v4, arg1, v3);
        let v5 = credit_builder<T0>(arg1, v2, v3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_builder_fee_accrued_event(0x2::object::id<Exchange<T0>>(arg1), v1, v2, arg5, arg6, arg9, arg2, v3, v5);
        v3
    }

    fun clamp_u64(arg0: u128) : u64 {
        if (arg0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (arg0 as u64)
        }
    }

    public fun create_and_share<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg0), arg1);
        assert_usdc<T0>();
        let v0 = create_inner<T0>(arg2);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, 0x2::object::id<Exchange<T0>>(&v0), 45);
        share_created<T0>(v0)
    }

    fun create_inner<T0>(arg0: &mut 0x2::tx_context::TxContext) : Exchange<T0> {
        let v0 = 1;
        let v1 = Exchange<T0>{
            id      : 0x2::object::new(arg0),
            version : v0,
        };
        let v2 = ExchangeStateV1<T0>{
            id               : 0x2::object::new(arg0),
            vault            : 0x2::balance::zero<T0>(),
            user_free        : 0,
            locked_margin    : 0,
            lp_cash          : 0,
            fee_growth       : 0,
            open_exposure    : 0,
            fee_lp           : 0,
            fee_staker       : 0,
            fee_dev          : 0,
            tracked_lp       : 0,
            tail_progress    : 0,
            house_minted     : 0,
            next_position_id : 1,
            next_claim_id    : 1,
            total_owed       : 0,
            reserve_upnl     : 0,
            reserve_stress   : 0,
            last_surplus_ms  : 0,
            reserve_epoch    : 0,
            oi_set           : 0x2::table::new<0x2::object::ID, bool>(arg0),
            pending_basis    : 0x2::table::new<0x2::object::ID, u64>(arg0),
            queue            : 0x2::linked_table::new<u64, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::lp::Claim>(arg0),
            free_balances    : 0x2::table::new<0x2::object::ID, u64>(arg0),
            referral_owed    : 0,
            builder_owed     : 0,
        };
        let v3 = ExactTotalsKey{dummy_field: false};
        let v4 = ExactTotals{
            total_owed     : 0,
            reserve_upnl   : 0,
            reserve_stress : 0,
        };
        0x2::dynamic_field::add<ExactTotalsKey, ExactTotals>(&mut v2.id, v3, v4);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::extended_field::add<ExchangeStateV1<T0>>(&mut v1.id, v0, v2);
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v6 = &mut v1;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::referral_book::attach(uid_mut<T0>(&v5, v6), arg0);
        let v7 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v8 = &mut v1;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::attach(uid_mut<T0>(&v7, v8), arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_create_exchange_event(0x2::object::id<Exchange<T0>>(&v1));
        v1
    }

    public fun credit_account_free<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: 0x2::object::ID, arg3: u64) {
        assert_auth<T0>(arg0, arg1);
        credit_free<T0>(arg1, arg2, arg3);
    }

    fun credit_builder<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64) : 0x1::option::Option<0x2::object::ID> {
        if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::account_exists(uid<T0>(arg0), arg1)) {
            let v1 = 0x2::object::id_from_address(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::account_address(0x2::object::id<Exchange<T0>>(arg0), arg1));
            settle_builder_pending<T0>(arg0, arg1, v1);
            let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
            credit_account_free<T0>(&v2, arg0, v1, arg2);
            0x1::option::some<0x2::object::ID>(v1)
        } else {
            let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
            let v4 = uid_mut<T0>(&v3, arg0);
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::add_pending(v4, arg1, arg2);
            accrue_builder_owed<T0>(arg0, arg2);
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun credit_close_fee<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg4: 0x2::coin::Coin<T0>) {
        assert_auth<T0>(arg0, arg1);
        assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg2, 0x2::object::id<Exchange<T0>>(arg1));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_cap<T0>(arg2, arg3);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 13835903888961961991);
        let v1 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2);
        join<T0>(arg1, 0x2::coin::into_balance<T0>(arg4));
        credit_free<T0>(arg1, v1, v0);
        assert_identity<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_deposit_event(v1, v0);
    }

    fun credit_free<T0>(arg0: &mut Exchange<T0>, arg1: 0x2::object::ID, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg0);
        if (!0x2::table::contains<0x2::object::ID, u64>(&v0.free_balances, arg1)) {
            0x2::table::add<0x2::object::ID, u64>(&mut v0.free_balances, arg1, arg2);
        } else {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut v0.free_balances, arg1);
            *v1 = *v1 + arg2;
        };
        v0.user_free = v0.user_free + arg2;
    }

    public(friend) fun credit_lp<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool) {
        let v0 = state_mut<T0>(arg0);
        v0.lp_cash = v0.lp_cash + arg1;
        if (arg2) {
            v0.tracked_lp = v0.tracked_lp + arg1;
        };
    }

    fun credit_referral_reward<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::account_exists(&arg0.id, arg1)) {
            let v1 = 0x2::object::id_from_address(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::account_address(0x2::object::id<Exchange<T0>>(arg0), arg1));
            let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::referral_book::take_pending(&v0, &mut arg0.id, arg1);
            if (v2 > 0) {
                release_referral_owed<T0>(&v0, arg0, v2);
                credit_free<T0>(arg0, v1, v2);
                0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_referral_settled_event(&v0, arg1, v1, v2);
            };
            credit_free<T0>(arg0, v1, arg2);
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_referral_payout_event(&v0, arg1, arg2, 0x1::option::some<0x2::object::ID>(v1));
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::referral_book::add_pending(&v0, &mut arg0.id, arg1, arg2);
            accrue_referral_owed<T0>(&v0, arg0, arg2);
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_referral_payout_event(&v0, arg1, arg2, 0x1::option::none<0x2::object::ID>());
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::referral_book::add_earned(&v0, &mut arg0.id, arg1, arg2);
    }

    public fun debit_account_free<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: 0x2::object::ID, arg3: u64) {
        assert_auth<T0>(arg0, arg1);
        if (arg3 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut v0.free_balances, arg2);
        *v1 = *v1 - arg3;
        v0.user_free = v0.user_free - arg3;
    }

    public fun debit_fee_lp<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        if (arg2 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg1);
        v0.fee_lp = v0.fee_lp - arg2;
    }

    public fun debit_lp<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = state_mut<T0>(arg1);
        v0.lp_cash = v0.lp_cash - arg2;
    }

    public fun debit_tracked<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = state_mut<T0>(arg1);
        if (v0.tracked_lp >= arg2) {
            v0.tracked_lp = v0.tracked_lp - arg2;
        } else {
            v0.tracked_lp = 0;
        };
    }

    public fun deposit<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg4: 0x2::coin::Coin<T0>) {
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_deposits());
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg2, 0x2::object::id<Exchange<T0>>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_cap<T0>(arg2, arg3);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 13835903790177714183);
        let v1 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2);
        join<T0>(arg0, 0x2::coin::into_balance<T0>(arg4));
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        credit_account_free<T0>(&v2, arg0, v1, v0);
        assert_identity<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_deposit_event(v1, v0);
    }

    public fun emergency_drain<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg3: u64) : vector<u64> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        let v0 = harvest<T0>(arg0, arg1, arg3);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v1, 0x2::object::id<Exchange<T0>>(arg0), 12);
        v0
    }

    public(friend) fun enqueue<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        enqueue_with_builder<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<u32>(), 0);
    }

    public fun enqueue_with_builder<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u32>, arg8: u16) {
        assert_auth<T0>(arg0, arg1);
        let v0 = state_mut<T0>(arg1);
        let v1 = v0.next_claim_id;
        v0.next_claim_id = v1 + 1;
        let v2 = exact_mut<T0>(v0);
        v2.total_owed = v2.total_owed + (arg4 as u128) + (arg5 as u128);
        sync_views<T0>(v0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::lp::push_with_builder(&mut v0.queue, v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_enqueue_payout_event(v1, arg4);
    }

    fun ensure_free_row<T0>(arg0: &mut Exchange<T0>, arg1: 0x2::object::ID) {
        let v0 = state_mut<T0>(arg0);
        if (!0x2::table::contains<0x2::object::ID, u64>(&v0.free_balances, arg1)) {
            0x2::table::add<0x2::object::ID, u64>(&mut v0.free_balances, arg1, 0);
        };
    }

    public(friend) fun equity<T0>(arg0: &Exchange<T0>) : u64 {
        let v0 = state<T0>(arg0);
        let v1 = exact<T0>(v0).total_owed;
        if ((v0.lp_cash as u128) > v1) {
            (((v0.lp_cash as u128) - v1) as u64)
        } else {
            0
        }
    }

    fun exact<T0>(arg0: &ExchangeStateV1<T0>) : &ExactTotals {
        let v0 = ExactTotalsKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExactTotalsKey, ExactTotals>(&arg0.id, v0)
    }

    fun exact_mut<T0>(arg0: &mut ExchangeStateV1<T0>) : &mut ExactTotals {
        let v0 = ExactTotalsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExactTotalsKey, ExactTotals>(&mut arg0.id, v0)
    }

    public(friend) fun fee_dev<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).fee_dev
    }

    public fun fee_growth<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).fee_growth
    }

    public(friend) fun fee_lp<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).fee_lp
    }

    public(friend) fun fee_staker<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).fee_staker
    }

    fun finish_check<T0>(arg0: &Exchange<T0>, arg1: ReserveCheck) {
        let ReserveCheck {
            exchange_id : v0,
            epoch       : v1,
            seen        : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<Exchange<T0>>(arg0), 13837595693760512019);
        assert!(v1 == state<T0>(arg0).reserve_epoch, 13838158648009031701);
        let v3 = &state<T0>(arg0).oi_set;
        let v4 = 0x2::vec_set::into_keys<0x2::object::ID>(v2);
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x2::object::ID>(&v4)) {
            if (0x2::table::contains<0x2::object::ID, bool>(v3, *0x1::vector::borrow<0x2::object::ID>(&v4, v6))) {
                v5 = v5 + 1;
            };
            v6 = v6 + 1;
        };
        assert!(v5 == 0x2::table::length<0x2::object::ID, bool>(v3), 13837314270323277841);
    }

    public fun free_balance<T0>(arg0: &Exchange<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = &state<T0>(arg0).free_balances;
        if (!0x2::table::contains<0x2::object::ID, u64>(v0, arg1)) {
            0
        } else {
            *0x2::table::borrow<0x2::object::ID, u64>(v0, arg1)
        }
    }

    public fun harvest<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: u64) : vector<u64> {
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_harvest());
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::harvest_batch_cap(arg1);
        if (arg2 > v0) {
            arg2 = v0;
        };
        let v1 = lp_cash<T0>(arg0);
        let v2 = state_mut<T0>(arg0);
        let (v3, v4, v5, v6, v7, v8, v9, v10, v11) = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::lp::take_fitting_full(&mut v2.queue, v1, arg2);
        let v12 = v10;
        let v13 = v9;
        let v14 = v8;
        let v15 = v7;
        let v16 = v6;
        let v17 = v5;
        let v18 = v4;
        let v19 = v3;
        if (v11 > 0) {
            let v20 = 0;
            let v21 = 0;
            while (v21 < 0x1::vector::length<u64>(&v17)) {
                v20 = v20 + *0x1::vector::borrow<u64>(&v17, v21);
                v21 = v21 + 1;
            };
            let v22 = state_mut<T0>(arg0);
            v22.lp_cash = v22.lp_cash - v11;
            let v23 = exact_mut<T0>(v22);
            v23.total_owed = v23.total_owed - (v11 as u128);
            sync_views<T0>(v22);
            v22.fee_lp = v22.fee_lp + v20;
        };
        let v24 = 0;
        while (v24 < 0x1::vector::length<u64>(&v18)) {
            let v25 = *0x1::vector::borrow<0x2::object::ID>(&v15, v24);
            let v26 = *0x1::vector::borrow<u64>(&v18, v24);
            let v27 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
            credit_account_free<T0>(&v27, arg0, v25, v26);
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_harvest_payout_event(*0x1::vector::borrow<u64>(&v19, v24), v25, v26);
            v24 = v24 + 1;
        };
        let v28 = 0;
        let v29 = 0;
        while (v29 < 0x1::vector::length<u64>(&v17)) {
            let (v30, v31, v32) = split_queued_fee<T0>(arg0, arg1, *0x1::vector::borrow<u64>(&v17, v29), *0x1::vector::borrow<address>(&v16, v29), *0x1::vector::borrow<0x2::object::ID>(&v15, v29));
            let v33 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
            let v34 = carve_builder<T0>(&v33, arg0, v32, v32, *0x1::vector::borrow<address>(&v16, v29), *0x1::vector::borrow<0x2::object::ID>(&v15, v29), *0x1::vector::borrow<u64>(&v12, v29), *0x1::vector::borrow<0x1::option::Option<u32>>(&v14, v29), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::effective_builder_share(arg1, *0x1::vector::borrow<u16>(&v13, v29)), 2);
            v28 = v28 + v32 - v34;
            if (*0x1::vector::borrow<u64>(&v17, v29) > 0) {
                0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_harvest_fees_event(*0x1::vector::borrow<u64>(&v19, v29), *0x1::vector::borrow<0x2::object::ID>(&v15, v29), *0x1::vector::borrow<u64>(&v17, v29), v30, v31, v34, v32 - v34);
            };
            v29 = v29 + 1;
        };
        let v35 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        route_retained<T0>(&v35, arg0, arg1, v28);
        assert_identity<T0>(arg0);
        v18
    }

    public fun has_reward_treasury<T0, T1>(arg0: &Exchange<T0>) : bool {
        let v0 = RewardTreasuryKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(&arg0.id, v0)
    }

    public fun house_minted<T0>(arg0: &Exchange<T0>) : u128 {
        state<T0>(arg0).house_minted
    }

    public fun house_tail(arg0: u128) : u64 {
        if (arg0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (arg0 as u64)
        }
    }

    public fun in_oi_set<T0>(arg0: &Exchange<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&state<T0>(arg0).oi_set, arg1)
    }

    public fun install_reward_cap<T0, T1>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg3: 0x2::coin::TreasuryCap<T1>) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        let v0 = RewardTreasuryKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<RewardTreasuryKey>(&arg0.id, v0), 13836467122383486987);
        let v1 = 0x2::object::id<Exchange<T0>>(arg0);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v3 = RewardTreasuryKey{dummy_field: false};
        0x2::dynamic_field::add<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(uid_mut<T0>(&v2, arg0), v3, arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_parchment_cap_installed_event(v1);
        let v4 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v4, v1, 44);
    }

    public fun is_account_delegate<T0>(arg0: &Exchange<T0>, arg1: 0x2::object::ID, arg2: address) : bool {
        let v0 = DelegateKey{
            account_id : arg1,
            delegate   : arg2,
        };
        0x2::dynamic_field::exists<DelegateKey>(&arg0.id, v0)
    }

    public fun last_surplus_ms<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).last_surplus_ms
    }

    public fun lock_open<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64, arg3: u64) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_on_exchange(arg0, &arg1.id);
        let v0 = state_mut<T0>(arg1);
        v0.locked_margin = v0.locked_margin + arg2 - arg3;
        v0.fee_lp = v0.fee_lp + arg3;
        assert_identity<T0>(arg1);
    }

    public(friend) fun locked_margin<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).locked_margin
    }

    public fun lp_cash<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).lp_cash
    }

    public fun mint_reward<T0, T1>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_on_exchange(arg0, &arg1.id);
        let v0 = RewardTreasuryKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(&arg1.id, v0), 13836187167825068041);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v2 = RewardTreasuryKey{dummy_field: false};
        0x2::coin::mint<T1>(0x2::dynamic_field::borrow_mut<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(uid_mut<T0>(&v1, arg1), v2), arg2, arg3)
    }

    public fun next_position_id<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).next_position_id
    }

    public fun note_checked(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut ReserveCheck, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_bound(arg0, arg2);
        assert!(arg1.exchange_id == arg2, 13837595646515871763);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg1.seen, &arg3)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg1.seen, arg3);
        };
    }

    public fun note_minted_loss<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        if (arg2 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg1);
        v0.house_minted = sat_add_u128(v0.house_minted, (arg2 as u128));
        let v1 = v0.house_minted;
        let v2 = 0x1::u64::max(house_tail(v1), v0.tail_progress);
        v0.tail_progress = v2;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_house_result_event(0x2::object::id<Exchange<T0>>(arg1), v1, v2);
    }

    public fun oi_markets<T0>(arg0: &Exchange<T0>) : u64 {
        0x2::table::length<0x2::object::ID, bool>(&state<T0>(arg0).oi_set)
    }

    public fun open_account<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_accounts());
        assert_usdc<T0>();
        let (v0, v1) = open_account_inner<T0>(arg0, arg2);
        0x2::transfer::public_share_object<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(v0);
        0x2::transfer::public_transfer<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap>(v1, 0x2::tx_context::sender(arg2));
    }

    fun open_account_inner<T0>(arg0: &mut Exchange<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::object::id<Exchange<T0>>(arg0);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v3 = uid_mut<T0>(&v2, arg0);
        let (v4, v5) = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::create<T0>(v3, v1, v0, arg1);
        let v6 = v4;
        let v7 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(&v6);
        ensure_free_row<T0>(arg0, v7);
        let v8 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v9 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v10 = uid_mut<T0>(&v9, arg0);
        let v11 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::referral_book::take_pending(&v8, v10, v0);
        if (v11 > 0) {
            let v12 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
            release_referral_owed<T0>(&v12, arg0, v11);
            let v13 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
            credit_account_free<T0>(&v13, arg0, v7, v11);
            let v14 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_referral_settled_event(&v14, v0, v7, v11);
        };
        let v15 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v16 = uid_mut<T0>(&v15, arg0);
        let v17 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::take_pending(v16, v0);
        if (v17 > 0) {
            release_builder_owed<T0>(arg0, v17);
            let v18 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
            credit_account_free<T0>(&v18, arg0, v7, v17);
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_builder_pending_settled_event(0x2::object::id<Exchange<T0>>(arg0), v0, v7, v17);
        };
        (v6, v5)
    }

    public fun open_exposure<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).open_exposure
    }

    public fun pending_basis<T0>(arg0: &Exchange<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = &state<T0>(arg0).pending_basis;
        if (0x2::table::contains<0x2::object::ID, u64>(v0, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(v0, arg1)
        } else {
            0
        }
    }

    public(friend) fun queue_len<T0>(arg0: &Exchange<T0>) : u64 {
        0x2::linked_table::length<u64, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::lp::Claim>(&state<T0>(arg0).queue)
    }

    public fun queue_length<T0>(arg0: &Exchange<T0>) : u64 {
        queue_len<T0>(arg0)
    }

    public fun queue_nonempty<T0>(arg0: &Exchange<T0>) : bool {
        0x2::linked_table::length<u64, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::lp::Claim>(&state<T0>(arg0).queue) > 0
    }

    public fun realize_loss<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64, arg3: u64) : u64 {
        assert_auth<T0>(arg0, arg1);
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::bps_of(arg2, arg3);
        if (v0 > 0) {
            let v1 = state_mut<T0>(arg1);
            v1.fee_lp = v1.fee_lp + v0;
        };
        let v2 = arg2 - v0;
        if (!queue_nonempty<T0>(arg1)) {
            credit_lp<T0>(arg1, v2, true);
            return v0
        };
        let v3 = state<T0>(arg1);
        let v4 = exact<T0>(v3).total_owed;
        let v5 = if ((v3.lp_cash as u128) < v4) {
            clamp_u64(v4 - (v3.lp_cash as u128))
        } else {
            0
        };
        let v6 = if (v2 > v5) {
            v2 - v5
        } else {
            0
        };
        if (v6 > 0) {
            credit_lp<T0>(arg1, v6, true);
        };
        if (v2 > v6) {
            credit_lp<T0>(arg1, v2 - v6, false);
        };
        v0
    }

    public fun recommended_harvest_batch() : u64 {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::lp::recommended_batch()
    }

    public fun recover_dust<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_lp());
        let v0 = state_mut<T0>(arg0);
        let v1 = v0.fee_dev;
        assert!(v1 > 0, 13835904438717775879);
        v0.fee_dev = 0;
        let v2 = split_coin<T0>(arg0, v1, arg3);
        assert_identity<T0>(arg0);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v3, 0x2::object::id<Exchange<T0>>(arg0), 13);
        let v4 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v4, 0x2::object::id<Exchange<T0>>(arg0), 13, v1);
        v2
    }

    public fun referral_owed<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).referral_owed
    }

    public fun refund_escrow<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: 0x2::object::ID, arg3: 0x2::balance::Balance<T0>) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_bound_refund(arg0, 0x2::object::uid_to_inner(&arg1.id));
        let v0 = 0x2::balance::value<T0>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return
        };
        join<T0>(arg1, arg3);
        credit_free<T0>(arg1, arg2, v0);
    }

    public fun register_extension<T0: drop, T1>(arg0: &mut Exchange<T1>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        assert_version<T1>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::register_mirror_uid<T0>(&mut arg0.id, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid(arg1));
    }

    public(friend) fun release_builder_owed<T0>(arg0: &mut Exchange<T0>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg0);
        v0.builder_owed = v0.builder_owed - arg1;
    }

    public fun release_referral_owed<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        if (arg2 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg1);
        v0.referral_owed = v0.referral_owed - arg2;
    }

    public fun reserve<T0>(arg0: &Exchange<T0>) : u128 {
        let v0 = exact<T0>(state<T0>(arg0));
        v0.total_owed + v0.reserve_upnl + v0.reserve_stress
    }

    public fun reserve_epoch<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).reserve_epoch
    }

    public fun reserve_stress<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).reserve_stress
    }

    public fun reserve_upnl<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).reserve_upnl
    }

    public fun reverse_minted_loss<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        if (arg2 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg1);
        let v1 = (arg2 as u128);
        let v2 = if (v0.house_minted > v1) {
            v0.house_minted - v1
        } else {
            0
        };
        v0.house_minted = v2;
        let v3 = v0.house_minted;
        let v4 = house_tail(v3);
        v0.tail_progress = v4;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_house_result_event(0x2::object::id<Exchange<T0>>(arg1), v3, v4);
    }

    public fun reward_supply<T0, T1>(arg0: &Exchange<T0>) : u64 {
        assert!(has_reward_treasury<T0, T1>(arg0), 13836187107695525897);
        let v0 = RewardTreasuryKey{dummy_field: false};
        0x2::coin::total_supply<T1>(0x2::dynamic_field::borrow<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(&arg0.id, v0))
    }

    public fun route_retained<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: u64) {
        assert_auth<T0>(arg0, arg1);
        route_retained_inner<T0>(arg1, arg2, arg3);
    }

    fun route_retained_inner<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::bps_of(arg2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::retained_staker_bps(state<T0>(arg0).lp_cash, reserve<T0>(arg0), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::staker_share_min_bps(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::staker_share_max_bps(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::staker_cov_low_bps(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::staker_cov_high_bps(arg1)));
        let v1 = state_mut<T0>(arg0);
        v1.fee_lp = v1.fee_lp - v0;
        v1.fee_staker = v1.fee_staker + v0;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_fees_routed_event(0x2::object::id<Exchange<T0>>(arg0), arg2, v0, arg2 - v0, 0);
    }

    fun sat_add_u128(arg0: u128, arg1: u128) : u128 {
        let v0 = 340282366920938463463374607431768211455;
        if (arg0 > v0 - arg1) {
            v0
        } else {
            arg0 + arg1
        }
    }

    public fun seed_lp<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg3: 0x2::coin::Coin<T0>) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_lp());
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 13835904069350588423);
        join<T0>(arg0, 0x2::coin::into_balance<T0>(arg3));
        let v1 = state_mut<T0>(arg0);
        v1.lp_cash = v1.lp_cash + v0;
        v1.tracked_lp = v1.tracked_lp + v0;
        assert_identity<T0>(arg0);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v2, 0x2::object::id<Exchange<T0>>(arg0), 20);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_value(&v3, 0x2::object::id<Exchange<T0>>(arg0), 20, v0);
    }

    fun settle_builder_pending<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: 0x2::object::ID) {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        let v1 = uid_mut<T0>(&v0, arg0);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::take_pending(v1, arg1);
        if (v2 == 0) {
            return
        };
        release_builder_owed<T0>(arg0, v2);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        credit_account_free<T0>(&v3, arg0, arg2, v2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_builder_pending_settled_event(0x2::object::id<Exchange<T0>>(arg0), arg1, arg2, v2);
    }

    fun share_created<T0>(arg0: Exchange<T0>) : 0x2::object::ID {
        0x2::transfer::share_object<Exchange<T0>>(arg0);
        0x2::object::id<Exchange<T0>>(&arg0)
    }

    public fun split_balance<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_auth<T0>(arg0, arg1);
        0x2::balance::split<T0>(&mut state_mut<T0>(arg1).vault, arg2)
    }

    fun split_coin<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut state_mut<T0>(arg0).vault, arg1), arg2)
    }

    public fun split_out<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_auth<T0>(arg0, arg1);
        split_coin<T0>(arg1, arg2, arg3)
    }

    fun split_queued_fee<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: u64, arg3: address, arg4: 0x2::object::ID) : (u64, u64, u64) {
        if (arg2 == 0 || !0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referral_enabled(arg1)) {
            return (0, 0, arg2)
        };
        let (v0, v1, v2, v3) = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::referral_book::payout_targets(&arg0.id, arg3);
        if (!v0) {
            return (0, 0, arg2)
        };
        let v4 = 0x1::u64::min(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::bps_of(arg2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referee_discount_bps(arg1)), arg2);
        let v5 = arg2 - v4;
        let v6 = 0x1::u64::min(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::bps_of(arg2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referral_fee_bps(arg1)), v5);
        let v7 = if (v2) {
            0x1::u64::min(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::bps_of(arg2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::second_level_fee_bps(arg1)), v5 - v6)
        } else {
            0
        };
        let v8 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        debit_fee_lp<T0>(&v8, arg0, v4 + v6 + v7);
        credit_free<T0>(arg0, arg4, v4);
        credit_referral_reward<T0>(arg0, v1, v6);
        credit_referral_reward<T0>(arg0, v3, v7);
        (v4, v6 + v7, v5 - v6 - v7)
    }

    public fun staker_fees<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).fee_staker
    }

    fun state<T0>(arg0: &Exchange<T0>) : &ExchangeStateV1<T0> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::extended_field::borrow<ExchangeStateV1<T0>>(&arg0.id, arg0.version)
    }

    fun state_mut<T0>(arg0: &mut Exchange<T0>) : &mut ExchangeStateV1<T0> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::extended_field::borrow_mut<ExchangeStateV1<T0>>(&mut arg0.id, arg0.version)
    }

    public fun sub_open_exposure<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = state_mut<T0>(arg1);
        v0.open_exposure = v0.open_exposure - arg2;
    }

    public fun sweep_surplus<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: ReserveCheck, arg3: &0x2::clock::Clock) : u64 {
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_lp());
        finish_check<T0>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = state<T0>(arg0).last_surplus_ms;
        assert!(v1 == 0 || v0 >= v1 + 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::surplus_interval_ms(arg1), 13836751659672010765);
        assert!(0x2::linked_table::length<u64, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::lp::Claim>(&state<T0>(arg0).queue) == 0, 13837033138943819791);
        let v2 = reserve<T0>(arg0);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::surplus_take(state<T0>(arg0).lp_cash, v2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::surplus_floor_bps(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::surplus_max_bps(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::surplus_cap_bps(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::surplus_cash_floor(arg1));
        assert!(v3 > 0, 13837033186188460047);
        let v4 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::bps_of(v3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::surplus_staker_bps(arg1));
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::bps_of(v3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::surplus_treasury_bps(arg1));
        let v6 = v3 - v4 - v5;
        let v7 = state_mut<T0>(arg0);
        v7.lp_cash = v7.lp_cash - v3;
        let v8 = if (v7.tracked_lp >= v3) {
            v7.tracked_lp - v3
        } else {
            0
        };
        v7.tracked_lp = v8;
        v7.fee_staker = v7.fee_staker + v4;
        v7.fee_lp = v7.fee_lp + v5;
        v7.fee_growth = v7.fee_growth + v6;
        v7.last_surplus_ms = v0;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_surplus_swept_event(0x2::object::id<Exchange<T0>>(arg0), v3, v4, v5, v6, v7.lp_cash, v2, v0);
        assert_identity<T0>(arg0);
        v3
    }

    fun sync_views<T0>(arg0: &mut ExchangeStateV1<T0>) {
        let v0 = exact<T0>(arg0);
        arg0.total_owed = clamp_u64(v0.total_owed);
        arg0.reserve_upnl = clamp_u64(v0.reserve_upnl);
        arg0.reserve_stress = clamp_u64(v0.reserve_stress);
    }

    public fun tail_progress<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).tail_progress
    }

    public fun take_pending_basis<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: 0x2::object::ID) : u64 {
        assert_auth<T0>(arg0, arg1);
        let v0 = &mut state_mut<T0>(arg1).pending_basis;
        if (0x2::table::contains<0x2::object::ID, u64>(v0, arg2)) {
            0x2::table::remove<0x2::object::ID, u64>(v0, arg2)
        } else {
            0
        }
    }

    public fun take_staker_rewards<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config) : 0x2::balance::Balance<T0> {
        assert_auth<T0>(arg0, arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_lp());
        let v0 = reserve<T0>(arg1);
        let v1 = state_mut<T0>(arg1);
        let v2 = v1.fee_staker;
        assert!(v2 > 0, 13835906405812797447);
        v1.fee_staker = 0;
        let v3 = if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_staker_rewards_taken(0x2::object::id<Exchange<T0>>(arg1), v2, 0, v3, v1.lp_cash);
        let v4 = state_mut<T0>(arg1);
        assert_identity<T0>(arg1);
        0x2::balance::split<T0>(&mut v4.vault, v2)
    }

    public fun take_staking_referral_funding<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: u64) : 0x2::balance::Balance<T0> {
        assert_auth<T0>(arg0, arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_lp());
        let v0 = state_mut<T0>(arg1);
        let v1 = 0x1::u64::min(v0.fee_lp, arg3);
        v0.fee_lp = v0.fee_lp - v1;
        if (v1 > 0) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_staking_referral_funded_event(0x2::object::id<Exchange<T0>>(arg1), v1, v0.fee_lp);
        };
        let v2 = state_mut<T0>(arg1);
        assert_identity<T0>(arg1);
        0x2::balance::split<T0>(&mut v2.vault, v1)
    }

    public(friend) fun total_owed<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).total_owed
    }

    public fun tracked_lp<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).tracked_lp
    }

    public fun uid_mut<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>) : &mut 0x2::object::UID {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_on_exchange(arg0, &arg1.id);
        &mut arg1.id
    }

    public fun unlock_all<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = state_mut<T0>(arg1);
        v0.locked_margin = v0.locked_margin - arg2;
    }

    public fun unregister_extension<T0: drop, T1>(arg0: &mut Exchange<T1>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        assert_version<T1>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::unregister_uid<T0>(&mut arg0.id);
    }

    public(friend) fun user_free<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).user_free
    }

    public fun withdraw<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_withdrawals());
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg2, 0x2::object::id<Exchange<T0>>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_cap<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2);
        assert!(arg4 > 0 && free_balance<T0>(arg0, v0) >= arg4, 13835903987746209799);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        debit_account_free<T0>(&v1, arg0, v0, arg4);
        let v2 = split_coin<T0>(arg0, arg4, arg5);
        assert_identity<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_withdraw_event(v0, arg4);
        v2
    }

    public fun withdraw_fees<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::FEE_RECIPIENT>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_role<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::FEE_RECIPIENT>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid(arg1), 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_lp());
        let v0 = state_mut<T0>(arg0);
        let v1 = v0.fee_lp + v0.fee_dev;
        assert!(v1 > 0, 13835904271214051335);
        v0.fee_lp = 0;
        v0.fee_dev = 0;
        let v2 = split_coin<T0>(arg0, v1, arg3);
        assert_identity<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_claim_fees_event(v1);
        v2
    }

    public fun withdraw_growth<T0>(arg0: &mut Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::FEE_RECIPIENT>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_role<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::FEE_RECIPIENT>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid(arg1), 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_lp());
        let v0 = state_mut<T0>(arg0);
        let v1 = v0.fee_growth;
        assert!(v1 > 0, 13835907432309981191);
        v0.fee_growth = 0;
        let v2 = split_coin<T0>(arg0, v1, arg3);
        assert_identity<T0>(arg0);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::new();
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v3, 0x2::object::id<Exchange<T0>>(arg0), 74);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_growth_withdrawn_event(0x2::object::id<Exchange<T0>>(arg0), v1);
        v2
    }

    // decompiled from Move bytecode v7
}

