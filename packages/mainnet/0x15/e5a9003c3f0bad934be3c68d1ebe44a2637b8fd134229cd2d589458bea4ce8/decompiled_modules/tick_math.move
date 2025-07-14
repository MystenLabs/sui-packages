module 0x5d74b5f62f1d78bd0a57d9515b7837090c95564f31873528cfa0b2e01ab50869::tick_math {
    fun compress(arg0: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32 {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::div(arg0, arg1);
        let v1 = v0;
        if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::is_neg(arg0) && 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::mod(arg0, arg1) != 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::zero()) {
            v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(v0, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(1));
        };
        v1
    }

    public(friend) fun next_initialized_tick(arg0: &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg3: bool, arg4: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg5: u256) : (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, u256) {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(1);
        let (v1, v2, v3) = if (arg3) {
            let (v4, v5) = position(compress(arg1, arg2));
            let v6 = v4;
            let v7 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::eq(v4, arg4)) {
                arg5
            } else {
                *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x5d74b5f62f1d78bd0a57d9515b7837090c95564f31873528cfa0b2e01ab50869::i32_utils::lib_to_mate(v4))
            };
            let v8 = v7;
            let v9 = v7 & (2 << v5) - 1;
            while (v9 == 0) {
                let v10 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(v6, v0);
                v6 = v10;
                let v11 = *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x5d74b5f62f1d78bd0a57d9515b7837090c95564f31873528cfa0b2e01ab50869::i32_utils::lib_to_mate(v10));
                v8 = v11;
                v9 = v11;
            };
            (v6, v8, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::bit_math::most_significant_bit(v9))
        } else {
            let (v12, v13) = position(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::add(compress(arg1, arg2), v0));
            let v14 = v12;
            let v15 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::eq(v12, arg4)) {
                arg5
            } else {
                *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x5d74b5f62f1d78bd0a57d9515b7837090c95564f31873528cfa0b2e01ab50869::i32_utils::lib_to_mate(v12))
            };
            let v16 = v15;
            let v17 = v15 & ((1 << v13) - 1 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935);
            while (v17 == 0) {
                let v18 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::add(v14, v0);
                v14 = v18;
                let v19 = *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x5d74b5f62f1d78bd0a57d9515b7837090c95564f31873528cfa0b2e01ab50869::i32_utils::lib_to_mate(v18));
                v16 = v19;
                v17 = v19;
            };
            (v14, v16, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::bit_math::least_significant_bit(v17))
        };
        (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::mul(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::add(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::shl(v1, 8), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from((v3 as u32))), arg2), v1, v2)
    }

    fun position(arg0: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) : (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, u8) {
        (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::shr(arg0, 8), ((0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::as_u32(arg0) & 255) as u8))
    }

    // decompiled from Move bytecode v6
}

