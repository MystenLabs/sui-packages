module 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::math {
    public(friend) fun div(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::constants::float_scaling(), arg1)
    }

    public(friend) fun mul(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, arg1, 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::constants::float_scaling())
    }

    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public(friend) fun power_of_ten(arg0: u8) : u64 {
        0x1::u64::pow(10, arg0)
    }

    public(friend) fun scale_down(arg0: 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::I256, arg1: u64) : 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::I256 {
        0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::div(0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::mul(arg0, 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::from_u64(arg1)), 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::constants::float_scaling_i256())
    }

    public(friend) fun scale_up(arg0: u64, arg1: u64) : 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::I256 {
        0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::div(0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::mul(0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::from_u64(arg0), 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::constants::float_scaling_i256()), 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::from_u64(arg1))
    }

    // decompiled from Move bytecode v6
}

