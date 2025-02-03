module 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::utils {
    public fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

