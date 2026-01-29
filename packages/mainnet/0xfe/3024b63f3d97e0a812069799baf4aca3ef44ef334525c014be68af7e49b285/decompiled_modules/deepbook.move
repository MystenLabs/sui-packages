module 0xfe3024b63f3d97e0a812069799baf4aca3ef44ef334525c014be68af7e49b285::deepbook {
    public fun adjust_input_amount(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    // decompiled from Move bytecode v6
}

