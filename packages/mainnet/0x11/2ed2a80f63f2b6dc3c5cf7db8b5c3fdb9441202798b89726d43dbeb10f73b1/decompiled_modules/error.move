module 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error {
    public(friend) fun Is_suspended() : u64 {
        10
    }

    public(friend) fun insufficient_balance() : u64 {
        3
    }

    public(friend) fun insufficient_liquidity() : u64 {
        4
    }

    public(friend) fun insufficient_vault_balance() : u64 {
        8
    }

    public(friend) fun invalid_pay_amount() : u64 {
        7
    }

    public(friend) fun is_zero() : u64 {
        9
    }

    public(friend) fun not_authorized() : u64 {
        1
    }

    public(friend) fun position_not_found() : u64 {
        2
    }

    public(friend) fun slippage_too_little_input() : u64 {
        501
    }

    public(friend) fun slippage_too_little_output() : u64 {
        5
    }

    public(friend) fun slippage_too_much_input() : u64 {
        6
    }

    // decompiled from Move bytecode v6
}

