module 0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::seal_policies {
    fun approve_internal(arg0: &0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::member_cap::MemberCap, arg1: vector<u8>, arg2: &0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::channel::Channel) : bool {
        if (!is_prefix(0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::channel::namespace(arg2), arg1)) {
            return false
        };
        0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::channel::is_member(arg2, arg0)
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

    entry fun seal_approve(arg0: vector<u8>, arg1: &0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::channel::Channel, arg2: &0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::member_cap::MemberCap, arg3: &0x2::tx_context::TxContext) {
        assert!(approve_internal(arg2, arg0, arg1), 0);
    }

    // decompiled from Move bytecode v6
}

