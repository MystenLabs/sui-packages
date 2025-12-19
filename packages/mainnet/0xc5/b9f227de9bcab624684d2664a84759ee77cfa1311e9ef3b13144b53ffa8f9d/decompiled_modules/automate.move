module 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate {
    struct Automate has copy, drop, store {
        deployed_amount_per_block: u64,
        blocks_per_round: u64,
        is_auto_strategy: bool,
        block_ids: 0x1::option::Option<vector<u64>>,
        seed: 0x1::option::Option<u64>,
        round_left: u64,
        fee_per_round: u64,
    }

    public fun borrow_block_ids(arg0: &Automate) : vector<u64> {
        *0x1::option::borrow<vector<u64>>(&arg0.block_ids)
    }

    public fun borrow_blocks_per_round(arg0: &Automate) : u64 {
        arg0.blocks_per_round
    }

    public fun borrow_deployed_amount_per_block(arg0: &Automate) : u64 {
        arg0.deployed_amount_per_block
    }

    public fun borrow_fee_per_round(arg0: &Automate) : u64 {
        arg0.fee_per_round
    }

    public fun borrow_is_auto_strategy(arg0: &Automate) : bool {
        arg0.is_auto_strategy
    }

    public fun borrow_round_left(arg0: &Automate) : u64 {
        arg0.round_left
    }

    public fun borrow_seed(arg0: &Automate) : u64 {
        *0x1::option::borrow<u64>(&arg0.seed)
    }

    public(friend) fun decrease_round_left(arg0: &mut Automate, arg1: u64) {
        if (arg0.round_left >= arg1) {
            arg0.round_left = arg0.round_left - arg1;
        };
    }

    public(friend) fun increase_seed(arg0: &mut Automate, arg1: u64) {
        arg0.seed = 0x1::option::some<u64>(borrow_seed(arg0) + arg1);
    }

    public(friend) fun new_automate(arg0: u64, arg1: u64, arg2: bool, arg3: 0x1::option::Option<vector<u64>>, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: u64) : Automate {
        Automate{
            deployed_amount_per_block : arg0,
            blocks_per_round          : arg1,
            is_auto_strategy          : arg2,
            block_ids                 : arg3,
            seed                      : arg4,
            round_left                : arg5,
            fee_per_round             : arg6,
        }
    }

    // decompiled from Move bytecode v6
}

