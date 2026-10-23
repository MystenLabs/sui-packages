module 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::selector {
    public fun chosen<T0: copy + drop>(arg0: &vector<T0>, arg1: &vector<bool>) : T0 {
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

