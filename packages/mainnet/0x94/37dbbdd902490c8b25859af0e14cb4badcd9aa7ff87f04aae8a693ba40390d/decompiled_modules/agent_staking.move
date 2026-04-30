module 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::agent_staking {
    struct StakeReceipt<phantom T0> has key {
        id: 0x2::object::UID,
        router_id: 0x2::object::ID,
        owner: address,
        amount_raw: u64,
        tier: u8,
        weight: u64,
        weighted: u128,
        staked_at_ms: u64,
        unlock_at_ms: u64,
        claimed_acc: u128,
        principal: 0x2::balance::Balance<T0>,
    }

    struct Staked has copy, drop {
        receipt_id: address,
        router_id: address,
        staker: address,
        amount_raw: u64,
        tier: u8,
        weight: u64,
        unlock_at_ms: u64,
        timestamp_ms: u64,
    }

    struct Unstaked has copy, drop {
        receipt_id: address,
        router_id: address,
        staker: address,
        amount_raw: u64,
        final_claim: u64,
        timestamp_ms: u64,
    }

    struct Claimed has copy, drop {
        receipt_id: address,
        router_id: address,
        staker: address,
        amount: u64,
        new_claimed_acc: u128,
        timestamp_ms: u64,
    }

    public fun amount_raw<T0>(arg0: &StakeReceipt<T0>) : u64 {
        arg0.amount_raw
    }

    public entry fun claim<T0>(arg0: &mut 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>, arg1: &mut StakeReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.router_id == 0x2::object::id<0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>>(arg0), 3);
        let v0 = compute_pending_claim<T0>(arg0, arg1);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::withdraw_for_claim<T0>(arg0, v0, arg2, arg3), 0x2::tx_context::sender(arg3));
        };
        let v1 = 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::acc_per_weight<T0>(arg0);
        arg1.claimed_acc = v1;
        let v2 = Claimed{
            receipt_id      : 0x2::object::uid_to_address(&arg1.id),
            router_id       : 0x2::object::id_address<0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>>(arg0),
            staker          : 0x2::tx_context::sender(arg3),
            amount          : v0,
            new_claimed_acc : v1,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Claimed>(v2);
    }

    public fun claimed_acc<T0>(arg0: &StakeReceipt<T0>) : u128 {
        arg0.claimed_acc
    }

    fun compute_pending_claim<T0>(arg0: &0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>, arg1: &StakeReceipt<T0>) : u64 {
        let v0 = 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::acc_per_weight<T0>(arg0);
        if (v0 <= arg1.claimed_acc) {
            return 0
        };
        (((v0 - arg1.claimed_acc) * arg1.weighted / 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::acc_scale()) as u64)
    }

    public fun min_stake_raw() : u64 {
        100000000
    }

    public fun owner<T0>(arg0: &StakeReceipt<T0>) : address {
        arg0.owner
    }

    public fun pending_claim<T0>(arg0: &0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>, arg1: &StakeReceipt<T0>) : u64 {
        compute_pending_claim<T0>(arg0, arg1)
    }

    public fun router_id<T0>(arg0: &StakeReceipt<T0>) : 0x2::object::ID {
        arg0.router_id
    }

    public entry fun stake<T0>(arg0: &mut 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        assert!(v0 >= 100000000, 5);
        let v1 = tier_weight_for(arg2);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = v2 + tier_lock_ms_for(arg2);
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = StakeReceipt<T0>{
            id           : 0x2::object::new(arg4),
            router_id    : 0x2::object::id<0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>>(arg0),
            owner        : v4,
            amount_raw   : v0,
            tier         : arg2,
            weight       : v1,
            weighted     : (v0 as u128) * (v1 as u128),
            staked_at_ms : v2,
            unlock_at_ms : v3,
            claimed_acc  : 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::add_stake<T0>(arg0, v0, v1, arg3, arg4),
            principal    : 0x2::coin::into_balance<T0>(arg1),
        };
        let v6 = Staked{
            receipt_id   : 0x2::object::uid_to_address(&v5.id),
            router_id    : 0x2::object::id_address<0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>>(arg0),
            staker       : v4,
            amount_raw   : v0,
            tier         : arg2,
            weight       : v1,
            unlock_at_ms : v3,
            timestamp_ms : v2,
        };
        0x2::event::emit<Staked>(v6);
        0x2::transfer::transfer<StakeReceipt<T0>>(v5, v4);
    }

    public fun staked_at_ms<T0>(arg0: &StakeReceipt<T0>) : u64 {
        arg0.staked_at_ms
    }

    public fun tier<T0>(arg0: &StakeReceipt<T0>) : u8 {
        arg0.tier
    }

    public fun tier_180d() : u8 {
        2
    }

    public fun tier_30d() : u8 {
        0
    }

    public fun tier_90d() : u8 {
        1
    }

    fun tier_lock_ms_for(arg0: u8) : u64 {
        if (arg0 == 0) {
            30 * 86400000
        } else if (arg0 == 1) {
            90 * 86400000
        } else {
            180 * 86400000
        }
    }

    fun tier_weight_for(arg0: u8) : u64 {
        if (arg0 == 0) {
            1
        } else if (arg0 == 1) {
            2
        } else {
            4
        }
    }

    public fun unlock_at_ms<T0>(arg0: &StakeReceipt<T0>) : u64 {
        arg0.unlock_at_ms
    }

    public entry fun unstake<T0>(arg0: &mut 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>, arg1: StakeReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.unlock_at_ms <= v0, 2);
        assert!(arg1.router_id == 0x2::object::id<0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>>(arg0), 3);
        let v1 = compute_pending_claim<T0>(arg0, &arg1);
        let v2 = 0x2::tx_context::sender(arg3);
        let StakeReceipt {
            id           : v3,
            router_id    : _,
            owner        : _,
            amount_raw   : v6,
            tier         : _,
            weight       : v8,
            weighted     : _,
            staked_at_ms : _,
            unlock_at_ms : _,
            claimed_acc  : _,
            principal    : v13,
        } = arg1;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::withdraw_for_claim<T0>(arg0, v1, arg2, arg3), v2);
        };
        0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::remove_stake<T0>(arg0, v6, v8, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg3), v2);
        0x2::object::delete(v3);
        let v14 = Unstaked{
            receipt_id   : 0x2::object::uid_to_address(&arg1.id),
            router_id    : 0x2::object::id_address<0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router::RewardRouter<T0>>(arg0),
            staker       : v2,
            amount_raw   : v6,
            final_claim  : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<Unstaked>(v14);
    }

    public fun weight<T0>(arg0: &StakeReceipt<T0>) : u64 {
        arg0.weight
    }

    // decompiled from Move bytecode v7
}

