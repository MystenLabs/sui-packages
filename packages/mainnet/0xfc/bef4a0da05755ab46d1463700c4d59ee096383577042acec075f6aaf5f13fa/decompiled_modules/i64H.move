module 0xfcbef4a0da05755ab46d1463700c4d59ee096383577042acec075f6aaf5f13fa::i64H {
    public fun add(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64 {
        lib_to_mate(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::add(mate_to_lib(arg0), mate_to_lib(arg1)))
    }

    public fun eq(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64) : bool {
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::eq(mate_to_lib(arg0), mate_to_lib(arg1))
    }

    public fun gt(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64) : bool {
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::gt(mate_to_lib(arg0), mate_to_lib(arg1))
    }

    public fun gte(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64) : bool {
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::gte(mate_to_lib(arg0), mate_to_lib(arg1))
    }

    public fun is_neg(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64) : bool {
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::is_neg(mate_to_lib(arg0))
    }

    public fun lt(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64) : bool {
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::lt(mate_to_lib(arg0), mate_to_lib(arg1))
    }

    public fun lte(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64) : bool {
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::lte(mate_to_lib(arg0), mate_to_lib(arg1))
    }

    public fun sub(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64 {
        lib_to_mate(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::sub(mate_to_lib(arg0), mate_to_lib(arg1)))
    }

    public fun lib_to_mate(arg0: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::I64) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::from_u64(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::as_u64(arg0))
    }

    public fun mate_to_lib(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::I64 {
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i64::from_u64(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::as_u64(arg0))
    }

    // decompiled from Move bytecode v6
}

