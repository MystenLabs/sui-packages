module 0xf8dc156b0d47eab3a54e7df9337880dd4894851ec28be509dc4d33a3a8a4f52c::party_demo {
    struct Capability has store, key {
        id: 0x2::object::UID,
        level: u8,
        usage_count: u64,
        max_uses: u64,
        recent_ops: vector<0x1::string::String>,
    }

    public fun issue_capability(arg0: u8, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1 && arg0 <= 3, 2);
        let v0 = Capability{
            id          : 0x2::object::new(arg3),
            level       : arg0,
            usage_count : 0,
            max_uses    : arg1,
            recent_ops  : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::public_party_transfer<Capability>(v0, 0x2::party::single_owner(arg2));
    }

    public fun transfer_capability(arg0: Capability, arg1: address) {
        0x2::transfer::public_party_transfer<Capability>(arg0, 0x2::party::single_owner(arg1));
    }

    public fun use_capability(arg0: &mut Capability, arg1: 0x1::string::String) {
        assert!(arg0.max_uses == 0 || arg0.usage_count < arg0.max_uses, 1);
        arg0.usage_count = arg0.usage_count + 1;
        0x1::vector::push_back<0x1::string::String>(&mut arg0.recent_ops, arg1);
        if (0x1::vector::length<0x1::string::String>(&arg0.recent_ops) > 10) {
            0x1::vector::remove<0x1::string::String>(&mut arg0.recent_ops, 0);
        };
    }

    // decompiled from Move bytecode v6
}

