module 0xd03cb46e67910cab1a8730fd99e2f81c2b1169587c57523e9066c2d7140eb420::reward_distribution {
    struct RewardTreasury has key {
        id: 0x2::object::UID,
        distributor: address,
        total_rewards_distributed: u64,
    }

    struct PHX_TOKEN has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct RewardDistributed has copy, drop {
        recipient: address,
        amount: u64,
        reward_type: vector<u8>,
        timestamp: u64,
    }

    fun calculate_complex_reward(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 100000) {
            v0 = v0 + arg0 * arg1 % (v1 + 1) / 1000;
            v1 = v1 + 1;
        };
        v0
    }

    public fun consolidate_all_rewards(arg0: vector<PHX_TOKEN>, arg1: vector<PHX_TOKEN>, arg2: vector<PHX_TOKEN>, arg3: vector<PHX_TOKEN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PHX_TOKEN{
            id    : 0x2::object::new(arg4),
            value : consolidate_tokens(arg0) + consolidate_tokens(arg1) + consolidate_tokens(arg2) + consolidate_tokens(arg3),
        };
        0x2::transfer::public_transfer<PHX_TOKEN>(v0, 0x2::tx_context::sender(arg4));
    }

    fun consolidate_tokens(arg0: vector<PHX_TOKEN>) : u64 {
        let v0 = 0;
        while (!0x1::vector::is_empty<PHX_TOKEN>(&arg0)) {
            let v1 = 0x1::vector::pop_back<PHX_TOKEN>(&mut arg0);
            v0 = v0 + v1.value;
            let PHX_TOKEN {
                id    : v2,
                value : _,
            } = v1;
            0x2::object::delete(v2);
        };
        0x1::vector::destroy_empty<PHX_TOKEN>(arg0);
        v0
    }

    public fun create_batch_rewards(arg0: &mut RewardTreasury, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.distributor, 0);
        create_nested_batches(arg0, arg1, arg2, arg3, 5, arg4);
    }

    fun create_nested_batches(arg0: &mut RewardTreasury, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg4 == 0 || arg2 == 0) {
            return
        };
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = 0;
            while (v1 < arg3) {
                let v2 = PHX_TOKEN{
                    id    : 0x2::object::new(arg5),
                    value : 1000 * (arg4 + v1),
                };
                0x2::transfer::public_transfer<PHX_TOKEN>(v2, arg1);
                v1 = v1 + 1;
            };
            create_nested_batches(arg0, arg1, 3, arg3, arg4 - 1, arg5);
            v0 = v0 + 1;
        };
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + arg2 * arg3;
    }

    public fun create_staking_positions(arg0: &mut RewardTreasury, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.distributor, 0);
        let v0 = 0;
        while (v0 < arg3) {
            let v1 = PHX_TOKEN{
                id    : 0x2::object::new(arg4),
                value : calculate_complex_reward(arg2, v0),
            };
            0x2::transfer::public_transfer<PHX_TOKEN>(v1, arg1);
            v0 = v0 + 1;
        };
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + arg3;
    }

    public fun create_storage_rewards(arg0: &mut RewardTreasury, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.distributor, 0);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = PHX_TOKEN{
                id    : 0x2::object::new(arg3),
                value : 5000 + v0,
            };
            0x2::transfer::public_transfer<PHX_TOKEN>(v1, arg1);
            v0 = v0 + 1;
        };
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + arg2;
    }

    public fun distribute_micro_airdrop(arg0: &mut RewardTreasury, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.distributor, 0);
        let v1 = 0;
        while (v1 < 10000) {
            let v2 = if (v1 < 0x1::vector::length<address>(&arg1)) {
                *0x1::vector::borrow<address>(&arg1, v1)
            } else {
                *0x1::vector::borrow<address>(&arg1, 0)
            };
            let v3 = PHX_TOKEN{
                id    : 0x2::object::new(arg2),
                value : 1,
            };
            0x2::transfer::public_transfer<PHX_TOKEN>(v3, v2);
            v1 = v1 + 1;
        };
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + 10000;
        let v4 = RewardDistributed{
            recipient   : v0,
            amount      : 10000,
            reward_type : b"micro_airdrop",
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RewardDistributed>(v4);
    }

    public fun estimate_total_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg0 * 1 + arg1 * 50000 + arg2 * 5000 + arg3 * 5000
    }

    public fun get_token_value(arg0: &PHX_TOKEN) : u64 {
        arg0.value
    }

    public fun get_treasury_stats(arg0: &RewardTreasury) : (u64, address) {
        (arg0.total_rewards_distributed, arg0.distributor)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardTreasury{
            id                        : 0x2::object::new(arg0),
            distributor               : 0x2::tx_context::sender(arg0),
            total_rewards_distributed : 0,
        };
        0x2::transfer::share_object<RewardTreasury>(v0);
    }

    public fun is_distributor(arg0: &RewardTreasury, arg1: address) : bool {
        arg0.distributor == arg1
    }

    // decompiled from Move bytecode v6
}

