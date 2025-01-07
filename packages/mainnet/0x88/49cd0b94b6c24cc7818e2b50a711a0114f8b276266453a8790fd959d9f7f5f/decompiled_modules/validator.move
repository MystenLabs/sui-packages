module 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator {
    struct Validator has store {
        validator_address: address,
        staked_suis: 0x2::linked_table::LinkedTable<u64, 0x3::staking_pool::StakedSui>,
        total_staked: u64,
        total_rewards: u64,
        last_total_rewards_claimed: u64,
        version: u64,
    }

    public(friend) fun borrow_mut_staked_suis(arg0: &mut Validator) : &mut 0x2::linked_table::LinkedTable<u64, 0x3::staking_pool::StakedSui> {
        &mut arg0.staked_suis
    }

    public(friend) fun borrow_mut_total_staked(arg0: &mut Validator) : &mut u64 {
        &mut arg0.total_staked
    }

    public(friend) fun borrow_staked_suis(arg0: &Validator) : &0x2::linked_table::LinkedTable<u64, 0x3::staking_pool::StakedSui> {
        &arg0.staked_suis
    }

    public(friend) fun create_validator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Validator {
        Validator{
            validator_address          : arg0,
            staked_suis                : 0x2::linked_table::new<u64, 0x3::staking_pool::StakedSui>(arg1),
            total_staked               : 0,
            total_rewards              : 0,
            last_total_rewards_claimed : 0,
            version                    : 1,
        }
    }

    public fun protocol_fees_to_claim(arg0: &Validator) : u64 {
        let v0 = arg0.total_rewards - arg0.last_total_rewards_claimed;
        if (v0 == 0) {
            return 0
        };
        v0 * 10000 / 10000 * 600 / 10000
    }

    public(friend) fun set_last_total_rewards_claimed(arg0: &mut Validator) {
        arg0.last_total_rewards_claimed = arg0.total_rewards;
    }

    public(friend) fun stake_pool_id(arg0: &Validator) : 0x2::object::ID {
        0x3::staking_pool::pool_id(0x2::linked_table::borrow<u64, 0x3::staking_pool::StakedSui>(&arg0.staked_suis, *0x1::option::borrow<u64>(0x2::linked_table::front<u64, 0x3::staking_pool::StakedSui>(&arg0.staked_suis))))
    }

    public fun total_staked(arg0: &Validator) : u64 {
        arg0.total_staked
    }

    public(friend) fun update_total_rewards(arg0: &mut Validator, arg1: u64) {
        let v0 = arg0.total_rewards + arg1;
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::events::emit_validator_rewards_updated(arg0.total_rewards, v0);
        arg0.total_rewards = v0;
    }

    public fun validator_address(arg0: &Validator) : address {
        arg0.validator_address
    }

    // decompiled from Move bytecode v6
}

