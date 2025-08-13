module 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::utils {
    public fun assert_bool(arg0: bool, arg1: bool, arg2: u64) {
        assert!(arg0 == arg1, arg2);
    }

    public fun assert_u32(arg0: u32, arg1: u32, arg2: u64) {
        assert!(arg0 == arg1, arg2);
    }

    public fun assert_u64(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 == arg1, arg2);
    }

    public fun bound_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(arg0, 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::tick_math::min_tick()) == 0) {
            0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::tick_math::min_tick()
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(arg0, 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::tick_math::max_tick()) == 2) {
            0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::tick_math::max_tick()
        } else {
            arg0
        }
    }

    public fun round_tick_to_spacing(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1 - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) % arg1))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) % arg1))
        }
    }

    // decompiled from Move bytecode v6
}

