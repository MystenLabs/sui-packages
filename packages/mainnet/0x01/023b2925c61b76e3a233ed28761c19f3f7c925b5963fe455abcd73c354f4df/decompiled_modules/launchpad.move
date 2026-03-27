module 0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::launchpad {
    struct CreatorCap has key {
        id: 0x2::object::UID,
        raise_id: 0x2::object::ID,
    }

    struct DepositRaiseFunds<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    struct ContributorKey has copy, drop, store {
        contributor: address,
    }

    struct Contribution has copy, drop, store {
        amount: u64,
    }

    struct ReservationKey has copy, drop, store {
        wallet: address,
    }

    struct Reservation has copy, drop, store {
        amount: u64,
        accepted: bool,
    }

    struct Raise<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        creator: address,
        affiliate_id: 0x1::string::String,
        state: u8,
        min_raise_amount: u64,
        max_raise_amount: u64,
        start_time_ms: u64,
        deadline_ms: u64,
        duration_ms: u64,
        allow_early_completion: bool,
        raise_token_vault: 0x2::balance::Balance<T0>,
        tokens_for_sale_amount: u64,
        stable_coin_vault: 0x2::balance::Balance<T1>,
        description: 0x1::string::String,
        amm_percent_of_total_bps: u64,
        bid_wall_percent_of_excess_bps: u64,
        success_specs: vector<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>,
        failure_specs: vector<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>,
        settlement_done: bool,
        settled_at_ms: 0x1::option::Option<u64>,
        settled_raise_amount: u64,
        final_raise_amount: u64,
        completion_started_ms: 0x1::option::Option<u64>,
        intents_locked: bool,
        bid_fee: u64,
        total_pending_reserved: u64,
        total_reserved_at_creation: u64,
        reservation_count: u64,
    }

    struct FailedRaiseCleanup has copy, drop {
        raise_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct RaiseCreated has copy, drop {
        raise_id: 0x2::object::ID,
        creator: address,
        affiliate_id: 0x1::string::String,
        raise_token_type: 0x1::string::String,
        stable_coin_type: 0x1::string::String,
        raise_token_decimals: u8,
        stable_coin_decimals: u8,
        asset_currency_id: 0x2::object::ID,
        stable_currency_id: 0x2::object::ID,
        min_raise_amount: u64,
        max_raise_amount: u64,
        tokens_for_sale: u64,
        start_time_ms: u64,
        deadline_ms: u64,
        duration_ms: u64,
        description: 0x1::string::String,
        metadata_keys: vector<0x1::string::String>,
        metadata_values: vector<0x1::string::String>,
    }

    struct ContributionAdded has copy, drop {
        raise_id: 0x2::object::ID,
        contributor: address,
        amount: u64,
    }

    struct SettlementFinalized has copy, drop {
        raise_id: 0x2::object::ID,
        final_total: u64,
    }

    struct RaiseSuccessful has copy, drop {
        raise_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        total_raised: u64,
    }

    struct RaiseCompletionTimedOut has copy, drop {
        raise_id: 0x2::object::ID,
        completion_started_at: u64,
        timeout_at: u64,
        timestamp: u64,
    }

    struct RaiseFailed has copy, drop {
        raise_id: 0x2::object::ID,
        total_raised: u64,
        min_raise_amount: u64,
    }

    struct TokensClaimed has copy, drop {
        raise_id: 0x2::object::ID,
        contributor: address,
        contribution_amount: u64,
        tokens_claimed: u64,
    }

    struct RefundClaimed has copy, drop {
        raise_id: 0x2::object::ID,
        contributor: address,
        refund_amount: u64,
    }

    struct RaiseEndedEarly has copy, drop {
        raise_id: 0x2::object::ID,
        total_raised: u64,
        original_deadline: u64,
        ended_at: u64,
    }

    struct BatchClaimCompleted has copy, drop {
        raise_id: 0x2::object::ID,
        cranker: address,
        attempted: u64,
    }

    struct RaiseForceFailedByAdmin has copy, drop {
        raise_id: 0x2::object::ID,
        settled_raise_amount: u64,
        timestamp: u64,
    }

    struct ReservationAdded has copy, drop {
        raise_id: 0x2::object::ID,
        wallet: address,
        amount: u64,
    }

    struct ReservationAccepted has copy, drop {
        raise_id: 0x2::object::ID,
        wallet: address,
        amount: u64,
    }

    struct ReservationRevoked has copy, drop {
        raise_id: 0x2::object::ID,
        wallet: address,
        amount: u64,
    }

    struct UnsharedRaise<phantom T0, phantom T1> {
        raise: Raise<T0, T1>,
        creator_cap: CreatorCap,
    }

    public entry fun accept_reservation<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &mut 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::fee::FeeManager, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 1);
        assert!(arg0.intents_locked, 123);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.start_time_ms, 1);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.deadline_ms, 1);
        assert!(!arg0.settlement_done, 103);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = ReservationKey{wallet: v0};
        assert!(0x2::dynamic_field::exists_<ReservationKey>(&arg0.id, v1), 183);
        let v2 = 0x2::dynamic_field::borrow<ReservationKey, Reservation>(&arg0.id, v1);
        assert!(!v2.accepted, 184);
        let v3 = v2.amount;
        assert!(0x2::coin::value<T1>(&arg2) >= v3, 13);
        0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::fee::deposit_launchpad_bid_fee(arg1, arg3, arg0.bid_fee, arg4, arg5);
        0x2::dynamic_field::remove<ReservationKey, Reservation>(&mut arg0.id, v1);
        arg0.total_pending_reserved = arg0.total_pending_reserved - v3;
        arg0.reservation_count = arg0.reservation_count - 1;
        let v4 = ContributorKey{contributor: v0};
        if (0x2::dynamic_field::exists_<ContributorKey>(&arg0.id, v4)) {
            let v5 = 0x2::dynamic_field::borrow_mut<ContributorKey, Contribution>(&mut arg0.id, v4);
            v5.amount = v5.amount + v3;
        } else {
            let v6 = Contribution{amount: v3};
            0x2::dynamic_field::add<ContributorKey, Contribution>(&mut arg0.id, v4, v6);
        };
        let v7 = 0x2::coin::into_balance<T1>(arg2);
        0x2::balance::join<T1>(&mut arg0.stable_coin_vault, 0x2::balance::split<T1>(&mut v7, v3));
        if (0x2::balance::value<T1>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg5), v0);
        } else {
            0x2::balance::destroy_zero<T1>(v7);
        };
        if (0x2::balance::value<T1>(&arg0.stable_coin_vault) >= arg0.max_raise_amount && arg0.total_pending_reserved == 0) {
            arg0.deadline_ms = 0x2::clock::timestamp_ms(arg4);
        };
        let v8 = ReservationAccepted{
            raise_id : 0x2::object::id<Raise<T0, T1>>(arg0),
            wallet   : v0,
            amount   : v3,
        };
        0x2::event::emit<ReservationAccepted>(v8);
        let v9 = ContributionAdded{
            raise_id    : 0x2::object::id<Raise<T0, T1>>(arg0),
            contributor : v0,
            amount      : v3,
        };
        0x2::event::emit<ContributionAdded>(v9);
    }

    public fun account_id<T0, T1>(arg0: &Raise<T0, T1>) : 0x2::object::ID {
        arg0.account_id
    }

    public fun add_deposit_raise_funds_spec<T0, T1>(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: 0x2::object::ID) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<DepositRaiseFunds<T0, T1>>(), v0, 1));
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_id(&mut v1, b"raise_id", arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v1, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<DepositRaiseFunds<T0, T1>>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun add_reservation<T0, T1>(arg0: &mut UnsharedRaise<T0, T1>, arg1: address, arg2: u64) {
        let v0 = &mut arg0.raise;
        assert!(v0.state == 0, 155);
        assert!(!v0.intents_locked, 113);
        assert!(arg2 > 0, 188);
        let v1 = ReservationKey{wallet: arg1};
        assert!(!0x2::dynamic_field::exists_<ReservationKey>(&v0.id, v1), 187);
        assert!(v0.reservation_count < 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::launchpad_max_reservations(), 185);
        let v2 = v0.total_pending_reserved + arg2;
        assert!(v2 <= v0.max_raise_amount, 186);
        let v3 = Reservation{
            amount   : arg2,
            accepted : false,
        };
        0x2::dynamic_field::add<ReservationKey, Reservation>(&mut v0.id, v1, v3);
        v0.total_pending_reserved = v2;
        v0.total_reserved_at_creation = v0.total_reserved_at_creation + arg2;
        v0.reservation_count = v0.reservation_count + 1;
        let v4 = ReservationAdded{
            raise_id : 0x2::object::id<Raise<T0, T1>>(v0),
            wallet   : arg1,
            amount   : arg2,
        };
        0x2::event::emit<ReservationAdded>(v4);
    }

    fun assert_emergency_delay_reached<T0, T1>(arg0: &Raise<T0, T1>, arg1: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::emergency_cap::EmergencyCap, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.deadline_ms, 2);
        0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::emergency_cap::assert_ready(arg1, arg2);
    }

    public entry fun batch_claim_refund_for<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.deadline_ms, 2);
        if (arg0.state != 2) {
            let v0 = if (arg0.settlement_done) {
                arg0.final_raise_amount
            } else {
                0x2::balance::value<T1>(&arg0.stable_coin_vault)
            };
            assert!(v0 < arg0.min_raise_amount, 4);
            if (arg0.state == 0) {
                arg0.state = 2;
                arg0.settled_raise_amount = v0;
                let v1 = RaiseFailed{
                    raise_id         : 0x2::object::id<Raise<T0, T1>>(arg0),
                    total_raised     : v0,
                    min_raise_amount : arg0.min_raise_amount,
                };
                0x2::event::emit<RaiseFailed>(v1);
            };
        };
        assert!(arg0.state == 2, 157);
        let v2 = 0x1::vector::length<address>(&arg1);
        assert!(v2 > 0, 136);
        assert!(v2 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::launchpad_max_batch_size(), 135);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<address>(&arg1, v3);
            let v5 = ContributorKey{contributor: v4};
            if (!0x2::dynamic_field::exists_<ContributorKey>(&arg0.id, v5)) {
                v3 = v3 + 1;
                continue
            };
            let v6 = 0x2::dynamic_field::remove<ContributorKey, Contribution>(&mut arg0.id, v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.stable_coin_vault, v6.amount), arg3), v4);
            let v7 = RefundClaimed{
                raise_id      : 0x2::object::id<Raise<T0, T1>>(arg0),
                contributor   : v4,
                refund_amount : v6.amount,
            };
            0x2::event::emit<RefundClaimed>(v7);
            v3 = v3 + 1;
        };
        let v8 = BatchClaimCompleted{
            raise_id  : 0x2::object::id<Raise<T0, T1>>(arg0),
            cranker   : 0x2::tx_context::sender(arg3),
            attempted : v2,
        };
        0x2::event::emit<BatchClaimCompleted>(v8);
    }

    public entry fun batch_claim_tokens_for<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 156);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 136);
        assert!(v0 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::launchpad_max_batch_size(), 135);
        let v1 = arg0.final_raise_amount;
        assert!(v1 > 0, 161);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            let v4 = ContributorKey{contributor: v3};
            if (!0x2::dynamic_field::exists_<ContributorKey>(&arg0.id, v4)) {
                v2 = v2 + 1;
                continue
            };
            let v5 = 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::math::mul_div_to_64(0x2::dynamic_field::borrow<ContributorKey, Contribution>(&arg0.id, v4).amount, arg0.tokens_for_sale_amount, v1);
            let v6 = 0x2::dynamic_field::remove<ContributorKey, Contribution>(&mut arg0.id, v4);
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.raise_token_vault, v5), arg3), v3);
            };
            let v7 = TokensClaimed{
                raise_id            : 0x2::object::id<Raise<T0, T1>>(arg0),
                contributor         : v3,
                contribution_amount : v6.amount,
                tokens_claimed      : v5,
            };
            0x2::event::emit<TokensClaimed>(v7);
            v2 = v2 + 1;
        };
        let v8 = BatchClaimCompleted{
            raise_id  : 0x2::object::id<Raise<T0, T1>>(arg0),
            cranker   : 0x2::tx_context::sender(arg3),
            attempted : v0,
        };
        0x2::event::emit<BatchClaimCompleted>(v8);
    }

    public fun bid_fee<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        arg0.bid_fee
    }

    public entry fun burn_unsold_tokens<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 2, 157);
        let v0 = 0x2::balance::value<T0>(&arg0.raise_token_vault);
        if (v0 > 0) {
            0x2::coin::burn<T0>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.raise_token_vault, v0), arg2));
        };
    }

    public entry fun claim_refund<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline_ms, 2);
        if (arg0.state != 2) {
            let v0 = if (arg0.settlement_done) {
                arg0.final_raise_amount
            } else {
                0x2::balance::value<T1>(&arg0.stable_coin_vault)
            };
            assert!(v0 < arg0.min_raise_amount, 4);
            if (arg0.state == 0) {
                arg0.state = 2;
                arg0.settled_raise_amount = v0;
                let v1 = RaiseFailed{
                    raise_id         : 0x2::object::id<Raise<T0, T1>>(arg0),
                    total_raised     : v0,
                    min_raise_amount : arg0.min_raise_amount,
                };
                0x2::event::emit<RaiseFailed>(v1);
            };
        };
        assert!(arg0.state == 2, 157);
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = ContributorKey{contributor: v2};
        assert!(0x2::dynamic_field::exists_<ContributorKey>(&arg0.id, v3), 6);
        let v4 = 0x2::dynamic_field::remove<ContributorKey, Contribution>(&mut arg0.id, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.stable_coin_vault, v4.amount), arg2), v2);
        let v5 = RefundClaimed{
            raise_id      : 0x2::object::id<Raise<T0, T1>>(arg0),
            contributor   : v2,
            refund_amount : v4.amount,
        };
        0x2::event::emit<RefundClaimed>(v5);
    }

    public entry fun claim_tokens<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 156);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = ContributorKey{contributor: v0};
        assert!(0x2::dynamic_field::exists_<ContributorKey>(&arg0.id, v1), 6);
        let v2 = 0x2::dynamic_field::remove<ContributorKey, Contribution>(&mut arg0.id, v1);
        let v3 = arg0.final_raise_amount;
        assert!(v3 > 0, 161);
        let v4 = 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::math::mul_div_to_64(v2.amount, arg0.tokens_for_sale_amount, v3);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.raise_token_vault, v4), arg2), v0);
        };
        let v5 = TokensClaimed{
            raise_id            : 0x2::object::id<Raise<T0, T1>>(arg0),
            contributor         : v0,
            contribution_amount : v2.amount,
            tokens_claimed      : v4,
        };
        0x2::event::emit<TokensClaimed>(v5);
    }

    public entry fun cleanup_failed_raise<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &CreatorCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.raise_id == 0x2::object::id<Raise<T0, T1>>(arg0), 132);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.deadline_ms, 2);
        if (arg0.state != 2) {
            let v0 = if (arg0.settlement_done) {
                arg0.final_raise_amount
            } else {
                0x2::balance::value<T1>(&arg0.stable_coin_vault)
            };
            assert!(v0 < arg0.min_raise_amount, 4);
            arg0.state = 2;
            arg0.settled_raise_amount = v0;
            let v1 = RaiseFailed{
                raise_id         : 0x2::object::id<Raise<T0, T1>>(arg0),
                total_raised     : v0,
                min_raise_amount : arg0.min_raise_amount,
            };
            0x2::event::emit<RaiseFailed>(v1);
        };
        arg0.success_specs = 0x1::vector::empty<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>();
        let v2 = FailedRaiseCleanup{
            raise_id   : 0x2::object::id<Raise<T0, T1>>(arg0),
            account_id : arg0.account_id,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FailedRaiseCleanup>(v2);
    }

    fun completion_intent_already_executed(arg0: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account) : bool {
        let v0 = 0x1::string::utf8(0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_executor::dao_init_intent_key());
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::intents(arg0);
        if (!0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::contains(v1, v0)) {
            return false
        };
        let v2 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::execution_times<0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_outcome::DaoInitOutcome>(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::get<0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_outcome::DaoInitOutcome>(v1, v0));
        0x1::vector::is_empty<u64>(&v2)
    }

    fun completion_timeout_at(arg0: u64) : u64 {
        if (arg0 > 18446744073709551615 - 86400000) {
            18446744073709551615
        } else {
            arg0 + 86400000
        }
    }

    public entry fun contribute<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &mut 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::fee::FeeManager, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 1);
        assert!(arg0.intents_locked, 123);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.start_time_ms, 1);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.deadline_ms, 1);
        assert!(!arg0.settlement_done, 103);
        let v0 = 0x2::balance::value<T1>(&arg0.stable_coin_vault);
        let v1 = arg0.max_raise_amount - arg0.total_pending_reserved;
        assert!(v0 < v1, 164);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v2 > 0, 13);
        let v3 = 0x1::u64::min(v2, v1 - v0);
        0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::fee::deposit_launchpad_bid_fee(arg1, arg3, arg0.bid_fee, arg4, arg5);
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = ContributorKey{contributor: v4};
        if (0x2::dynamic_field::exists_<ContributorKey>(&arg0.id, v5)) {
            let v6 = 0x2::dynamic_field::borrow_mut<ContributorKey, Contribution>(&mut arg0.id, v5);
            v6.amount = v6.amount + v3;
        } else {
            let v7 = Contribution{amount: v3};
            0x2::dynamic_field::add<ContributorKey, Contribution>(&mut arg0.id, v5, v7);
        };
        let v8 = 0x2::coin::into_balance<T1>(arg2);
        0x2::balance::join<T1>(&mut arg0.stable_coin_vault, 0x2::balance::split<T1>(&mut v8, v3));
        if (0x2::balance::value<T1>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg5), v4);
        } else {
            0x2::balance::destroy_zero<T1>(v8);
        };
        if (0x2::balance::value<T1>(&arg0.stable_coin_vault) >= arg0.max_raise_amount && arg0.total_pending_reserved == 0) {
            arg0.deadline_ms = 0x2::clock::timestamp_ms(arg4);
        };
        let v9 = ContributionAdded{
            raise_id    : 0x2::object::id<Raise<T0, T1>>(arg0),
            contributor : v4,
            amount      : v3,
        };
        0x2::event::emit<ContributionAdded>(v9);
    }

    public fun contribution_of<T0, T1>(arg0: &Raise<T0, T1>, arg1: address) : u64 {
        let v0 = ContributorKey{contributor: arg1};
        if (0x2::dynamic_field::exists_<ContributorKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<ContributorKey, Contribution>(&arg0.id, v0).amount
        } else {
            0
        }
    }

    public fun create_completion_intents<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg2: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0 || arg0.state == 2, 158);
        assert!(arg0.intents_locked, 123);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.deadline_ms, 2);
        assert!(arg0.settlement_done || arg0.state == 2, 159);
        assert!(0x2::object::id<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account>(arg1) == arg0.account_id, 141);
        if (arg0.state != 2 && arg0.final_raise_amount >= arg0.min_raise_amount) {
            assert!(0x1::vector::length<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&arg0.success_specs) > 0, 179);
            arg0.state = 3;
            arg0.completion_started_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg3));
            0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_executor::create_intents_from_specs_for_launchpad(arg1, arg2, &arg0.success_specs, 0x2::object::id<Raise<T0, T1>>(arg0), arg3, arg4);
        } else {
            arg0.state = 2;
            arg0.completion_started_ms = 0x1::option::none<u64>();
            if (arg0.state == 0) {
                let v0 = RaiseFailed{
                    raise_id         : 0x2::object::id<Raise<T0, T1>>(arg0),
                    total_raised     : arg0.final_raise_amount,
                    min_raise_amount : arg0.min_raise_amount,
                };
                0x2::event::emit<RaiseFailed>(v0);
            };
            if (!0x1::vector::is_empty<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&arg0.failure_specs)) {
                let v1 = 0x2::object::id<Raise<T0, T1>>(arg0);
                if (!failure_intent_active(v1, arg1, arg3)) {
                    0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_executor::cancel_launchpad_intent_if_present(arg1, arg2, v1, arg4);
                    0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_executor::create_intents_from_specs_for_launchpad(arg1, arg2, &arg0.failure_specs, v1, arg3, arg4);
                };
            };
        };
    }

    public fun create_raise<T0, T1>(arg0: &0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::factory::Factory, arg1: &mut 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::fee::FeeManager, arg2: 0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::factory::LaunchpadAccountReceipt<T0>, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::coin_registry::Currency<T1>, arg5: address, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: u64, arg11: bool, arg12: 0x1::string::String, arg13: vector<0x1::string::String>, arg14: vector<0x1::string::String>, arg15: u64, arg16: u64, arg17: 0x2::coin::Coin<0x2::sui::SUI>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : UnsharedRaise<T0, T1> {
        assert!(!0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::factory::is_paused(arg0), 15);
        0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::fee::deposit_launchpad_creation_payment(arg1, arg17, arg18, arg19);
        let (v0, v1) = 0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::factory::consume_launchpad_receipt<T0>(arg2);
        let v2 = v1;
        assert!(arg7 > 0, 150);
        assert!(arg8 >= arg7, 163);
        assert!(0x2::coin::value<T0>(&v2) > 0, 150);
        assert!(arg10 >= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::launchpad_min_duration_ms(), 151);
        assert!(arg10 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::launchpad_max_duration_ms(), 151);
        if (0x1::option::is_some<u64>(&arg9)) {
            assert!(*0x1::option::borrow<u64>(&arg9) <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::launchpad_max_start_delay_ms(), 151);
        };
        assert!(0x1::string::length(&arg6) <= 64, 152);
        assert!(0x1::string::length(&arg12) <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::launchpad_max_description_length(), 152);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg3), 168);
        assert!(0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::factory::is_stable_type_allowed<T1>(arg0), 14);
        assert!(0x1::type_name::with_original_ids<T0>() != 0x1::type_name::with_original_ids<T1>(), 167);
        assert!(arg15 + arg16 <= 10000, 153);
        assert!(0x1::vector::length<0x1::string::String>(&arg13) == 0x1::vector::length<0x1::string::String>(&arg14), 154);
        assert!(0x1::vector::length<0x1::string::String>(&arg13) <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::launchpad_max_metadata_pairs(), 154);
        init_raise<T0, T1>(v0, v2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, 0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::factory::launchpad_bid_fee(arg0), arg18, arg19)
    }

    public fun create_raise_with_account_setup<T0, T1>(arg0: &mut 0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::factory::Factory, arg1: &mut 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::fee::FeeManager, arg2: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>, arg5: &0x2::coin_registry::Currency<T0>, arg6: &0x2::coin_registry::Currency<T1>, arg7: u64, arg8: 0x1::ascii::String, arg9: address, arg10: 0x1::string::String, arg11: u64, arg12: u64, arg13: 0x1::option::Option<u64>, arg14: u64, arg15: bool, arg16: 0x1::string::String, arg17: vector<0x1::string::String>, arg18: vector<0x1::string::String>, arg19: u64, arg20: u64, arg21: 0x2::coin::Coin<0x2::sui::SUI>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : UnsharedRaise<T0, T1> {
        let v0 = 0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::factory::setup_dao_account_for_launchpad<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg22, arg23);
        create_raise<T0, T1>(arg0, arg1, v0, arg5, arg6, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23)
    }

    public fun deadline<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        arg0.deadline_ms
    }

    public fun description<T0, T1>(arg0: &Raise<T0, T1>) : &0x1::string::String {
        &arg0.description
    }

    public fun do_init_deposit_raise_funds<T0: store, T1, T2, T3: copy + drop>(arg0: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::executable::Executable<T0>, arg1: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg2: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg3: &mut Raise<T1, T2>, arg4: T3, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::assert_execution_authorized<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_specs<T0>(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::executable::intent<T0>(arg0)), 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::executable::action_idx<T0>(arg0));
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_validation::assert_action_type<DepositRaiseFunds<T1, T2>>(v1);
        assert!(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_spec_version(v1) == 1, 171);
        let v2 = 0x2::bcs::new(*0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_spec_data(v1));
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x2::object::id<Raise<T1, T2>>(arg3) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2)), 170);
        assert!(arg3.account_id == 0x2::object::id<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account>(arg1), 141);
        assert!(arg3.settlement_done, 172);
        assert!(arg3.state == 3, 174);
        let v3 = arg3.final_raise_amount;
        assert!(v3 >= arg3.min_raise_amount, 3);
        assert!(arg3.tokens_for_sale_amount > 0, 161);
        assert!(v3 > 0, 161);
        let v4 = 0x2::balance::value<T2>(&arg3.stable_coin_vault);
        assert!(v4 >= v3, 150);
        let v5 = 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::math::mul_div_mixed((v3 as u128), 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::price_precision_scale(), (arg3.tokens_for_sale_amount as u128));
        assert!(v5 > 0, 169);
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::futarchy_config::set_launchpad_initial_price_from_execution<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v6, v5);
        let v7 = arg3.min_raise_amount;
        let v8 = if (v3 > v7) {
            v3 - v7
        } else {
            0
        };
        let v9 = (((v3 as u128) * (arg3.amm_percent_of_total_bps as u128) / 10000) as u64);
        let v10 = (((v8 as u128) * (arg3.bid_wall_percent_of_excess_bps as u128) / 10000) as u64);
        let v11 = v3 - v9 - v10;
        if (v11 > 0) {
            0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::vault::deposit_approved<0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::futarchy_config::FutarchyConfig, T2>(arg1, arg2, 0x1::string::utf8(b"treasury"), 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg3.stable_coin_vault, v11), arg5));
        };
        if (v9 > 0) {
            0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::vault::deposit_approved<0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::futarchy_config::FutarchyConfig, T2>(arg1, arg2, 0x1::string::utf8(b"amm_liquidity"), 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg3.stable_coin_vault, v9), arg5));
        };
        if (v10 > 0) {
            0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::vault::deposit_approved<0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::futarchy_config::FutarchyConfig, T2>(arg1, arg2, 0x1::string::utf8(b"bid_wall_funds"), 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg3.stable_coin_vault, v10), arg5));
        };
        assert!(0x2::balance::value<T2>(&arg3.stable_coin_vault) == v4 - v3, 173);
        let v12 = ExecutionProgressWitness{dummy_field: false};
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::executable::increment_action_idx<T0, DepositRaiseFunds<T1, T2>, ExecutionProgressWitness>(arg0, arg2, v12);
    }

    public entry fun emergency_sweep_raise_token_vault_to_sender<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::emergency_cap::EmergencyCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_emergency_delay_reached<T0, T1>(arg0, arg1, arg3);
        let v0 = 0x2::balance::value<T0>(&arg0.raise_token_vault);
        let v1 = if (arg2 == 0 || arg2 > v0) {
            v0
        } else {
            arg2
        };
        if (v1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.raise_token_vault, v1), arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun emergency_sweep_stable_coin_vault_to_sender<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::emergency_cap::EmergencyCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_emergency_delay_reached<T0, T1>(arg0, arg1, arg3);
        let v0 = 0x2::balance::value<T1>(&arg0.stable_coin_vault);
        let v1 = if (arg2 == 0 || arg2 > v0) {
            v0
        } else {
            arg2
        };
        if (v1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.stable_coin_vault, v1), arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun end_raise_early<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &CreatorCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.raise_id == 0x2::object::id<Raise<T0, T1>>(arg0), 132);
        assert!(arg0.state == 0, 155);
        assert!(!arg0.settlement_done, 103);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.deadline_ms, 145);
        assert!(arg0.allow_early_completion, 133);
        assert!(arg0.total_pending_reserved == 0, 191);
        let v0 = 0x2::balance::value<T1>(&arg0.stable_coin_vault);
        assert!(v0 >= arg0.min_raise_amount, 3);
        arg0.deadline_ms = 0x2::clock::timestamp_ms(arg2);
        let v1 = RaiseEndedEarly{
            raise_id          : 0x2::object::id<Raise<T0, T1>>(arg0),
            total_raised      : v0,
            original_deadline : arg0.deadline_ms,
            ended_at          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RaiseEndedEarly>(v1);
    }

    fun failure_intent_active(arg0: 0x2::object::ID, arg1: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x1::string::utf8(0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_executor::dao_init_intent_key());
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::intents(arg1);
        if (!0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::contains(v1, v0)) {
            return false
        };
        let v2 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::get<0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_outcome::DaoInitOutcome>(v1, v0);
        if (!0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_outcome::is_for_raise(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::outcome<0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_outcome::DaoInitOutcome>(v2), arg0)) {
            return false
        };
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::expiration_time<0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_outcome::DaoInitOutcome>(v2) > 0x2::clock::timestamp_ms(arg2)
    }

    public fun final_raise_amount<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        arg0.final_raise_amount
    }

    public fun finalize_completion_execution<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg2: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg3: 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::executable::Executable<0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_outcome::DaoInitOutcome>, arg4: 0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_executor::DaoInitExecutionTicket, arg5: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account>(arg1) == arg0.account_id, 141);
        0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_executor::finalize_execution(arg1, arg2, arg3, arg4, arg5);
        if (arg0.state == 3) {
            mark_completion_success<T0, T1>(arg0, arg1);
        };
    }

    public entry fun force_fail_raise<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::factory::Factory, arg2: &0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::factory::FactoryOwnerCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::factory::assert_valid_owner_cap(arg1, arg2);
        assert!(arg0.state == 0, 155);
        assert!(arg0.settlement_done, 159);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.deadline_ms, 2);
        arg0.state = 2;
        let v0 = RaiseForceFailedByAdmin{
            raise_id             : 0x2::object::id<Raise<T0, T1>>(arg0),
            settled_raise_amount : arg0.settled_raise_amount,
            timestamp            : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RaiseForceFailedByAdmin>(v0);
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LAUNCHPAD>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init_raise<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: &0x2::coin_registry::Currency<T1>, arg4: address, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: u64, arg10: bool, arg11: 0x1::string::String, arg12: vector<0x1::string::String>, arg13: vector<0x1::string::String>, arg14: u64, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : UnsharedRaise<T0, T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::math::mul_div_mixed((arg6 as u128), 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::price_precision_scale(), (v0 as u128)) > 0, 169);
        let v1 = 0x2::clock::timestamp_ms(arg17);
        let v2 = if (0x1::option::is_some<u64>(&arg8)) {
            let v3 = *0x1::option::borrow<u64>(&arg8);
            assert!(v1 <= 18446744073709551615 - v3, 162);
            v1 + v3
        } else {
            v1
        };
        assert!(v2 <= 18446744073709551615 - arg9, 162);
        let v4 = Raise<T0, T1>{
            id                             : 0x2::object::new(arg18),
            account_id                     : arg0,
            creator                        : arg4,
            affiliate_id                   : arg5,
            state                          : 0,
            min_raise_amount               : arg6,
            max_raise_amount               : arg7,
            start_time_ms                  : v2,
            deadline_ms                    : v2 + arg9,
            duration_ms                    : arg9,
            allow_early_completion         : arg10,
            raise_token_vault              : 0x2::coin::into_balance<T0>(arg1),
            tokens_for_sale_amount         : v0,
            stable_coin_vault              : 0x2::balance::zero<T1>(),
            description                    : arg11,
            amm_percent_of_total_bps       : arg14,
            bid_wall_percent_of_excess_bps : arg15,
            success_specs                  : 0x1::vector::empty<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(),
            failure_specs                  : 0x1::vector::empty<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(),
            settlement_done                : false,
            settled_at_ms                  : 0x1::option::none<u64>(),
            settled_raise_amount           : 0,
            final_raise_amount             : 0,
            completion_started_ms          : 0x1::option::none<u64>(),
            intents_locked                 : false,
            bid_fee                        : arg16,
            total_pending_reserved         : 0,
            total_reserved_at_creation     : 0,
            reservation_count              : 0,
        };
        let v5 = 0x2::object::id<Raise<T0, T1>>(&v4);
        let v6 = RaiseCreated{
            raise_id             : v5,
            creator              : v4.creator,
            affiliate_id         : v4.affiliate_id,
            raise_token_type     : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())),
            stable_coin_type     : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>())),
            raise_token_decimals : 0x2::coin_registry::decimals<T0>(arg2),
            stable_coin_decimals : 0x2::coin_registry::decimals<T1>(arg3),
            asset_currency_id    : 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg2),
            stable_currency_id   : 0x2::object::id<0x2::coin_registry::Currency<T1>>(arg3),
            min_raise_amount     : arg6,
            max_raise_amount     : arg7,
            tokens_for_sale      : v0,
            start_time_ms        : v4.start_time_ms,
            deadline_ms          : v4.deadline_ms,
            duration_ms          : v4.duration_ms,
            description          : v4.description,
            metadata_keys        : arg12,
            metadata_values      : arg13,
        };
        0x2::event::emit<RaiseCreated>(v6);
        let v7 = CreatorCap{
            id       : 0x2::object::new(arg18),
            raise_id : v5,
        };
        UnsharedRaise<T0, T1>{
            raise       : v4,
            creator_cap : v7,
        }
    }

    public fun lock_and_share_raise<T0, T1>(arg0: UnsharedRaise<T0, T1>) {
        let UnsharedRaise {
            raise       : v0,
            creator_cap : v1,
        } = arg0;
        let v2 = v0;
        let v3 = &v2.success_specs;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(v3)) {
            let v6 = 0x1::vector::borrow<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(v3, v5);
            if (0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_spec_type(v6) == 0x1::type_name::with_original_ids<DepositRaiseFunds<T0, T1>>()) {
                v4 = v4 + 1;
                let v7 = 0x2::bcs::new(*0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_spec_data(v6));
                0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::bcs_validation::validate_all_bytes_consumed(v7);
                assert!(0x2::object::id_from_address(0x2::bcs::peel_address(&mut v7)) == 0x2::object::id<Raise<T0, T1>>(&v2), 192);
            };
            v5 = v5 + 1;
        };
        assert!(v4 >= 1, 181);
        assert!(v4 == 1, 182);
        assert!(0x1::vector::length<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&v2.failure_specs) > 0, 190);
        v2.intents_locked = true;
        0x2::transfer::transfer<CreatorCap>(v1, v2.creator);
        0x2::transfer::public_share_object<Raise<T0, T1>>(v2);
    }

    fun mark_completion_success<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account) {
        assert!(0x2::object::id<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account>(arg1) == arg0.account_id, 141);
        assert!(0x1::option::is_some<u64>(&arg0.completion_started_ms), 175);
        arg0.state = 1;
        arg0.completion_started_ms = 0x1::option::none<u64>();
        let v0 = RaiseSuccessful{
            raise_id     : 0x2::object::id<Raise<T0, T1>>(arg0),
            account_id   : 0x2::object::id<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account>(arg1),
            pool_id      : 0x1::option::none<0x2::object::ID>(),
            total_raised : arg0.final_raise_amount,
        };
        0x2::event::emit<RaiseSuccessful>(v0);
    }

    public fun max_raise_amount<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        arg0.max_raise_amount
    }

    public fun new_failure_builder<T0, T1>(arg0: &UnsharedRaise<T0, T1>) : 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder {
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::new(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::source_launchpad_failure(), 0x2::object::id<Raise<T0, T1>>(&arg0.raise), 1)
    }

    public fun new_success_builder<T0, T1>(arg0: &UnsharedRaise<T0, T1>) : 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder {
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::new(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::source_launchpad_success(), 0x2::object::id<Raise<T0, T1>>(&arg0.raise), 0)
    }

    public fun public_cap<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        arg0.max_raise_amount - arg0.total_pending_reserved
    }

    public fun raise_ref<T0, T1>(arg0: &UnsharedRaise<T0, T1>) : &Raise<T0, T1> {
        &arg0.raise
    }

    public entry fun reconcile_completion_state<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 3, 174);
        assert!(0x2::object::id<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account>(arg1) == arg0.account_id, 141);
        assert!(completion_intent_already_executed(arg1), 177);
        mark_completion_success<T0, T1>(arg0, arg1);
    }

    public fun reservation_accepted<T0, T1>(arg0: &Raise<T0, T1>, arg1: address) : bool {
        let v0 = ReservationKey{wallet: arg1};
        0x2::dynamic_field::exists_<ReservationKey>(&arg0.id, v0) && 0x2::dynamic_field::borrow<ReservationKey, Reservation>(&arg0.id, v0).accepted
    }

    public fun reservation_count<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        arg0.reservation_count
    }

    public fun reservation_of<T0, T1>(arg0: &Raise<T0, T1>, arg1: address) : u64 {
        let v0 = ReservationKey{wallet: arg1};
        if (0x2::dynamic_field::exists_<ReservationKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<ReservationKey, Reservation>(&arg0.id, v0).amount
        } else {
            0
        }
    }

    public entry fun revoke_reservation<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &CreatorCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.raise_id == 0x2::object::id<Raise<T0, T1>>(arg0), 132);
        assert!(arg0.state == 0, 155);
        let v0 = ReservationKey{wallet: arg2};
        assert!(0x2::dynamic_field::exists_<ReservationKey>(&arg0.id, v0), 183);
        let v1 = 0x2::dynamic_field::borrow<ReservationKey, Reservation>(&arg0.id, v0);
        assert!(!v1.accepted, 193);
        let v2 = v1.amount;
        0x2::dynamic_field::remove<ReservationKey, Reservation>(&mut arg0.id, v0);
        arg0.total_pending_reserved = arg0.total_pending_reserved - v2;
        arg0.reservation_count = arg0.reservation_count - 1;
        let v3 = ReservationRevoked{
            raise_id : 0x2::object::id<Raise<T0, T1>>(arg0),
            wallet   : arg2,
            amount   : v2,
        };
        0x2::event::emit<ReservationRevoked>(v3);
    }

    public entry fun rollback_completion_after_timeout<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg2: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 3, 174);
        assert!(0x2::object::id<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account>(arg1) == arg0.account_id, 141);
        assert!(!completion_intent_already_executed(arg1), 178);
        assert!(0x2::balance::value<T1>(&arg0.stable_coin_vault) >= arg0.settled_raise_amount, 178);
        assert!(0x1::option::is_some<u64>(&arg0.completion_started_ms), 175);
        let v0 = *0x1::option::borrow<u64>(&arg0.completion_started_ms);
        let v1 = completion_timeout_at(v0);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1, 176);
        0x1023b2925c61b76e3a233ed28761c19f3f7c925b5963fe455abcd73c354f4df::dao_init_executor::cancel_launchpad_intent_if_present(arg1, arg2, 0x2::object::id<Raise<T0, T1>>(arg0), arg4);
        arg0.state = 2;
        arg0.completion_started_ms = 0x1::option::none<u64>();
        let v2 = RaiseCompletionTimedOut{
            raise_id              : 0x2::object::id<Raise<T0, T1>>(arg0),
            completion_started_at : v0,
            timeout_at            : v1,
            timestamp             : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RaiseCompletionTimedOut>(v2);
    }

    public entry fun settle_raise<T0, T1>(arg0: &mut Raise<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 155);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline_ms, 2);
        assert!(!arg0.settlement_done, 103);
        assert!(arg0.intents_locked, 123);
        let v0 = 0x2::balance::value<T1>(&arg0.stable_coin_vault);
        arg0.settled_raise_amount = v0;
        arg0.final_raise_amount = v0;
        arg0.settlement_done = true;
        arg0.settled_at_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1));
        let v1 = SettlementFinalized{
            raise_id    : 0x2::object::id<Raise<T0, T1>>(arg0),
            final_total : v0,
        };
        0x2::event::emit<SettlementFinalized>(v1);
    }

    public fun settled_raise_amount<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        arg0.settled_raise_amount
    }

    public fun settlement_done<T0, T1>(arg0: &Raise<T0, T1>) : bool {
        arg0.settlement_done
    }

    public fun stage_failure_intent<T0, T1>(arg0: &mut UnsharedRaise<T0, T1>, arg1: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg2: 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.raise;
        assert!(v0.state == 0, 155);
        assert!(!v0.intents_locked, 113);
        let v1 = 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::into_vector(arg2);
        let v2 = 0x1::vector::length<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&v1);
        assert!(v2 > 0, 16);
        assert!(0x1::vector::length<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&v0.failure_specs) + v2 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::launchpad_max_init_actions(), 110);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&v1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::from_ascii(0x1::type_name::into_string(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_spec_type(0x1::vector::borrow<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&v1, v4)))));
            v4 = v4 + 1;
        };
        0x1::vector::append<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&mut v0.failure_specs, v1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_intent_actions(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::source_launchpad_failure(), 0x2::object::id<Raise<T0, T1>>(v0), 1, v3);
    }

    public fun stage_success_intent<T0, T1>(arg0: &mut UnsharedRaise<T0, T1>, arg1: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg2: 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.raise;
        assert!(v0.state == 0, 155);
        assert!(!v0.intents_locked, 113);
        let v1 = 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::into_vector(arg2);
        let v2 = 0x1::vector::length<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&v1);
        assert!(v2 > 0, 16);
        assert!(0x1::vector::length<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&v0.success_specs) + v2 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::launchpad_max_init_actions(), 110);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&v1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::from_ascii(0x1::type_name::into_string(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_spec_type(0x1::vector::borrow<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&v1, v4)))));
            v4 = v4 + 1;
        };
        0x1::vector::append<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&mut v0.success_specs, v1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_intent_actions(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::source_launchpad_success(), 0x2::object::id<Raise<T0, T1>>(v0), 0, v3);
    }

    public fun start_time<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        arg0.start_time_ms
    }

    public fun state<T0, T1>(arg0: &Raise<T0, T1>) : u8 {
        arg0.state
    }

    public fun total_pending_reserved<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        arg0.total_pending_reserved
    }

    public fun total_raised<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        if (arg0.settlement_done || arg0.state == 2) {
            arg0.settled_raise_amount
        } else {
            0x2::balance::value<T1>(&arg0.stable_coin_vault)
        }
    }

    public fun total_reserved_at_creation<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        arg0.total_reserved_at_creation
    }

    public fun unlimited_cap() : u64 {
        18446744073709551615
    }

    public fun vault_balance<T0, T1>(arg0: &Raise<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.stable_coin_vault)
    }

    // decompiled from Move bytecode v6
}

