module 0x9437dbbdd902490c8b25859af0e14cb4badcd9aa7ff87f04aae8a693ba40390d::reward_router {
    struct RewardRouter<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        reward_balance: 0x2::balance::Balance<T0>,
        total_weighted_stake: u128,
        acc_reward_per_weight: u128,
        total_stakers_count: u64,
        total_staked_raw: u128,
        total_topped_up: u128,
        total_airdropped: u128,
    }

    struct RouterCreated has copy, drop {
        router_id: address,
        admin: address,
        timestamp_ms: u64,
    }

    struct RouterFunded has copy, drop {
        router_id: address,
        amount: u64,
        source_label: vector<u8>,
        funded_by: address,
        new_acc: u128,
        timestamp_ms: u64,
    }

    struct Top5Airdropped has copy, drop {
        router_id: address,
        total_amount: u64,
        recipients: vector<address>,
        amounts: vector<u64>,
        funded_by: address,
        timestamp_ms: u64,
    }

    struct StakeRegistered has copy, drop {
        router_id: address,
        staker: address,
        amount_raw: u64,
        weight: u64,
        weighted_added: u128,
        timestamp_ms: u64,
    }

    struct StakeUnregistered has copy, drop {
        router_id: address,
        staker: address,
        amount_raw: u64,
        weight: u64,
        timestamp_ms: u64,
    }

    struct RewardsClaimed has copy, drop {
        router_id: address,
        staker: address,
        amount: u64,
        timestamp_ms: u64,
    }

    public fun acc_per_weight<T0>(arg0: &RewardRouter<T0>) : u128 {
        arg0.acc_reward_per_weight
    }

    public fun acc_scale() : u128 {
        1000000000000
    }

    public(friend) fun add_stake<T0>(arg0: &mut RewardRouter<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = (arg1 as u128) * (arg2 as u128);
        arg0.total_weighted_stake = arg0.total_weighted_stake + v0;
        arg0.total_stakers_count = arg0.total_stakers_count + 1;
        arg0.total_staked_raw = arg0.total_staked_raw + (arg1 as u128);
        let v1 = StakeRegistered{
            router_id      : 0x2::object::uid_to_address(&arg0.id),
            staker         : 0x2::tx_context::sender(arg4),
            amount_raw     : arg1,
            weight         : arg2,
            weighted_added : v0,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StakeRegistered>(v1);
        arg0.acc_reward_per_weight
    }

    public fun admin<T0>(arg0: &RewardRouter<T0>) : address {
        arg0.admin
    }

    public entry fun airdrop_top5<T0>(arg0: &mut RewardRouter<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        assert!(0x1::vector::length<address>(&arg2) == 5, 4);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 5);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 3000);
        0x1::vector::push_back<u64>(v2, 2500);
        0x1::vector::push_back<u64>(v2, 2000);
        0x1::vector::push_back<u64>(v2, 1500);
        0x1::vector::push_back<u64>(v2, 1000);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 4) {
            let v5 = (((v0 as u128) * (*0x1::vector::borrow<u64>(&v1, v4) as u128) / 10000) as u64);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v5, arg4), *0x1::vector::borrow<address>(&arg2, v4));
            0x1::vector::push_back<u64>(&mut v3, v5);
            v4 = v4 + 1;
        };
        0x1::vector::push_back<u64>(&mut v3, 0x2::coin::value<T0>(&arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, *0x1::vector::borrow<address>(&arg2, 4));
        arg0.total_airdropped = arg0.total_airdropped + (v0 as u128);
        let v6 = Top5Airdropped{
            router_id    : 0x2::object::uid_to_address(&arg0.id),
            total_amount : v0,
            recipients   : arg2,
            amounts      : v3,
            funded_by    : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Top5Airdropped>(v6);
    }

    public entry fun create_router<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardRouter<T0>{
            id                    : 0x2::object::new(arg1),
            admin                 : 0x2::tx_context::sender(arg1),
            reward_balance        : 0x2::balance::zero<T0>(),
            total_weighted_stake  : 0,
            acc_reward_per_weight : 0,
            total_stakers_count   : 0,
            total_staked_raw      : 0,
            total_topped_up       : 0,
            total_airdropped      : 0,
        };
        let v1 = RouterCreated{
            router_id    : 0x2::object::uid_to_address(&v0.id),
            admin        : 0x2::tx_context::sender(arg1),
            timestamp_ms : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<RouterCreated>(v1);
        0x2::transfer::share_object<RewardRouter<T0>>(v0);
    }

    public(friend) fun deposit_external_skim<T0>(arg0: &mut RewardRouter<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 5);
        if (arg0.total_weighted_stake > 0) {
            arg0.acc_reward_per_weight = arg0.acc_reward_per_weight + (v0 as u128) * 1000000000000 / arg0.total_weighted_stake;
        };
        0x2::balance::join<T0>(&mut arg0.reward_balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_topped_up = arg0.total_topped_up + (v0 as u128);
        let v1 = RouterFunded{
            router_id    : 0x2::object::uid_to_address(&arg0.id),
            amount       : v0,
            source_label : b"creator_pool_2pct",
            funded_by    : 0x2::tx_context::sender(arg3),
            new_acc      : arg0.acc_reward_per_weight,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RouterFunded>(v1);
    }

    public entry fun fund_router<T0>(arg0: &mut RewardRouter<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        assert!(is_valid_label(&arg2), 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 5);
        if (arg0.total_weighted_stake > 0) {
            arg0.acc_reward_per_weight = arg0.acc_reward_per_weight + (v0 as u128) * 1000000000000 / arg0.total_weighted_stake;
        };
        0x2::balance::join<T0>(&mut arg0.reward_balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_topped_up = arg0.total_topped_up + (v0 as u128);
        let v1 = RouterFunded{
            router_id    : 0x2::object::uid_to_address(&arg0.id),
            amount       : v0,
            source_label : arg2,
            funded_by    : 0x2::tx_context::sender(arg4),
            new_acc      : arg0.acc_reward_per_weight,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RouterFunded>(v1);
    }

    fun is_valid_label(arg0: &vector<u8>) : bool {
        let v0 = b"launch_fee";
        if (arg0 == &v0) {
            true
        } else {
            let v2 = b"bot_lp";
            if (arg0 == &v2) {
                true
            } else {
                let v3 = b"arena_fee";
                if (arg0 == &v3) {
                    true
                } else {
                    let v4 = b"airdrop_reserve";
                    if (arg0 == &v4) {
                        true
                    } else {
                        let v5 = b"other";
                        if (arg0 == &v5) {
                            true
                        } else {
                            let v6 = b"creator_pool_2pct";
                            arg0 == &v6
                        }
                    }
                }
            }
        }
    }

    public(friend) fun remove_stake<T0>(arg0: &mut RewardRouter<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg1 as u128) * (arg2 as u128);
        let v1 = if (arg0.total_weighted_stake >= v0) {
            arg0.total_weighted_stake - v0
        } else {
            0
        };
        arg0.total_weighted_stake = v1;
        if (arg0.total_stakers_count > 0) {
            arg0.total_stakers_count = arg0.total_stakers_count - 1;
        };
        let v2 = if (arg0.total_staked_raw >= (arg1 as u128)) {
            arg0.total_staked_raw - (arg1 as u128)
        } else {
            0
        };
        arg0.total_staked_raw = v2;
        let v3 = StakeUnregistered{
            router_id    : 0x2::object::uid_to_address(&arg0.id),
            staker       : 0x2::tx_context::sender(arg4),
            amount_raw   : arg1,
            weight       : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StakeUnregistered>(v3);
    }

    public fun reward_balance_value<T0>(arg0: &RewardRouter<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward_balance)
    }

    public entry fun set_admin<T0>(arg0: &mut RewardRouter<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public fun total_airdropped<T0>(arg0: &RewardRouter<T0>) : u128 {
        arg0.total_airdropped
    }

    public fun total_staked_raw<T0>(arg0: &RewardRouter<T0>) : u128 {
        arg0.total_staked_raw
    }

    public fun total_stakers<T0>(arg0: &RewardRouter<T0>) : u64 {
        arg0.total_stakers_count
    }

    public fun total_topped_up<T0>(arg0: &RewardRouter<T0>) : u128 {
        arg0.total_topped_up
    }

    public fun total_weighted_stake<T0>(arg0: &RewardRouter<T0>) : u128 {
        arg0.total_weighted_stake
    }

    public(friend) fun withdraw_for_claim<T0>(arg0: &mut RewardRouter<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= arg1, 3);
        let v0 = RewardsClaimed{
            router_id    : 0x2::object::uid_to_address(&arg0.id),
            staker       : 0x2::tx_context::sender(arg3),
            amount       : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RewardsClaimed>(v0);
        0x2::coin::take<T0>(&mut arg0.reward_balance, arg1, arg3)
    }

    // decompiled from Move bytecode v7
}

