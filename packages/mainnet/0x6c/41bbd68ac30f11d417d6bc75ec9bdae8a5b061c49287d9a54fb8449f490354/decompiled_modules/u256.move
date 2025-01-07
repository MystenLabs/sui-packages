module 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::u256 {
    public fun sqrt(arg0: u256) : u256 {
        let v0 = 0;
        if (arg0 > 3) {
            v0 = arg0;
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                v0 = v1;
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
        } else if (arg0 != 0) {
            v0 = 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

