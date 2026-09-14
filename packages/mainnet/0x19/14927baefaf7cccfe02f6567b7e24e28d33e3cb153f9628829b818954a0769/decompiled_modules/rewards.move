module 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::rewards {
    struct RewardRound<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        index: u64,
        root: vector<u8>,
        total: u64,
        claimed_amount: u64,
        claimed: 0x2::table::Table<address, bool>,
        funds: 0x2::balance::Balance<T1>,
        snapshot_ms: u64,
        claim_end_ms: u64,
        closed: bool,
    }

    public fun claim<T0, T1>(arg0: &mut RewardRound<T0, T1>, arg1: u64, arg2: vector<vector<u8>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(take_entitlement<T0, T1>(arg0, 0x2::tx_context::sender(arg4), arg1, &arg2, arg3), arg4)
    }

    public fun close_round<T0, T1>(arg0: &mut RewardRound<T0, T1>, arg1: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(!arg0.closed, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::round_closed());
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.claim_end_ms, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::round_not_ended());
        assert!(arg0.launch_id == 0x2::object::id<0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>>(arg1), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_launch());
        arg0.closed = true;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::return_rewards<T0, T1>(arg1, 0x2::balance::withdraw_all<T1>(&mut arg0.funds));
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_reward_round_closed(0x2::object::id<RewardRound<T0, T1>>(arg0), arg0.launch_id, 0x2::balance::value<T1>(&arg0.funds));
    }

    public fun distribute<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::RewardsCap, arg1: &mut RewardRound<T0, T1>, arg2: address, arg3: u64, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(take_entitlement<T0, T1>(arg1, arg2, arg3, &arg4, arg5), arg6), arg2);
    }

    public fun has_claimed<T0, T1>(arg0: &RewardRound<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    public fun index<T0, T1>(arg0: &RewardRound<T0, T1>) : u64 {
        arg0.index
    }

    public fun remaining<T0, T1>(arg0: &RewardRound<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.funds)
    }

    public fun start_round<T0, T1>(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::RewardsCap, arg1: &mut 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_proof());
        assert!(arg6 >= 86400000 && arg6 <= 31536000000, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_window());
        assert!(arg5 <= 0x2::clock::timestamp_ms(arg7), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_window());
        let v0 = 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::next_reward_round<T0, T1>(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg7) + arg6;
        let v2 = RewardRound<T0, T1>{
            id             : 0x2::object::new(arg8),
            launch_id      : 0x2::object::id<0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::WhirlpoolLaunch<T0, T1>>(arg1),
            index          : v0,
            root           : arg2,
            total          : arg3,
            claimed_amount : 0,
            claimed        : 0x2::table::new<address, bool>(arg8),
            funds          : 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::cetus_launch::take_rewards<T0, T1>(arg1, arg3),
            snapshot_ms    : arg5,
            claim_end_ms   : v1,
            closed         : false,
        };
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_reward_round_started(0x2::object::id<RewardRound<T0, T1>>(&v2), v2.launch_id, v0, v2.root, arg3, arg4, arg5, v1);
        0x2::transfer::share_object<RewardRound<T0, T1>>(v2);
    }

    fun take_entitlement<T0, T1>(arg0: &mut RewardRound<T0, T1>, arg1: address, arg2: u64, arg3: &vector<vector<u8>>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        assert!(!arg0.closed && 0x2::clock::timestamp_ms(arg4) <= arg0.claim_end_ms, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::round_closed());
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, arg1), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::already_claimed());
        assert!(0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::merkle::verify(&arg0.root, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::merkle::leaf(0x2::object::id_to_address(&arg0.launch_id), arg0.index, arg1, arg2), arg3), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_proof());
        0x2::table::add<address, bool>(&mut arg0.claimed, arg1, true);
        arg0.claimed_amount = arg0.claimed_amount + arg2;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_reward_claimed(0x2::object::id<RewardRound<T0, T1>>(arg0), arg0.launch_id, arg1, arg2);
        0x2::balance::split<T1>(&mut arg0.funds, arg2)
    }

    // decompiled from Move bytecode v7
}

