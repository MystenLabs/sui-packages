module 0x19a65a80e335048057d10462b4d75ae31ac414fc2a0880cbf0eb4aac57d64a08::bridge {
    public fun active_amount(arg0: bool, arg1: u64) : u64 {
        if (arg0) {
            arg1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

