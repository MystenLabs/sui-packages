module 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_token {
    struct TransferToken<phantom T0> has key {
        id: 0x2::object::UID,
        receiver: address,
    }

    struct TransferTokenRule has drop {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : TransferToken<T0> {
        TransferToken<T0>{
            id       : 0x2::object::new(arg2),
            receiver : arg1,
        }
    }

    public fun confirm<T0: store + key, T1>(arg0: T0, arg1: TransferToken<T0>, arg2: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::RequestBody<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>) {
        let TransferToken {
            id       : v0,
            receiver : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(arg0, v1);
        let v2 = TransferTokenRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::add_receipt<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, TransferTokenRule>(arg2, &v2);
    }

    public fun create_and_transfer<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new<T0>(arg0, arg1, arg3);
        0x2::transfer::transfer<TransferToken<T0>>(v0, arg2);
        0x2::object::id<TransferToken<T0>>(&v0)
    }

    public fun drop<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::drop_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, TransferTokenRule>(arg0, arg1);
    }

    public entry fun enforce<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, TransferTokenRule>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

