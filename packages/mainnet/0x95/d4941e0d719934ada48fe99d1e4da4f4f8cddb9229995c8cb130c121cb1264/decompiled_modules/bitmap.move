module 0x95d4941e0d719934ada48fe99d1e4da4f4f8cddb9229995c8cb130c121cb1264::bitmap {
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

