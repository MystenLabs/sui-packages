module 0x836ff117478bb4ade0f12307ebcae85c1ca318344aa387eccd8d1126735aac2::study_pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VerifierCap has store, key {
        id: 0x2::object::UID,
    }

    struct Participant has store {
        hb_escrowed: u64,
        fee_usd: u64,
        entry_number: u64,
        completed: bool,
        claimed: bool,
        refunded: bool,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        pool_index: u64,
        fee_tiers_usd: vector<u64>,
        bracket_size: u64,
        hb_price_usd: u64,
        min_participants: u64,
        max_participants: u64,
        commence_ms: u64,
        end_ms: u64,
        reward_per_participant: u64,
        recovery_address: address,
        treasury: 0x2::balance::Balance<T0>,
        hb_escrow: 0x2::balance::Balance<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>,
        registry: 0x2::table::Table<address, Participant>,
        state: u8,
        participants: u64,
        total_hb_burned: u64,
        total_reward_paid: u64,
        open: bool,
    }

    struct PoolCommenced has copy, drop {
        pool_index: u64,
        participants: u64,
        hb_burned: u64,
    }

    struct PoolFailed has copy, drop {
        pool_index: u64,
        participants: u64,
        min_required: u64,
    }

    struct Entered has copy, drop {
        pool_index: u64,
        entrant: address,
        fee_usd: u64,
        hb_escrowed: u64,
        entry_number: u64,
    }

    struct Refunded has copy, drop {
        pool_index: u64,
        entrant: address,
        hb_refunded: u64,
    }

    struct CompletionMarked has copy, drop {
        pool_index: u64,
        entrant: address,
        completed: bool,
    }

    struct RewardClaimed has copy, drop {
        pool_index: u64,
        entrant: address,
        reward_paid: u64,
    }

    struct TreasuryReturned has copy, drop {
        pool_index: u64,
        to: address,
        amount: u64,
        reason: vector<u8>,
    }

    struct PoolConfigChanged has copy, drop {
        pool_index: u64,
        field: vector<u8>,
        old_value: u64,
        new_value: u64,
    }

    public fun claim_reward<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(arg0.state == 1, 2);
        assert!(v0 >= arg0.end_ms, 12);
        assert!(v0 < arg0.end_ms + 5184000000, 13);
        assert!(0x2::table::contains<address, Participant>(&arg0.registry, v1), 9);
        let v2 = 0x2::table::borrow_mut<address, Participant>(&mut arg0.registry, v1);
        assert!(v2.completed, 10);
        assert!(!v2.claimed, 11);
        v2.claimed = true;
        let v3 = arg0.reward_per_participant;
        arg0.total_reward_paid = arg0.total_reward_paid + v3;
        let v4 = RewardClaimed{
            pool_index  : arg0.pool_index,
            entrant     : v1,
            reward_paid : v3,
        };
        0x2::event::emit<RewardClaimed>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, v3), arg2)
    }

    public fun commence<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.commence_ms, 5);
        if (arg0.participants >= arg0.min_participants) {
            let v0 = 0x2::balance::value<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&arg0.hb_escrow);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>>(0x2::coin::from_balance<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(0x2::balance::withdraw_all<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&mut arg0.hb_escrow), arg2), @0x0);
            arg0.total_hb_burned = v0;
            arg0.state = 1;
            let v1 = PoolCommenced{
                pool_index   : arg0.pool_index,
                participants : arg0.participants,
                hb_burned    : v0,
            };
            0x2::event::emit<PoolCommenced>(v1);
        } else {
            arg0.state = 2;
            let v2 = PoolFailed{
                pool_index   : arg0.pool_index,
                participants : arg0.participants,
                min_required : arg0.min_participants,
            };
            0x2::event::emit<PoolFailed>(v2);
        };
    }

    public fun create_pool<T0>(arg0: &AdminCap, arg1: u64, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && !0x1::vector::is_empty<u64>(&arg2), 0);
        assert!(arg4 > 0, 1);
        assert!(arg8 > arg7, 0);
        assert!(arg9 > 0, 0);
        assert!(arg10 != @0x0, 0);
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg11),
            pool_index             : arg1,
            fee_tiers_usd          : arg2,
            bracket_size           : arg3,
            hb_price_usd           : arg4,
            min_participants       : arg5,
            max_participants       : arg6,
            commence_ms            : arg7,
            end_ms                 : arg8,
            reward_per_participant : arg9,
            recovery_address       : arg10,
            treasury               : 0x2::balance::zero<T0>(),
            hb_escrow              : 0x2::balance::zero<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(),
            registry               : 0x2::table::new<address, Participant>(arg11),
            state                  : 0,
            participants           : 0,
            total_hb_burned        : 0,
            total_reward_paid      : 0,
            open                   : true,
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun current_fee_hb<T0>(arg0: &Pool<T0>) : u64 {
        (((current_fee_usd<T0>(arg0) as u128) * (1000000000 as u128) / (arg0.hb_price_usd as u128)) as u64)
    }

    public fun current_fee_usd<T0>(arg0: &Pool<T0>) : u64 {
        let v0 = arg0.participants / arg0.bracket_size;
        let v1 = 0x1::vector::length<u64>(&arg0.fee_tiers_usd) - 1;
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        *0x1::vector::borrow<u64>(&arg0.fee_tiers_usd, v2)
    }

    public fun deposit_rewards<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.treasury, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun enter_study<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.state == 0 && arg0.open, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.commence_ms, 6);
        assert!(!0x2::table::contains<address, Participant>(&arg0.registry, v0), 8);
        assert!(arg0.max_participants == 0 || arg0.participants < arg0.max_participants, 3);
        assert!(arg0.participants < funded_seats<T0>(arg0), 7);
        let v1 = current_fee_usd<T0>(arg0);
        let v2 = current_fee_hb<T0>(arg0);
        assert!(v2 <= arg2, 16);
        assert!(0x2::coin::value<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&arg1) >= v2, 4);
        if (0x2::coin::value<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(arg1);
        };
        0x2::balance::join<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&mut arg0.hb_escrow, 0x2::coin::into_balance<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(0x2::coin::split<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&mut arg1, v2, arg4)));
        arg0.participants = arg0.participants + 1;
        let v3 = Participant{
            hb_escrowed  : v2,
            fee_usd      : v1,
            entry_number : arg0.participants,
            completed    : false,
            claimed      : false,
            refunded     : false,
        };
        0x2::table::add<address, Participant>(&mut arg0.registry, v0, v3);
        let v4 = Entered{
            pool_index   : arg0.pool_index,
            entrant      : v0,
            fee_usd      : v1,
            hb_escrowed  : v2,
            entry_number : arg0.participants,
        };
        0x2::event::emit<Entered>(v4);
    }

    public fun funded_seats<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury) / arg0.reward_per_participant
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = VerifierCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VerifierCap>(v2, v0);
    }

    fun log_change<T0>(arg0: &Pool<T0>, arg1: vector<u8>, arg2: u64, arg3: u64) {
        let v0 = PoolConfigChanged{
            pool_index : arg0.pool_index,
            field      : arg1,
            old_value  : arg2,
            new_value  : arg3,
        };
        0x2::event::emit<PoolConfigChanged>(v0);
    }

    public fun participants<T0>(arg0: &Pool<T0>) : u64 {
        arg0.participants
    }

    public fun process_refund<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 2, 2);
        assert!(0x2::table::contains<address, Participant>(&arg0.registry, arg1), 9);
        let v0 = 0x2::table::borrow_mut<address, Participant>(&mut arg0.registry, arg1);
        assert!(!v0.refunded, 11);
        v0.refunded = true;
        let v1 = v0.hb_escrowed;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>>(0x2::coin::from_balance<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(0x2::balance::split<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&mut arg0.hb_escrow, v1), arg2), arg1);
        let v2 = Refunded{
            pool_index  : arg0.pool_index,
            entrant     : arg1,
            hb_refunded : v1,
        };
        0x2::event::emit<Refunded>(v2);
    }

    public fun recover_failed_treasury<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 2, 2);
        let v0 = 0x2::balance::value<T0>(&arg0.treasury);
        assert!(v0 > 0, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.treasury), arg1), arg0.recovery_address);
        let v1 = TreasuryReturned{
            pool_index : arg0.pool_index,
            to         : arg0.recovery_address,
            amount     : v0,
            reason     : b"failed",
        };
        0x2::event::emit<TreasuryReturned>(v1);
    }

    public fun recovery_address<T0>(arg0: &Pool<T0>) : address {
        arg0.recovery_address
    }

    public fun set_completed<T0>(arg0: &VerifierCap, arg1: &mut Pool<T0>, arg2: address, arg3: bool) {
        assert!(arg1.state == 1, 2);
        assert!(0x2::table::contains<address, Participant>(&arg1.registry, arg2), 9);
        let v0 = 0x2::table::borrow_mut<address, Participant>(&mut arg1.registry, arg2);
        assert!(!v0.claimed, 11);
        v0.completed = arg3;
        let v1 = CompletionMarked{
            pool_index : arg1.pool_index,
            entrant    : arg2,
            completed  : arg3,
        };
        0x2::event::emit<CompletionMarked>(v1);
    }

    public fun set_completed_batch<T0>(arg0: &VerifierCap, arg1: &mut Pool<T0>, arg2: vector<address>, arg3: bool) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            set_completed<T0>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun set_fee_tiers<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: vector<u64>, arg3: u64) {
        assert!(!0x1::vector::is_empty<u64>(&arg2) && arg3 > 0, 0);
        log_change<T0>(arg1, b"fee_tiers", 0x1::vector::length<u64>(&arg1.fee_tiers_usd), 0x1::vector::length<u64>(&arg2));
        arg1.fee_tiers_usd = arg2;
        arg1.bracket_size = arg3;
    }

    public fun set_hb_price<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64) {
        assert!(arg2 > 0, 1);
        log_change<T0>(arg1, b"hb_price_usd", arg1.hb_price_usd, arg2);
        arg1.hb_price_usd = arg2;
    }

    public fun set_max_participants<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64) {
        log_change<T0>(arg1, b"max_participants", arg1.max_participants, arg2);
        arg1.max_participants = arg2;
    }

    public fun set_min_participants<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64) {
        assert!(arg1.state == 0, 2);
        log_change<T0>(arg1, b"min_participants", arg1.min_participants, arg2);
        arg1.min_participants = arg2;
    }

    public fun set_open<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: bool) {
        let v0 = if (arg1.open) {
            1
        } else {
            0
        };
        let v1 = if (arg2) {
            1
        } else {
            0
        };
        log_change<T0>(arg1, b"open", v0, v1);
        arg1.open = arg2;
    }

    public fun set_schedule<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: u64) {
        assert!(arg1.state == 0, 2);
        assert!(arg3 > arg2, 0);
        if (arg1.participants > 0) {
            assert!(arg2 <= arg1.commence_ms, 15);
        };
        log_change<T0>(arg1, b"end_ms", arg1.end_ms, arg3);
        arg1.commence_ms = arg2;
        arg1.end_ms = arg3;
    }

    public fun state<T0>(arg0: &Pool<T0>) : u8 {
        arg0.state
    }

    public fun sweep_unclaimed<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_ms + 5184000000, 12);
        let v0 = 0x2::balance::value<T0>(&arg0.treasury);
        assert!(v0 > 0, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.treasury), arg2), arg0.recovery_address);
        let v1 = TreasuryReturned{
            pool_index : arg0.pool_index,
            to         : arg0.recovery_address,
            amount     : v0,
            reason     : b"sweep",
        };
        0x2::event::emit<TreasuryReturned>(v1);
    }

    public fun total_burned<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_hb_burned
    }

    public fun treasury_balance<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury)
    }

    // decompiled from Move bytecode v7
}

