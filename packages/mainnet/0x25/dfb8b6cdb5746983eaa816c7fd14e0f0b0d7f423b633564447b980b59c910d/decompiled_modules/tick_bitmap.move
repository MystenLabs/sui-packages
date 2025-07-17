module 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::tick_bitmap {
    public fun cast_to_u8(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u8 {
        abort 0
    }

    public(friend) fun flip_tick(arg0: &mut 0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u32) {
        abort 0
    }

    fun get_immutable_tick_word(arg0: &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u256 {
        abort 0
    }

    fun get_mutable_tick_word(arg0: &mut 0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : &mut u256 {
        abort 0
    }

    public fun next_initialized_tick_within_one_word(arg0: &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u32, arg3: bool) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, bool) {
        abort 0
    }

    fun position(arg0: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) : (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, u8) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

