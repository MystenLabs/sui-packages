module 0x50411c27cba50feb70a6cc1c04345370dde1ed0f8563d565c09304e62bf462e1::percentage_math {
    fun percent_div(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 1);
        let v0 = arg1 / 2;
        assert!(arg0 <= (0x2::address::max() - v0) / 10000, 1201);
        0x50411c27cba50feb70a6cc1c04345370dde1ed0f8563d565c09304e62bf462e1::safe_math::div(0x50411c27cba50feb70a6cc1c04345370dde1ed0f8563d565c09304e62bf462e1::safe_math::add(0x50411c27cba50feb70a6cc1c04345370dde1ed0f8563d565c09304e62bf462e1::safe_math::mul(arg0, 10000), v0), arg1)
    }

    public fun percent_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= (0x2::address::max() - 5000) / arg1, 1201);
        0x50411c27cba50feb70a6cc1c04345370dde1ed0f8563d565c09304e62bf462e1::safe_math::div(0x50411c27cba50feb70a6cc1c04345370dde1ed0f8563d565c09304e62bf462e1::safe_math::add(0x50411c27cba50feb70a6cc1c04345370dde1ed0f8563d565c09304e62bf462e1::safe_math::mul(arg0, arg1), 5000), 10000)
    }

    // decompiled from Move bytecode v6
}

