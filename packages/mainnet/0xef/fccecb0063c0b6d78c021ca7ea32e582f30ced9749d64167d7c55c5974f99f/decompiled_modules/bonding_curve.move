module 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::bonding_curve {
    public fun calculate_constant_product(arg0: u64, arg1: u64) : u128 {
        0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::mul(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg0), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg1))
    }

    public(friend) fun calculate_price(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::as_u64(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::div(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::mul(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg0), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(1000000)), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg1)))
    }

    public(friend) fun calculate_sale_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 >= arg2, 0);
        0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::as_u64(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::sub(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg0), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::div(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::mul(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg0), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg1)), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::add(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg1), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg2)))))
    }

    public(friend) fun calculate_tokens_to_mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::as_u64(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::sub(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg1), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::div(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::mul(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg0), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg1)), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::add(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg0), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg2)))))
    }

    public(friend) fun has_reached_graduation_threshold(arg0: u64, arg1: u64) : bool {
        arg0 >= arg1
    }

    // decompiled from Move bytecode v6
}

