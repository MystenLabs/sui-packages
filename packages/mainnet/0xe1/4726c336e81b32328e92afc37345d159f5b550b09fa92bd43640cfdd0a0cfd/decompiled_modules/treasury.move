module 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::treasury {
    struct CollectFee<phantom T0> has copy, drop {
        memo: 0x1::string::String,
        coin_type: 0x1::string::String,
        amount: u64,
    }

    struct ClaimFee<phantom T0> has copy, drop {
        coin_type: 0x1::string::String,
        amount: u64,
    }

    public(friend) fun emit_claim_fee<T0, T1>(arg0: u64) {
        let v0 = ClaimFee<T1>{
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount    : arg0,
        };
        0x2::event::emit<ClaimFee<T1>>(v0);
    }

    public(friend) fun emit_collect_fee<T0, T1>(arg0: 0x1::string::String, arg1: u64) {
        let v0 = CollectFee<T1>{
            memo      : arg0,
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount    : arg1,
        };
        0x2::event::emit<CollectFee<T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

