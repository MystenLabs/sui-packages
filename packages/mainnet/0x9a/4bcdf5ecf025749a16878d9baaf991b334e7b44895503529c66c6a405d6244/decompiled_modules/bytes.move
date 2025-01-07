module 0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes {
    public fun to_bytes<T0: drop>(arg0: T0) : vector<u8> {
        0x1::bcs::to_bytes<T0>(&arg0)
    }

    public fun push_address(arg0: &mut vector<u8>, arg1: address) {
        push_no_reverse<address>(arg0, arg1);
    }

    fun push_no_reverse<T0: drop>(arg0: &mut vector<u8>, arg1: T0) {
        0x1::vector::append<u8>(arg0, 0x1::bcs::to_bytes<T0>(&arg1));
    }

    fun push_reverse<T0: drop>(arg0: &mut vector<u8>, arg1: T0) {
        let v0 = 0x1::bcs::to_bytes<T0>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(arg0, v0);
    }

    public fun push_u128_be(arg0: &mut vector<u8>, arg1: u128) {
        push_reverse<u128>(arg0, arg1);
    }

    public fun push_u16_be(arg0: &mut vector<u8>, arg1: u16) {
        push_reverse<u16>(arg0, arg1);
    }

    public fun push_u256_be(arg0: &mut vector<u8>, arg1: u256) {
        push_reverse<u256>(arg0, arg1);
    }

    public fun push_u32_be(arg0: &mut vector<u8>, arg1: u32) {
        push_reverse<u32>(arg0, arg1);
    }

    public fun push_u64_be(arg0: &mut vector<u8>, arg1: u64) {
        push_reverse<u64>(arg0, arg1);
    }

    public fun push_u8(arg0: &mut vector<u8>, arg1: u8) {
        0x1::vector::push_back<u8>(arg0, arg1);
    }

    public fun push_vector<T0: drop>(arg0: &mut vector<u8>, arg1: vector<T0>) {
        push_no_reverse<vector<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

