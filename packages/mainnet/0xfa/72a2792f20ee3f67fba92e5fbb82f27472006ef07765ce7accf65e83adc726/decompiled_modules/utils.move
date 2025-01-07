module 0xfa72a2792f20ee3f67fba92e5fbb82f27472006ef07765ce7accf65e83adc726::utils {
    public fun get_reward_level(arg0: vector<u8>, arg1: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(&arg1);
        assert!(v1 == 0x1::vector::length<u8>(&arg0), 0);
        while (v0 < v1) {
            if (0x1::vector::borrow<u8>(&arg1, v0) != 0x1::vector::borrow<u8>(&arg0, v0)) {
                break
            };
            v0 = v0 + 1;
        };
        v0
    }

    public fun get_value_with_rate(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    public fun to_miliseconds(arg0: u64) : u64 {
        arg0 * 1000
    }

    // decompiled from Move bytecode v6
}

