module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::transfer_token {
    struct TransferToken<phantom T0> has key {
        id: 0x2::object::UID,
        receiver: address,
    }

    struct TransferTokenRule has drop {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : TransferToken<T0> {
        TransferToken<T0>{
            id       : 0x2::object::new(arg2),
            receiver : arg1,
        }
    }

    public fun confirm<T0: store + key, T1>(arg0: T0, arg1: TransferToken<T0>, arg2: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::RequestBody<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>>) {
        let TransferToken {
            id       : v0,
            receiver : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(arg0, v1);
        let v2 = TransferTokenRule{dummy_field: false};
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::add_receipt<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>, TransferTokenRule>(arg2, &v2);
    }

    public fun create_and_transfer<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new<T0>(arg0, arg1, arg3);
        0x2::transfer::transfer<TransferToken<T0>>(v0, arg2);
        0x2::object::id<TransferToken<T0>>(&v0)
    }

    public fun drop<T0, T1>(arg0: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::Policy<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>>, arg1: &0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::PolicyCap) {
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::drop_rule_no_state<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>, TransferTokenRule>(arg0, arg1);
    }

    public fun enforce<T0, T1>(arg0: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::Policy<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>>, arg1: &0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::PolicyCap) {
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::enforce_rule_no_state<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>, TransferTokenRule>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

