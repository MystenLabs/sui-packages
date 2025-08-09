module 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::whitelisted_tokens {
    struct WhitelistedToken {
        voter: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
    }

    public(friend) fun create<T0>(arg0: 0x2::object::ID) : WhitelistedToken {
        WhitelistedToken{
            voter : arg0,
            token : 0x1::type_name::get<T0>(),
        }
    }

    public fun validate<T0>(arg0: WhitelistedToken, arg1: 0x2::object::ID) {
        let WhitelistedToken {
            voter : v0,
            token : v1,
        } = arg0;
        assert!(v0 == arg1, 9223372260193075199);
        if (v1 != 0x1::type_name::get<T0>()) {
            abort 9223372268783140867
        };
    }

    // decompiled from Move bytecode v6
}

