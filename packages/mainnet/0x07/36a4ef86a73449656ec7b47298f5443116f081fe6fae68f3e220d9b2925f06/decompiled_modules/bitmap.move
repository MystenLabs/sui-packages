module 0x736a4ef86a73449656ec7b47298f5443116f081fe6fae68f3e220d9b2925f06::bitmap {
    struct Bitmap has copy, drop, store {
        bitmap: u128,
    }

    public fun empty() : Bitmap {
        Bitmap{bitmap: 0}
    }

    public fun and(arg0: &Bitmap, arg1: &Bitmap) : Bitmap {
        Bitmap{bitmap: arg0.bitmap & arg1.bitmap}
    }

    public fun count_ones(arg0: &Bitmap) : u8 {
        let v0 = 0;
        let v1 = 1;
        let v2 = 0;
        while (v2 < 128) {
            if (arg0.bitmap & v1 > 0) {
                v0 = v0 + 1;
            };
            v1 = v1 << 1;
            v2 = v2 + 1;
        };
        v0
    }

    public fun disable(arg0: &mut Bitmap, arg1: u8) {
        arg0.bitmap = arg0.bitmap & (1 << arg1 ^ 340282366920938463463374607431768211455);
    }

    public fun enable(arg0: &mut Bitmap, arg1: u8) {
        arg0.bitmap = arg0.bitmap | 1 << arg1;
    }

    public fun get(arg0: &Bitmap, arg1: u8) : bool {
        arg0.bitmap & 1 << arg1 > 0
    }

    // decompiled from Move bytecode v6
}

