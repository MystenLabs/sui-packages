module 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::error {
    public(friend) fun insufficient_permissions() : u64 {
        2001
    }

    public(friend) fun insufficient_vault_balance() : u64 {
        2000
    }

    public(friend) fun invalid_repayment_amount() : u64 {
        3001
    }

    public(friend) fun invalid_sender() : u64 {
        2004
    }

    public(friend) fun invalid_trader() : u64 {
        2005
    }

    public(friend) fun position_not_found() : u64 {
        4000
    }

    public(friend) fun repay_to_wrong_lender() : u64 {
        3000
    }

    public(friend) fun repay_to_wrong_vault() : u64 {
        3002
    }

    public(friend) fun vault_is_disabled() : u64 {
        2003
    }

    public(friend) fun zero_amount() : u64 {
        2002
    }

    // decompiled from Move bytecode v7
}

