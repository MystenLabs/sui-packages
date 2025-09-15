module 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32_utils {
    public fun add(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        lib_to_mate(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::add(mate_to_lib(arg0), mate_to_lib(arg1)))
    }

    public fun eq(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::eq(mate_to_lib(arg0), mate_to_lib(arg1))
    }

    public fun gt(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::gt(mate_to_lib(arg0), mate_to_lib(arg1))
    }

    public fun gte(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::gte(mate_to_lib(arg0), mate_to_lib(arg1))
    }

    public fun is_neg(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::is_neg(mate_to_lib(arg0))
    }

    public fun lt(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::lt(mate_to_lib(arg0), mate_to_lib(arg1))
    }

    public fun lte(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::lte(mate_to_lib(arg0), mate_to_lib(arg1))
    }

    public fun sub(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        lib_to_mate(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::sub(mate_to_lib(arg0), mate_to_lib(arg1)))
    }

    public fun lib_to_mate(arg0: 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::I32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::as_u32(arg0))
    }

    public fun mate_to_lib(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::I32 {
        0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::from_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg0))
    }

    // decompiled from Move bytecode v6
}

