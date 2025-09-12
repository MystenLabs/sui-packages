module 0xb269f062e8f7fd2bd653a79405dea7c48cb0bf62b11e33c939637d52b1560a65::utils {
    public fun find_active_id_idx(arg0: u32, arg1: vector<u32>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(&arg1)) {
            if (*0x1::vector::borrow<u32>(&arg1, v0) == arg0) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 13906834294602465281
    }

    public fun validate_active_id_slippage<T0, T1>(arg0: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::Pool<T0, T1>, arg1: u32, arg2: u32) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::active_id<T0, T1>(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1)))) <= arg2, 13906834247357825025);
    }

    // decompiled from Move bytecode v6
}

