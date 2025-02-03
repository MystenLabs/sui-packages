module 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::transfer_config {
    struct TransferConfigRule has drop {
        dummy_field: bool,
    }

    struct TransferConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        transfer_flag: u64,
    }

    public(friend) fun add<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferConfigRule{dummy_field: false};
        let v1 = TransferConfig<T0>{
            id            : 0x2::object::new(arg2),
            transfer_flag : 1,
        };
        0x2::token::add_rule_config<T0, TransferConfigRule, TransferConfig<T0>>(v0, arg0, arg1, v1, arg2);
    }

    public(friend) fun get_transfer_flag<T0>(arg0: &0x2::token::TokenPolicy<T0>) : u64 {
        let v0 = TransferConfigRule{dummy_field: false};
        0x2::token::rule_config<T0, TransferConfigRule, TransferConfig<T0>>(v0, arg0).transfer_flag
    }

    public(friend) fun update_transfer_flag<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64) {
        let v0 = TransferConfigRule{dummy_field: false};
        let v1 = 0x2::token::rule_config_mut<T0, TransferConfigRule, TransferConfig<T0>>(v0, arg0, arg1);
        let v2 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else {
            arg2 == 3
        };
        assert!(v2, 9223372221538369537);
        v1.transfer_flag = arg2;
    }

    // decompiled from Move bytecode v6
}

