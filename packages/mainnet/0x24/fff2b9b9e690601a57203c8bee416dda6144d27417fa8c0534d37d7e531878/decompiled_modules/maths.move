module 0x24fff2b9b9e690601a57203c8bee416dda6144d27417fa8c0534d37d7e531878::maths {
    public fun base_div(arg0: u64, arg1: u64) : u64 {
        arg0 * 0x24fff2b9b9e690601a57203c8bee416dda6144d27417fa8c0534d37d7e531878::constants::base_uint() / arg1
    }

    public fun base_mul(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 0x24fff2b9b9e690601a57203c8bee416dda6144d27417fa8c0534d37d7e531878::constants::base_uint()
    }

    // decompiled from Move bytecode v6
}

