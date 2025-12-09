module 0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::miner {
    struct Miner has drop, store {
        checkpoint_id: u64,
        round_id: u64,
        rewards_factor: u256,
        rewards_aur: u64,
        rewards_sui: u64,
        refined_aur: u64,
        last_claim_sui_at: u64,
        last_claim_aur_at: u64,
        lifetime_rewards_sui: u64,
        lifetime_rewards_aur: u64,
        block_ids: vector<u64>,
        block_deployed_amounts: vector<u64>,
        block_cumulative_ends: vector<u64>,
    }

    public(friend) fun borrow_block_info(arg0: &Miner, arg1: u64) : (u64, u64, u64) {
        let v0 = find_block_idx(&arg0.block_ids, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let v4 = 0x1::option::extract<u64>(&mut v0);
            let v5 = *0x1::vector::borrow<u64>(&arg0.block_deployed_amounts, v4);
            let v6 = *0x1::vector::borrow<u64>(&arg0.block_cumulative_ends, v4);
            (v5, v6 - v5 + 1, v6)
        } else {
            (0, 0, 0)
        }
    }

    public fun borrow_checkpoint_id(arg0: &Miner) : u64 {
        arg0.checkpoint_id
    }

    public fun borrow_last_claim_aur_at(arg0: &Miner) : u64 {
        arg0.last_claim_aur_at
    }

    public fun borrow_last_claim_sui_at(arg0: &Miner) : u64 {
        arg0.last_claim_sui_at
    }

    public fun borrow_lifetime_rewards_aur(arg0: &Miner) : u64 {
        arg0.lifetime_rewards_aur
    }

    public fun borrow_lifetime_rewards_sui(arg0: &Miner) : u64 {
        arg0.lifetime_rewards_sui
    }

    public fun borrow_refined_aur(arg0: &Miner) : u64 {
        arg0.refined_aur
    }

    public fun borrow_rewards_aur(arg0: &Miner) : u64 {
        arg0.rewards_aur
    }

    public fun borrow_rewards_factor(arg0: &Miner) : u256 {
        arg0.rewards_factor
    }

    public fun borrow_rewards_sui(arg0: &Miner) : u64 {
        arg0.rewards_sui
    }

    public fun borrow_round_id(arg0: &Miner) : u64 {
        arg0.round_id
    }

    public(friend) fun clone_miner(arg0: &Miner) : Miner {
        Miner{
            checkpoint_id          : arg0.checkpoint_id,
            round_id               : arg0.round_id,
            rewards_factor         : arg0.rewards_factor,
            rewards_aur            : arg0.rewards_aur,
            rewards_sui            : arg0.rewards_sui,
            refined_aur            : arg0.refined_aur,
            last_claim_sui_at      : arg0.last_claim_sui_at,
            last_claim_aur_at      : arg0.last_claim_aur_at,
            lifetime_rewards_sui   : arg0.lifetime_rewards_sui,
            lifetime_rewards_aur   : arg0.lifetime_rewards_aur,
            block_ids              : 0x1::vector::empty<u64>(),
            block_deployed_amounts : 0x1::vector::empty<u64>(),
            block_cumulative_ends  : 0x1::vector::empty<u64>(),
        }
    }

    public(friend) fun deploy(arg0: &mut Miner, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = find_block_idx(&arg0.block_ids, arg1);
        assert!(!0x1::option::is_some<u64>(&v0), 1);
        0x1::vector::push_back<u64>(&mut arg0.block_ids, arg1);
        0x1::vector::push_back<u64>(&mut arg0.block_deployed_amounts, arg2);
        0x1::vector::push_back<u64>(&mut arg0.block_cumulative_ends, arg3);
    }

    fun find_block_idx(arg0: &vector<u64>, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                v1 = 0x1::option::some<u64>(v0);
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = 0x1::option::none<u64>();
        v1
    }

    public(friend) fun new() : Miner {
        Miner{
            checkpoint_id          : 0,
            round_id               : 0,
            rewards_factor         : 0,
            rewards_aur            : 0,
            rewards_sui            : 0,
            refined_aur            : 0,
            last_claim_sui_at      : 0,
            last_claim_aur_at      : 0,
            lifetime_rewards_sui   : 0,
            lifetime_rewards_aur   : 0,
            block_ids              : 0x1::vector::empty<u64>(),
            block_deployed_amounts : 0x1::vector::empty<u64>(),
            block_cumulative_ends  : 0x1::vector::empty<u64>(),
        }
    }

    public(friend) fun reset_block_info(arg0: &mut Miner) {
        arg0.block_ids = 0x1::vector::empty<u64>();
        arg0.block_deployed_amounts = 0x1::vector::empty<u64>();
        arg0.block_cumulative_ends = 0x1::vector::empty<u64>();
    }

    public(friend) fun set_checkpoint_id(arg0: &mut Miner, arg1: u64) {
        arg0.checkpoint_id = arg1;
    }

    public(friend) fun set_last_claim_aur_at(arg0: &mut Miner, arg1: u64) {
        arg0.last_claim_aur_at = arg1;
    }

    public(friend) fun set_last_claim_sui_at(arg0: &mut Miner, arg1: u64) {
        arg0.last_claim_sui_at = arg1;
    }

    public(friend) fun set_lifetime_rewards_aur(arg0: &mut Miner, arg1: u64) {
        arg0.lifetime_rewards_aur = arg1;
    }

    public(friend) fun set_lifetime_rewards_sui(arg0: &mut Miner, arg1: u64) {
        arg0.lifetime_rewards_sui = arg1;
    }

    public(friend) fun set_refined_aur(arg0: &mut Miner, arg1: u64) {
        arg0.refined_aur = arg1;
    }

    public(friend) fun set_rewards_aur(arg0: &mut Miner, arg1: u64) {
        arg0.rewards_aur = arg1;
    }

    public(friend) fun set_rewards_factor(arg0: &mut Miner, arg1: u256) {
        arg0.rewards_factor = arg1;
    }

    public(friend) fun set_rewards_sui(arg0: &mut Miner, arg1: u64) {
        arg0.rewards_sui = arg1;
    }

    public(friend) fun set_round_id(arg0: &mut Miner, arg1: u64) {
        arg0.round_id = arg1;
    }

    public(friend) fun update_rewards(arg0: &mut Miner, arg1: u256) {
        if (arg1 > arg0.rewards_factor) {
            let v0 = arg1 - arg0.rewards_factor;
            assert!(v0 >= 0, 0);
            let v1 = v0 * (arg0.rewards_aur as u256) / (1000000 as u256);
            arg0.refined_aur = arg0.refined_aur + (v1 as u64);
            arg0.lifetime_rewards_aur = arg0.lifetime_rewards_aur + (v1 as u64);
        };
        arg0.rewards_factor = arg1;
    }

    // decompiled from Move bytecode v6
}

