module 0xc4b09d27ec7f9a5c297f64c73d2e8ef822918d18a1930956b30128ac7396a239::config {
    public fun contract_version() : u64 {
        1
    }

    public fun identities() : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &mut v0;
        0x1::vector::push_back<address>(v1, navi_storage());
        0x1::vector::push_back<address>(v1, navi_price_oracle());
        0x1::vector::push_back<address>(v1, navi_incentive_v2());
        0x1::vector::push_back<address>(v1, navi_incentive_v3());
        0x1::vector::push_back<address>(v1, suilend_lending_market());
        0x1::vector::push_back<address>(v1, scallop_market());
        0x1::vector::push_back<address>(v1, scallop_version());
        0x1::vector::push_back<address>(v1, scallop_x_oracle());
        v0
    }

    public fun navi_incentive_v2() : address {
        @0xf87a8acb8b81d14307894d12595541a73f19933f88e1326d5be349c7a6f7559c
    }

    public fun navi_incentive_v3() : address {
        @0x62982dad27fb10bb314b3384d5de8d2ac2d72ab2dbeae5d801dbdb9efa816c80
    }

    public fun navi_price_oracle() : address {
        @0x1568865ed9a0b5ec414220e8f79b3d04c77acc82358f6e5ae4635687392ffbef
    }

    public fun navi_storage() : address {
        @0xbb4e2f4b6205c2e2a2db47aeb4f830796ec7c005f88537ee775986639bc442fe
    }

    public fun protocol_navi() : u8 {
        0
    }

    public fun protocol_scallop() : u8 {
        2
    }

    public fun protocol_suilend() : u8 {
        1
    }

    public fun scallop_coin_decimals_registry() : address {
        @0x200abe9bf19751cc566ae35aa58e2b7e4ff688fc1130f8d8909ea09bc137d668
    }

    public fun scallop_market() : address {
        @0xa757975255146dc9686aa823b7838b507f315d704f428cbadad2f4ea061939d9
    }

    public fun scallop_version() : address {
        @0x7871c4b3c847a0f674510d4978d5cf6f960452795e8ff6f189fd2088a3f6ac7
    }

    public fun scallop_x_oracle() : address {
        @0x93d5bf0936b71eb27255941e532fac33b5a5c7759e377b4923af0a1359ad494f
    }

    public fun suilend_lending_market() : address {
        @0x84030d26d85eaa7035084a057f2f11f701b7e2e4eda87551becbc7c97505ece1
    }

    // decompiled from Move bytecode v7
}

