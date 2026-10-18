module 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange {
    struct RewardTreasuryKey has copy, drop, store {
        dummy_field: bool,
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
        next_position_id: u64,
        next_claim_id: u64,
        total_owed: u64,
        dist_paused: bool,
        reserve_upnl: u64,
        reserve_stress: u64,
        last_surplus_ms: u64,
        reserve_epoch: u64,
        oi_set: 0x2::table::Table<0x2::object::ID, bool>,
        pending_basis: 0x2::table::Table<0x2::object::ID, u64>,
        queue: 0x2::linked_table::LinkedTable<u64, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp::Claim>,
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

    public fun assert_version<T0>(arg0: &Exchange<T0>) {
        assert!(arg0.version == 1, 13835060125456400385);
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

    public fun accrue_referral_owed<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg1);
        v0.referral_owed = v0.referral_owed + arg2;
    }

    public fun add_fee<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        let v0 = state_mut<T0>(arg1);
        v0.fee_lp = v0.fee_lp + arg2;
    }

    public fun add_open_exposure<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        let v0 = state_mut<T0>(arg1);
        v0.open_exposure = v0.open_exposure + arg2;
    }

    public fun add_pending_basis<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: 0x2::object::ID, arg3: u64) {
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
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_pending_basis_event(arg2, arg3, v1);
    }

    public fun adjust_reserve<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: bool) {
        let v0 = state_mut<T0>(arg1);
        if (!arg9) {
            v0.reserve_epoch = v0.reserve_epoch + 1;
        };
        v0.reserve_upnl = v0.reserve_upnl - arg4 + arg6;
        v0.reserve_stress = v0.reserve_stress - arg5 + arg7;
        let v1 = 0x2::table::contains<0x2::object::ID, bool>(&v0.oi_set, arg3);
        if (arg8 && !v1) {
            0x2::table::add<0x2::object::ID, bool>(&mut v0.oi_set, arg3, true);
        } else if (v1 && !arg8) {
            0x2::table::remove<0x2::object::ID, bool>(&mut v0.oi_set, arg3);
        };
        let v2 = 0x2::table::length<0x2::object::ID, bool>(&v0.oi_set);
        let v3 = if (arg10) {
            if (v2 == 0) {
                true
            } else if (arg9) {
                if (v2 == 1) {
                    arg8
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        update_dist_with<T0>(arg1, arg2, v3);
    }

    public fun alloc_position_id<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>) : u64 {
        let v0 = state_mut<T0>(arg1);
        let v1 = v0.next_position_id;
        v0.next_position_id = v1 + 1;
        v1
    }

    public fun apply_reserve_check<T0>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: ReserveCheck) {
        assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        finish_check<T0>(arg0, arg2);
        update_dist_with<T0>(arg0, arg1, true);
    }

    public fun assert_identity<T0>(arg0: &Exchange<T0>) {
        let v0 = state<T0>(arg0);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::buckets_conserve(v0.user_free, v0.locked_margin, v0.lp_cash, v0.fee_lp, v0.fee_staker, v0.fee_dev, v0.referral_owed, v0.builder_owed, v0.fee_growth, 0x2::balance::value<T0>(&v0.vault)), 13835341677742653443);
    }

    fun assert_usdc<T0>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC";
        assert!(0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)) == &v1, 13835625549311246341);
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

    public fun carve_builder<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64, arg3: u64, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: 0x1::option::Option<u32>, arg8: u16, arg9: u8) : u64 {
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
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::payout(uid<T0>(arg1), v1);
        if (v2 == arg4) {
            return 0
        };
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::floor_cut(arg2, arg8, arg3);
        if (v3 == 0) {
            return 0
        };
        let v4 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        debit_fee_lp<T0>(&v4, arg1, v3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_builder_fee_accrued_event(v1, v2, arg5, arg6, arg9, arg2, v3, credit_builder<T0>(arg1, v2, v3));
        v3
    }

    public fun create_and_share<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg0), arg1);
        assert_usdc<T0>();
        let v0 = create_inner<T0>(arg2);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v1, 0x2::object::id<Exchange<T0>>(&v0), 45);
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
            next_position_id : 1,
            next_claim_id    : 1,
            total_owed       : 0,
            dist_paused      : false,
            reserve_upnl     : 0,
            reserve_stress   : 0,
            last_surplus_ms  : 0,
            reserve_epoch    : 0,
            oi_set           : 0x2::table::new<0x2::object::ID, bool>(arg0),
            pending_basis    : 0x2::table::new<0x2::object::ID, u64>(arg0),
            queue            : 0x2::linked_table::new<u64, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp::Claim>(arg0),
            free_balances    : 0x2::table::new<0x2::object::ID, u64>(arg0),
            referral_owed    : 0,
            builder_owed     : 0,
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::extended_field::add<ExchangeStateV1<T0>>(&mut v1.id, v0, v2);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        let v4 = &mut v1;
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::referral_book::attach(uid_mut<T0>(&v3, v4), arg0);
        let v5 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        let v6 = &mut v1;
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::attach(uid_mut<T0>(&v5, v6), arg0);
        let v7 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        let v8 = &mut v1;
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::game_book::attach_book(uid_mut<T0>(&v7, v8), arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_create_exchange_event(0x2::object::id<Exchange<T0>>(&v1));
        v1
    }

    public fun credit_account_free<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: 0x2::object::ID, arg3: u64) {
        if (arg3 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg1);
        if (!0x2::table::contains<0x2::object::ID, u64>(&v0.free_balances, arg2)) {
            0x2::table::add<0x2::object::ID, u64>(&mut v0.free_balances, arg2, arg3);
        } else {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut v0.free_balances, arg2);
            *v1 = *v1 + arg3;
        };
        v0.user_free = v0.user_free + arg3;
    }

    fun credit_builder<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64) : 0x1::option::Option<0x2::object::ID> {
        if (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::account_exists(uid<T0>(arg0), arg1)) {
            let v1 = 0x2::object::id_from_address(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::account_address(0x2::object::id<Exchange<T0>>(arg0), arg1));
            settle_builder_pending<T0>(arg0, arg1, v1);
            let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
            credit_account_free<T0>(&v2, arg0, v1, arg2);
            0x1::option::some<0x2::object::ID>(v1)
        } else {
            let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
            let v4 = uid_mut<T0>(&v3, arg0);
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::add_pending(v4, arg1, arg2);
            accrue_builder_owed<T0>(arg0, arg2);
            0x1::option::none<0x2::object::ID>()
        }
    }

    public(friend) fun credit_lp<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool) {
        let v0 = state_mut<T0>(arg0);
        v0.lp_cash = v0.lp_cash + arg1;
        if (arg2) {
            v0.tracked_lp = v0.tracked_lp + arg1;
        };
    }

    public fun debit_account_free<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: 0x2::object::ID, arg3: u64) {
        if (arg3 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut v0.free_balances, arg2);
        *v1 = *v1 - arg3;
        v0.user_free = v0.user_free - arg3;
    }

    public fun debit_fee_lp<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg1);
        v0.fee_lp = v0.fee_lp - arg2;
    }

    public fun debit_lp<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        let v0 = state_mut<T0>(arg1);
        v0.lp_cash = v0.lp_cash - arg2;
    }

    public fun debit_tracked<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        let v0 = state_mut<T0>(arg1);
        if (v0.tracked_lp >= arg2) {
            v0.tracked_lp = v0.tracked_lp - arg2;
        } else {
            v0.tracked_lp = 0;
        };
    }

    public fun deposit<T0>(arg0: &mut Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::AccountCap, arg3: 0x2::coin::Coin<T0>) {
        assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_exchange<T0>(arg1, 0x2::object::id<Exchange<T0>>(arg0));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_cap<T0>(arg1, arg2);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 13835903442285363207);
        let v1 = 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(arg1);
        join<T0>(arg0, 0x2::coin::into_balance<T0>(arg3));
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        credit_account_free<T0>(&v2, arg0, v1, v0);
        assert_identity<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_deposit_event(v1, v0);
    }

    public fun dist_paused<T0>(arg0: &Exchange<T0>) : bool {
        state<T0>(arg0).dist_paused
    }

    public fun distributing<T0>(arg0: &Exchange<T0>) : bool {
        let v0 = state<T0>(arg0);
        !v0.dist_paused && 0x2::linked_table::length<u64, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp::Claim>(&v0.queue) == 0
    }

    public fun emergency_drain<T0>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: u64) : vector<u64> {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        let v0 = harvest<T0>(arg0, arg1, arg3);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v1, 0x2::object::id<Exchange<T0>>(arg0), 12);
        v0
    }

    public(friend) fun enqueue<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        enqueue_with_builder<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<u32>(), 0);
    }

    public fun enqueue_with_builder<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u32>, arg8: u16) {
        let v0 = state_mut<T0>(arg1);
        let v1 = v0.next_claim_id;
        v0.next_claim_id = v1 + 1;
        v0.total_owed = v0.total_owed + arg4 + arg5;
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp::push_with_builder(&mut v0.queue, v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_enqueue_payout_event(v1, arg4);
    }

    fun ensure_free_row<T0>(arg0: &mut Exchange<T0>, arg1: 0x2::object::ID) {
        let v0 = state_mut<T0>(arg0);
        if (!0x2::table::contains<0x2::object::ID, u64>(&v0.free_balances, arg1)) {
            0x2::table::add<0x2::object::ID, u64>(&mut v0.free_balances, arg1, 0);
        };
    }

    public(friend) fun equity<T0>(arg0: &Exchange<T0>) : u64 {
        let v0 = state<T0>(arg0);
        if (v0.lp_cash > v0.total_owed) {
            v0.lp_cash - v0.total_owed
        } else {
            0
        }
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

    public fun fee_treasury<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).fee_lp
    }

    fun finish_check<T0>(arg0: &Exchange<T0>, arg1: ReserveCheck) {
        let ReserveCheck {
            exchange_id : v0,
            epoch       : v1,
            seen        : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<Exchange<T0>>(arg0), 13837594495464636435);
        assert!(v1 == state<T0>(arg0).reserve_epoch, 13838157449713287191);
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
        assert!(v5 == 0x2::table::length<0x2::object::ID, bool>(v3), 13837313072027402257);
    }

    public fun free_balance<T0>(arg0: &Exchange<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = &state<T0>(arg0).free_balances;
        if (!0x2::table::contains<0x2::object::ID, u64>(v0, arg1)) {
            0
        } else {
            *0x2::table::borrow<0x2::object::ID, u64>(v0, arg1)
        }
    }

    public fun harvest<T0>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: u64) : vector<u64> {
        assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        let v0 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::harvest_batch_cap(arg1);
        if (arg2 > v0) {
            arg2 = v0;
        };
        let v1 = lp_cash<T0>(arg0);
        let v2 = state_mut<T0>(arg0);
        let (v3, v4, v5, v6, v7, v8, v9, v10, v11) = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp::take_fitting_full(&mut v2.queue, v1, arg2);
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
            v22.total_owed = v22.total_owed - v11;
            v22.fee_lp = v22.fee_lp + v20;
        };
        let v23 = 0;
        while (v23 < 0x1::vector::length<u64>(&v18)) {
            let v24 = *0x1::vector::borrow<0x2::object::ID>(&v15, v23);
            let v25 = *0x1::vector::borrow<u64>(&v18, v23);
            let v26 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
            credit_account_free<T0>(&v26, arg0, v24, v25);
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_harvest_payout_event(*0x1::vector::borrow<u64>(&v19, v23), v24, v25);
            v23 = v23 + 1;
        };
        let v27 = 0;
        let v28 = 0;
        let v29 = 0;
        while (v29 < 0x1::vector::length<u64>(&v17)) {
            v28 = v28 + *0x1::vector::borrow<u64>(&v17, v29);
            let v30 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
            let v31 = carve_builder<T0>(&v30, arg0, *0x1::vector::borrow<u64>(&v17, v29), *0x1::vector::borrow<u64>(&v17, v29), *0x1::vector::borrow<address>(&v16, v29), *0x1::vector::borrow<0x2::object::ID>(&v15, v29), *0x1::vector::borrow<u64>(&v12, v29), *0x1::vector::borrow<0x1::option::Option<u32>>(&v14, v29), *0x1::vector::borrow<u16>(&v13, v29), 2);
            v27 = v27 + v31;
            v29 = v29 + 1;
        };
        let v32 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        route_retained<T0>(&v32, arg0, arg1, v28 - v27);
        assert_identity<T0>(arg0);
        v18
    }

    public fun has_reward_treasury<T0, T1>(arg0: &Exchange<T0>) : bool {
        let v0 = RewardTreasuryKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(&arg0.id, v0)
    }

    public fun in_oi_set<T0>(arg0: &Exchange<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&state<T0>(arg0).oi_set, arg1)
    }

    public fun install_reward_cap<T0, T1>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: 0x2::coin::TreasuryCap<T1>) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        let v0 = RewardTreasuryKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<RewardTreasuryKey>(&arg0.id, v0), 13836466654232051723);
        let v1 = 0x2::object::id<Exchange<T0>>(arg0);
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        let v3 = RewardTreasuryKey{dummy_field: false};
        0x2::dynamic_field::add<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(uid_mut<T0>(&v2, arg0), v3, arg3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_parchment_cap_installed_event(v1);
        let v4 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v4, v1, 44);
    }

    public fun last_surplus_ms<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).last_surplus_ms
    }

    public fun lock_open<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64, arg3: u64) {
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

    public fun lp_cash_of<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).lp_cash
    }

    public fun max_harvest_entries() : u64 {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp::max_entries()
    }

    public fun mint_reward<T0, T1>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = RewardTreasuryKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(&arg1.id, v0), 13836186265881935881);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        let v2 = RewardTreasuryKey{dummy_field: false};
        0x2::coin::mint<T1>(0x2::dynamic_field::borrow_mut<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(uid_mut<T0>(&v1, arg1), v2), arg2, arg3)
    }

    public fun note_checked(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut ReserveCheck, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(arg1.exchange_id == arg2, 13837594448219996179);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg1.seen, &arg3)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg1.seen, arg3);
        };
    }

    public fun oi_markets<T0>(arg0: &Exchange<T0>) : u64 {
        0x2::table::length<0x2::object::ID, bool>(&state<T0>(arg0).oi_set)
    }

    public fun open_account<T0>(arg0: &mut Exchange<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_usdc<T0>();
        let (v0, v1) = open_account_inner<T0>(arg0, arg1);
        0x2::transfer::public_share_object<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(v0);
        0x2::transfer::public_transfer<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::AccountCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun open_account_inner<T0>(arg0: &mut Exchange<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::AccountCap) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::object::id<Exchange<T0>>(arg0);
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        let v3 = uid_mut<T0>(&v2, arg0);
        let (v4, v5) = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::create<T0>(v3, v1, v0, arg1);
        let v6 = v4;
        let v7 = 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(&v6);
        ensure_free_row<T0>(arg0, v7);
        let v8 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        let v9 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        let v10 = uid_mut<T0>(&v9, arg0);
        let v11 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::referral_book::take_pending(&v8, v10, v0);
        if (v11 > 0) {
            let v12 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
            release_referral_owed<T0>(&v12, arg0, v11);
            let v13 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
            credit_account_free<T0>(&v13, arg0, v7, v11);
            let v14 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_referral_settled_event(&v14, v0, v7, v11);
        };
        let v15 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        let v16 = uid_mut<T0>(&v15, arg0);
        let v17 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::take_pending(v16, v0);
        if (v17 > 0) {
            release_builder_owed<T0>(arg0, v17);
            let v18 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
            credit_account_free<T0>(&v18, arg0, v7, v17);
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_builder_pending_settled_event(v0, v7, v17);
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
        0x2::linked_table::length<u64, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp::Claim>(&state<T0>(arg0).queue)
    }

    public fun queue_length<T0>(arg0: &Exchange<T0>) : u64 {
        queue_len<T0>(arg0)
    }

    public fun queue_nonempty<T0>(arg0: &Exchange<T0>) : bool {
        0x2::linked_table::length<u64, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp::Claim>(&state<T0>(arg0).queue) > 0
    }

    public fun realize_loss<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64, arg3: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        if (!queue_nonempty<T0>(arg1)) {
            let v0 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::bps_of(arg2, arg3);
            credit_lp<T0>(arg1, arg2 - v0, true);
            if (v0 > 0) {
                let v1 = state_mut<T0>(arg1);
                v1.fee_lp = v1.fee_lp + v0;
            };
            return v0
        };
        let v2 = state<T0>(arg1);
        let v3 = if (v2.lp_cash < v2.total_owed) {
            v2.total_owed - v2.lp_cash
        } else {
            0
        };
        let v4 = if (arg2 > v3) {
            arg2 - v3
        } else {
            0
        };
        if (v4 > 0) {
            credit_lp<T0>(arg1, v4, true);
        };
        if (arg2 > v4) {
            credit_lp<T0>(arg1, arg2 - v4, false);
        };
        0
    }

    public fun recommended_harvest_batch() : u64 {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp::recommended_batch()
    }

    public fun recover_dust<T0>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        let v0 = state_mut<T0>(arg0);
        let v1 = v0.fee_dev;
        assert!(v1 > 0, 13835903970566340615);
        v0.fee_dev = 0;
        let v2 = split_coin<T0>(arg0, v1, arg3);
        assert_identity<T0>(arg0);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v3, 0x2::object::id<Exchange<T0>>(arg0), 13);
        v2
    }

    public fun referral_owed<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).referral_owed
    }

    public fun register_extension<T0: drop, T1>(arg0: &mut Exchange<T1>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert_version<T1>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::register_uid<T0>(&mut arg0.id);
    }

    public(friend) fun release_builder_owed<T0>(arg0: &mut Exchange<T0>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg0);
        v0.builder_owed = v0.builder_owed - arg1;
    }

    public fun release_referral_owed<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = state_mut<T0>(arg1);
        v0.referral_owed = v0.referral_owed - arg2;
    }

    public fun reserve<T0>(arg0: &Exchange<T0>) : u128 {
        let v0 = state<T0>(arg0);
        (v0.total_owed as u128) + (v0.reserve_upnl as u128) + (v0.reserve_stress as u128)
    }

    public fun reserve_check_count(arg0: &ReserveCheck) : u64 {
        0x2::vec_set::length<0x2::object::ID>(&arg0.seen)
    }

    public fun reserve_check_epoch(arg0: &ReserveCheck) : u64 {
        arg0.epoch
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

    public fun reward_supply<T0, T1>(arg0: &Exchange<T0>) : u64 {
        assert!(has_reward_treasury<T0, T1>(arg0), 13836186214342328329);
        let v0 = RewardTreasuryKey{dummy_field: false};
        0x2::coin::total_supply<T1>(0x2::dynamic_field::borrow<RewardTreasuryKey, 0x2::coin::TreasuryCap<T1>>(&arg0.id, v0))
    }

    public fun route_retained<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: u64) {
        if (arg3 == 0) {
            return
        };
        update_dist<T0>(arg1, arg2);
        let (v0, v1, v2) = if (distributing<T0>(arg1)) {
            let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::bps_of(arg3, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::staker_fee_bps(arg2));
            (v3, arg3 - v3, 0)
        } else {
            (0, 0, arg3)
        };
        let v4 = state_mut<T0>(arg1);
        v4.fee_lp = v4.fee_lp - v0 - v2;
        v4.fee_staker = v4.fee_staker + v0;
        v4.lp_cash = v4.lp_cash + v2;
        v4.tracked_lp = v4.tracked_lp + v2;
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_fees_routed_event(0x2::object::id<Exchange<T0>>(arg1), arg3, v0, v1, v2);
    }

    public fun seed_lp<T0>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: 0x2::coin::Coin<T0>) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 13835903605494120455);
        join<T0>(arg0, 0x2::coin::into_balance<T0>(arg3));
        let v1 = state_mut<T0>(arg0);
        v1.lp_cash = v1.lp_cash + v0;
        v1.tracked_lp = v1.tracked_lp + v0;
        assert_identity<T0>(arg0);
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Exchange<T0>>(arg0), 20);
    }

    fun settle_builder_pending<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: 0x2::object::ID) {
        let v0 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        let v1 = uid_mut<T0>(&v0, arg0);
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::take_pending(v1, arg1);
        if (v2 == 0) {
            return
        };
        release_builder_owed<T0>(arg0, v2);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        credit_account_free<T0>(&v3, arg0, arg2, v2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_builder_pending_settled_event(arg1, arg2, v2);
    }

    fun share_created<T0>(arg0: Exchange<T0>) : 0x2::object::ID {
        0x2::transfer::share_object<Exchange<T0>>(arg0);
        0x2::object::id<Exchange<T0>>(&arg0)
    }

    fun split_coin<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut state_mut<T0>(arg0).vault, arg1), arg2)
    }

    public fun split_out<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        split_coin<T0>(arg1, arg2, arg3)
    }

    public fun staker_fees<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).fee_staker
    }

    fun state<T0>(arg0: &Exchange<T0>) : &ExchangeStateV1<T0> {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::extended_field::borrow<ExchangeStateV1<T0>>(&arg0.id, arg0.version)
    }

    fun state_mut<T0>(arg0: &mut Exchange<T0>) : &mut ExchangeStateV1<T0> {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::extended_field::borrow_mut<ExchangeStateV1<T0>>(&mut arg0.id, arg0.version)
    }

    public fun sub_open_exposure<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        let v0 = state_mut<T0>(arg1);
        v0.open_exposure = v0.open_exposure - arg2;
    }

    public fun sweep_surplus<T0>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: ReserveCheck, arg3: &0x2::clock::Clock) : u64 {
        assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        finish_check<T0>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = state<T0>(arg0).last_surplus_ms;
        assert!(v1 == 0 || v0 >= v1 + 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::surplus_interval_ms(arg1), 13836750646059728909);
        update_dist_with<T0>(arg0, arg1, true);
        assert!(distributing<T0>(arg0), 13837032129626505231);
        let v2 = reserve<T0>(arg0);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::surplus_take(state<T0>(arg0).lp_cash, v2, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::surplus_floor_bps(arg1), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::surplus_max_bps(arg1));
        assert!(v3 > 0, 13837032146806374415);
        let v4 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::bps_of(v3, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::surplus_staker_bps(arg1));
        let v5 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::bps_of(v3, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::surplus_treasury_bps(arg1));
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
        update_dist<T0>(arg0, arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_surplus_swept_event(0x2::object::id<Exchange<T0>>(arg0), v3, v4, v5, v6, v7.lp_cash, v2, v0);
        assert_identity<T0>(arg0);
        v3
    }

    public fun tail_progress<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).tail_progress
    }

    public fun take_pending_basis<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: 0x2::object::ID) : u64 {
        let v0 = &mut state_mut<T0>(arg1).pending_basis;
        if (0x2::table::contains<0x2::object::ID, u64>(v0, arg2)) {
            0x2::table::remove<0x2::object::ID, u64>(v0, arg2)
        } else {
            0
        }
    }

    public fun take_staker_rewards<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>) : 0x2::balance::Balance<T0> {
        assert_version<T0>(arg1);
        assert!(!state<T0>(arg1).dist_paused, 13837875678383702037);
        let v0 = reserve<T0>(arg1);
        let v1 = state_mut<T0>(arg1);
        let v2 = v1.fee_staker;
        assert!(v2 > 0, 13835905375020646407);
        v1.fee_staker = 0;
        let v3 = if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_staker_rewards_taken(0x2::object::id<Exchange<T0>>(arg1), v2, 0, v3, v1.lp_cash);
        let v4 = state_mut<T0>(arg1);
        assert_identity<T0>(arg1);
        0x2::balance::split<T0>(&mut v4.vault, v2)
    }

    public(friend) fun total_owed<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).total_owed
    }

    public fun total_owed_of<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).total_owed
    }

    public fun tracked_lp<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).tracked_lp
    }

    public fun uid_mut<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>) : &mut 0x2::object::UID {
        &mut arg1.id
    }

    public fun unlock_all<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut Exchange<T0>, arg2: u64) {
        let v0 = state_mut<T0>(arg1);
        v0.locked_margin = v0.locked_margin - arg2;
    }

    public fun unregister_extension<T0: drop, T1>(arg0: &mut Exchange<T1>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert_version<T1>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::unregister_uid<T0>(&mut arg0.id);
    }

    public(friend) fun update_dist<T0>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config) {
        let v0 = 0x2::table::length<0x2::object::ID, bool>(&state<T0>(arg0).oi_set) == 0;
        update_dist_with<T0>(arg0, arg1, v0);
    }

    fun update_dist_with<T0>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: bool) {
        let v0 = reserve<T0>(arg0);
        let v1 = state<T0>(arg0);
        let v2 = v1.dist_paused;
        let v3 = v1.lp_cash;
        let v4 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::next_dist_paused(v2, v3, v0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::pause_ratio_bps(arg1), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::resume_ratio_bps(arg1));
        if (v2 && !arg2) {
            v4 = true;
        };
        if (v4 != v2) {
            let v5 = state_mut<T0>(arg0);
            v5.dist_paused = v4;
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_distribution_state_event(0x2::object::id<Exchange<T0>>(arg0), v4, v3, v0);
        };
    }

    public(friend) fun user_free<T0>(arg0: &Exchange<T0>) : u64 {
        state<T0>(arg0).user_free
    }

    public fun withdraw<T0>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::AccountCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_exchange<T0>(arg1, 0x2::object::id<Exchange<T0>>(arg0));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_cap<T0>(arg1, arg2);
        let v0 = 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(arg1);
        assert!(arg3 > 0 && free_balance<T0>(arg0, v0) >= arg3, 13835903528184709127);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        debit_account_free<T0>(&v1, arg0, v0, arg3);
        let v2 = split_coin<T0>(arg0, arg3, arg4);
        assert_identity<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_withdraw_event(v0, arg3);
        v2
    }

    public fun withdraw_fees<T0>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::FEE_RECIPIENT>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_role<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::FEE_RECIPIENT>(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg1), 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        update_dist<T0>(arg0, arg1);
        assert!(!state<T0>(arg0).dist_paused, 13837874115015606293);
        let v0 = state_mut<T0>(arg0);
        let v1 = v0.fee_lp + v0.fee_dev;
        assert!(v1 > 0, 13835903807357583367);
        v0.fee_lp = 0;
        v0.fee_dev = 0;
        let v2 = split_coin<T0>(arg0, v1, arg3);
        assert_identity<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_claim_fees_event(v1);
        v2
    }

    public fun withdraw_growth<T0>(arg0: &mut Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::FEE_RECIPIENT>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_role<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::FEE_RECIPIENT>(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg1), 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        let v0 = state_mut<T0>(arg0);
        let v1 = v0.fee_growth;
        assert!(v1 > 0, 13835906392927895559);
        v0.fee_growth = 0;
        let v2 = split_coin<T0>(arg0, v1, arg3);
        assert_identity<T0>(arg0);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v3, 0x2::object::id<Exchange<T0>>(arg0), 74);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_growth_withdrawn_event(0x2::object::id<Exchange<T0>>(arg0), v1);
        v2
    }

    // decompiled from Move bytecode v7
}

