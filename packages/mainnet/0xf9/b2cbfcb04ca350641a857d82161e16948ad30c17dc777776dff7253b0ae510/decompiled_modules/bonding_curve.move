module 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::bonding_curve {
    public fun calculate_constant_product(arg0: u64, arg1: u64) : u128 {
        0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::mul(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg0), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg1))
    }

    public(friend) fun calculate_price(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::as_u64(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::div(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::mul(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg0), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(1000000)), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg1)))
    }

    public(friend) fun calculate_sale_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 >= arg2, 0);
        0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::as_u64(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::sub(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg0), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::div(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::mul(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg0), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg1)), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::add(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg1), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg2)))))
    }

    public(friend) fun calculate_tokens_to_mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::as_u64(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::sub(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg1), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::div(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::mul(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg0), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg1)), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::add(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg0), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg2)))))
    }

    public(friend) fun has_reached_graduation_threshold(arg0: u64, arg1: u64) : bool {
        arg0 >= arg1
    }

    // decompiled from Move bytecode v6
}

