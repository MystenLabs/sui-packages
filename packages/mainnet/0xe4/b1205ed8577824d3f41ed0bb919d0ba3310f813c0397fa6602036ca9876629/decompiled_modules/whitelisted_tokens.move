module 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::whitelisted_tokens {
    struct WhitelistedTokenPair {
        voter: 0x2::object::ID,
        token0: 0x1::type_name::TypeName,
        token1: 0x1::type_name::TypeName,
    }

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

    public(friend) fun create_pair<T0, T1>(arg0: 0x2::object::ID) : WhitelistedTokenPair {
        WhitelistedTokenPair{
            voter  : arg0,
            token0 : 0x1::type_name::get<T0>(),
            token1 : 0x1::type_name::get<T1>(),
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

    public fun validate_pair<T0, T1>(arg0: WhitelistedTokenPair, arg1: 0x2::object::ID) {
        let WhitelistedTokenPair {
            voter  : v0,
            token0 : v1,
            token1 : v2,
        } = arg0;
        assert!(v0 == arg1, 9223372204358500351);
        let v3 = 0x1::type_name::get<T0>();
        if (v1 != v3 && v2 != v3) {
            abort 9223372212948434945
        };
        let v4 = 0x1::type_name::get<T1>();
        if (v1 != v4 && v2 != v4) {
            abort 9223372230128304129
        };
    }

    // decompiled from Move bytecode v6
}

