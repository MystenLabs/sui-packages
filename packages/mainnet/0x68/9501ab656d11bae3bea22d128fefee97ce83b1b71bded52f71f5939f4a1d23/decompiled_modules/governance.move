module 0x689501ab656d11bae3bea22d128fefee97ce83b1b71bded52f71f5939f4a1d23::governance {
    struct GovernanceAction has copy, drop {
        message: 0x1::string::String,
        coin_type: 0x1::ascii::String,
    }

    public fun govern<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin::Coin<T0>, arg2: 0x1::string::String) {
        assert!(0x2::coin::value<T0>(arg1) == 0x2::coin::total_supply<T0>(arg0), 0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x1::ascii::into_bytes(v0) == b"f247780882cff3c36023fdc9f685effa678d82f83da3d2388fe85bb7c695c185::govex::GOVEX", 1);
        let v1 = GovernanceAction{
            message   : arg2,
            coin_type : v0,
        };
        0x2::event::emit<GovernanceAction>(v1);
    }

    // decompiled from Move bytecode v6
}

