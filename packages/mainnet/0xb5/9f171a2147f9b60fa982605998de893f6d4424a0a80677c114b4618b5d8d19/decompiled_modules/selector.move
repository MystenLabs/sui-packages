module 0xb59f171a2147f9b60fa982605998de893f6d4424a0a80677c114b4618b5d8d19::selector {
    public fun chosen<T0: copy + drop>(arg0: &vector<T0>, arg1: &vector<bool>) : T0 {
        assert!(0x1::vector::length<T0>(arg0) == 0x1::vector::length<bool>(arg1), 415);
        let v0 = 0;
        while (v0 < 0x1::vector::length<bool>(arg1)) {
            if (*0x1::vector::borrow<bool>(arg1, v0)) {
                return *0x1::vector::borrow<T0>(arg0, v0)
            };
            v0 = v0 + 1;
        };
        abort 413
    }

    public fun new() : vector<bool> {
        vector[]
    }

    public fun take_first(arg0: &mut vector<bool>, arg1: bool) : bool {
        let v0 = if (arg1) {
            let v1 = true;
            !0x1::vector::contains<bool>(arg0, &v1)
        } else {
            false
        };
        0x1::vector::push_back<bool>(arg0, v0);
        v0
    }

    // decompiled from Move bytecode v7
}

