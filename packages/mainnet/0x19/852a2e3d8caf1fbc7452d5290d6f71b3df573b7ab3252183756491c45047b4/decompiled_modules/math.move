module 0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

