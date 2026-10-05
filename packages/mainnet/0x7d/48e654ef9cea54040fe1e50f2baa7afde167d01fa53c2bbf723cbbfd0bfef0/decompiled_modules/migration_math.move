module 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::migration_math {
    public(friend) fun is_seedable(arg0: u128) : bool {
        arg0 >= 4295048016 * 2 && arg0 <= 79226673515401279992447579055 / 2
    }

    public(friend) fun sqrt_price_x64(arg0: u64, arg1: u64, arg2: bool) : u128 {
        let (v0, v1) = if (arg2) {
            (arg1, arg0)
        } else {
            (arg0, arg1)
        };
        let v2 = 0;
        let v3 = 79228162514264337593543950336;
        while (v2 + 1 < v3) {
            v3 = (v2 + v3) / 2;
            if (v3 * v3 <= ((v0 as u256) << 128) / (v1 as u256)) {
                v2 = v3;
                continue
            };
        };
        (v2 as u128)
    }

    // decompiled from Move bytecode v7
}

