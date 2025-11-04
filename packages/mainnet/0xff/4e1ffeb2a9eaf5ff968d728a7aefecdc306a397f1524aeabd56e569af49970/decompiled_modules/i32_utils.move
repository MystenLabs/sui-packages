module 0xff4e1ffeb2a9eaf5ff968d728a7aefecdc306a397f1524aeabd56e569af49970::i32_utils {
    public(friend) fun lib_to_mate(arg0: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32 {
        0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::as_u32(arg0))
    }

    public(friend) fun mate_to_lib(arg0: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32 {
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(arg0))
    }

    // decompiled from Move bytecode v6
}

