module 0xfeecbb29272d34b78c402b894ea63b48cff4a717dafc96df8aa205edca89610c::buffer {
    struct Buffer<T0> {
        expected_size: u64,
        contents: vector<T0>,
    }

    public fun append<T0>(arg0: &mut Buffer<T0>, arg1: vector<T0>) {
        0x1::vector::append<T0>(&mut arg0.contents, arg1);
    }

    public fun new<T0>(arg0: u64) : Buffer<T0> {
        Buffer<T0>{
            expected_size : arg0,
            contents      : 0x1::vector::empty<T0>(),
        }
    }

    public fun unwrap<T0>(arg0: Buffer<T0>) : vector<T0> {
        let Buffer {
            expected_size : v0,
            contents      : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x1::vector::length<T0>(&v2) == v0, 0);
        v2
    }

    // decompiled from Move bytecode v6
}

