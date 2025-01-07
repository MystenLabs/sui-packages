module 0x73f8aee18b39a588ed5e8883e57e606afe63577af40f57241bdd89fd79254ba4::maths {
    public fun base_div(arg0: u64, arg1: u64) : u64 {
        arg0 * 0x73f8aee18b39a588ed5e8883e57e606afe63577af40f57241bdd89fd79254ba4::constants::base_uint() / arg1
    }

    public fun base_mul(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 0x73f8aee18b39a588ed5e8883e57e606afe63577af40f57241bdd89fd79254ba4::constants::base_uint()
    }

    // decompiled from Move bytecode v6
}

