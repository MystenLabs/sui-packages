module 0xce3520e9680a552ebc75760dafe4cb47b5304984c12e8b6f1e2c329657aa8ea7::dep {
    public fun foo(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    // decompiled from Move bytecode v6
}

