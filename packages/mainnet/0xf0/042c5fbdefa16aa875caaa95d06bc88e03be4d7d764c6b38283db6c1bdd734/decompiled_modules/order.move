module 0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::order {
    struct Order has copy, drop {
        from_address: vector<u8>,
        to_address: vector<u8>,
        filler_from_address: vector<u8>,
        filler_to_address: vector<u8>,
        from_token: vector<u8>,
        to_token: vector<u8>,
        expiry: u256,
        from_amount: u256,
        fill_amount: u256,
        fee_rate: u256,
        from_chain: u256,
        to_chain: u256,
        post_hook_hash: vector<u8>,
    }

    public(friend) fun new(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: vector<u8>) : Order {
        assert!(0x1::vector::length<u8>(&arg12) == 0 || 0x1::vector::length<u8>(&arg12) == 32, 9223372431992553485);
        Order{
            from_address        : arg0,
            to_address          : arg1,
            filler_from_address : arg2,
            filler_to_address   : arg3,
            from_token          : arg4,
            to_token            : arg5,
            expiry              : arg6,
            from_amount         : arg7,
            fill_amount         : arg8,
            fee_rate            : arg9,
            from_chain          : arg10,
            to_chain            : arg11,
            post_hook_hash      : arg12,
        }
    }

    public(friend) fun order_hash(arg0: &Order) : vector<u8> {
        let v0 = 0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::new_writer(13);
        0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_u256(0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_u256(0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_u256(0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_u256(0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_u256(0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_u256(0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_bytes(0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_bytes(0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_bytes(0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_bytes(0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_bytes(0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::write_bytes(&mut v0, arg0.from_address), arg0.to_address), arg0.filler_from_address), arg0.filler_to_address), arg0.from_token), arg0.to_token), arg0.expiry), arg0.from_amount), arg0.fill_amount), arg0.fee_rate), arg0.from_chain), arg0.to_chain);
        if (0x1::vector::length<u8>(&arg0.post_hook_hash) == 32) {
            0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::replace_bytes(&mut v0, arg0.post_hook_hash);
        };
        let v1 = x"0000000000000000000000000000000000000000000000000000000000000020";
        0x1::vector::append<u8>(&mut v1, 0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::abi::into_bytes(v0));
        0x2::hash::keccak256(&v1)
    }

    public(friend) fun verify_expiry(arg0: &Order, arg1: u64) {
        assert!(((arg1 / 1000) as u256) <= arg0.expiry, 9223372792769019905);
    }

    public(friend) fun verify_filler(arg0: &Order, arg1: address) {
        assert!(0x2::address::from_bytes(arg0.filler_to_address) == arg1, 9223372766999871499);
    }

    public(friend) fun verify_from_chain_is_sui(arg0: &Order, arg1: u256) {
        assert!(arg0.from_chain == arg1, 9223372814243987459);
    }

    public(friend) fun verify_from_token<T0>(arg0: &Order) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        assert!(0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1)) == 0x2::address::from_bytes(arg0.from_token), 9223372741230329871);
    }

    public(friend) fun verify_order_expired(arg0: &Order, arg1: address, arg2: u64) {
        if (0x2::address::from_bytes(arg0.filler_from_address) != arg1) {
            assert!(((arg2 / 1000) as u256) > arg0.expiry + 86400, 9223372913028628489);
        };
    }

    public(friend) fun verify_order_from_amount(arg0: &Order, arg1: u64) {
        assert!(arg0.from_amount == (arg1 as u256), 9223372861488758789);
    }

    public(friend) fun verify_signer(arg0: &Order, arg1: address) {
        assert!(0x2::address::from_bytes(arg0.from_address) == arg1, 9223372702575099911);
    }

    public(friend) fun verify_to_chain_is_sui(arg0: &Order, arg1: u256) {
        assert!(arg0.to_chain == arg1, 9223372835718823939);
    }

    // decompiled from Move bytecode v6
}

