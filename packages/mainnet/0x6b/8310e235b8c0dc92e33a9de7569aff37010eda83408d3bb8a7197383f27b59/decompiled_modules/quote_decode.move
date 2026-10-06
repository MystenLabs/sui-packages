module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::quote_decode {
    public fun bluefin_amount_out(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::SwapResult) : u64 {
        let v0 = 0x1::bcs::to_bytes<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::SwapResult>(arg0);
        read_u64_le(&v0, 18)
    }

    public fun cetus_amount_out(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult) : u64 {
        let v0 = 0x1::bcs::to_bytes<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult>(arg0);
        read_u64_le(&v0, 8)
    }

    fun read_u128_le(arg0: &vector<u8>, arg1: u64) : u128 {
        assert!(0x1::vector::length<u8>(arg0) >= arg1 + 16, 950);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u128) << (v1 as u8) * 8;
            v1 = v1 + 1;
        };
        v0
    }

    fun read_u64_le(arg0: &vector<u8>, arg1: u64) : u64 {
        assert!(0x1::vector::length<u8>(arg0) >= arg1 + 8, 950);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64) << (v1 as u8) * 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun turbos_amount_out(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState) : u64 {
        let v0 = 0x1::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>(arg0);
        let v1 = read_u128_le(&v0, 48);
        assert!(v1 <= 18446744073709551615, 951);
        (v1 as u64)
    }

    public fun u64_to_u128(arg0: u64) : u128 {
        (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

