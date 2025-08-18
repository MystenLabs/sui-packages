module 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_verifier {
    struct Nonces has store {
        inner: 0x2::table::Table<address, u64>,
    }

    struct Message has copy, drop, store {
        pool: address,
        amount: u64,
        nonce: u64,
        sender: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Nonces {
        Nonces{inner: 0x2::table::new<address, u64>(arg0)}
    }

    public(friend) fun assert_can_buy(arg0: &mut Nonces, arg1: vector<u8>, arg2: 0x1::option::Option<vector<u8>>, arg3: address, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        if (0x1::vector::length<u8>(&arg1) == 0) {
            return
        };
        let v0 = 0x2::tx_context::sender(arg5);
        if (!0x2::table::contains<address, u64>(&arg0.inner, v0)) {
            0x2::table::add<address, u64>(&mut arg0.inner, v0, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.inner, v0);
        let v2 = Message{
            pool   : arg3,
            amount : arg4,
            nonce  : *v1,
            sender : v0,
        };
        *v1 = *v1 + 1;
        let v3 = 0x1::option::destroy_some<vector<u8>>(arg2);
        let v4 = 0x2::bcs::to_bytes<Message>(&v2);
        assert!(0x2::ed25519::ed25519_verify(&v3, &arg1, &v4), 27);
    }

    public(friend) fun next_nonce(arg0: &Nonces, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.inner, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.inner, arg1)
        }
    }

    // decompiled from Move bytecode v6
}

