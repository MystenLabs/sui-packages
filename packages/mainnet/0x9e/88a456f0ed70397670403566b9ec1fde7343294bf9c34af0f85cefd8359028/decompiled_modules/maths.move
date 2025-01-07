module 0x9e88a456f0ed70397670403566b9ec1fde7343294bf9c34af0f85cefd8359028::maths {
    public fun base_div(arg0: u64, arg1: u64) : u64 {
        arg0 * 0x9e88a456f0ed70397670403566b9ec1fde7343294bf9c34af0f85cefd8359028::constants::base_uint() / arg1
    }

    public fun base_mul(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 0x9e88a456f0ed70397670403566b9ec1fde7343294bf9c34af0f85cefd8359028::constants::base_uint()
    }

    // decompiled from Move bytecode v6
}

