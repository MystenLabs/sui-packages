module 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::seal_policies {
    fun approve_internal(arg0: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap, arg1: vector<u8>, arg2: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::channel::Channel) : bool {
        if (!is_prefix(0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::channel::namespace(arg2), arg1)) {
            return false
        };
        0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::channel::is_member(arg2, arg0)
    }

    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg0) > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) != *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::channel::Channel, arg2: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap, arg3: &0x2::tx_context::TxContext) {
        assert!(approve_internal(arg2, arg0, arg1), 0);
    }

    // decompiled from Move bytecode v6
}

