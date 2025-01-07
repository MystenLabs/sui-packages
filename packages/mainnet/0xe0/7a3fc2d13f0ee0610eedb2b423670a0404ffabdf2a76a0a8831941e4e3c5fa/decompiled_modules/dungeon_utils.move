module 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_utils {
    public fun calcRarity(arg0: vector<u8>) : (0x1::string::String, u64, u64, 0x1::string::String) {
        let v0 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::drand_lib::safe_selection(10000, &arg0);
        let v1 = vector[6000, 9000, 9770, 9970];
        let v2 = vector[6000, 9000, 9770, 9970];
        let v3 = vector[6000, 9000, 9770, 9970];
        let v4 = vector[6000, 9000, 9770, 9970];
        if (v0 < *0x1::vector::borrow<u64>(&v1, 0)) {
            return (0x1::string::utf8(b"N"), v0, 0, 0x1::string::utf8(b"FFFFFF"))
        };
        if (v0 < *0x1::vector::borrow<u64>(&v2, 1)) {
            return (0x1::string::utf8(b"R"), v0, 1, 0x1::string::utf8(b"1A73E8"))
        };
        if (v0 < *0x1::vector::borrow<u64>(&v3, 2)) {
            return (0x1::string::utf8(b"SR"), v0, 2, 0x1::string::utf8(b"F28800"))
        };
        if (v0 < *0x1::vector::borrow<u64>(&v4, 3)) {
            return (0x1::string::utf8(b"SSR"), v0, 3, 0x1::string::utf8(b"6CD206"))
        };
        (0x1::string::utf8(b"UR"), v0, 4, 0x1::string::utf8(b"E50C0C"))
    }

    public fun calcRating(arg0: u64, arg1: vector<u8>) : u64 {
        let v0 = u64_to_ascii(arg0);
        let v1 = 0x2::hmac::hmac_sha3_256(&arg1, &v0);
        let v2 = vector[6000, 9000, 9770, 9970];
        let v3 = vector[6000, 9000, 9770, 9970];
        let v4 = vector[6000, 9000, 9770, 9970];
        let v5 = vector[6000, 9000, 9770, 9970];
        if (arg0 < *0x1::vector::borrow<u64>(&v2, 0)) {
            return 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::drand_lib::safe_selection(1800, &v1) + 1000
        };
        if (arg0 < *0x1::vector::borrow<u64>(&v3, 1)) {
            return 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::drand_lib::safe_selection(1000, &v1) + 4000
        };
        if (arg0 < *0x1::vector::borrow<u64>(&v4, 2)) {
            return 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::drand_lib::safe_selection(1000, &v1) + 6000
        };
        if (arg0 < *0x1::vector::borrow<u64>(&v5, 3)) {
            return 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::drand_lib::safe_selection(500, &v1) + 8000
        };
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::drand_lib::safe_selection(500, &v1) + 9500
    }

    public fun genreataColor(arg0: u64, arg1: vector<u8>, arg2: vector<u8>) : (0x1::string::String, 0x1::string::String, 0x1::string::String) {
        let v0 = makeRandomRGB(arg1, arg2, b"r_m");
        let v1 = makeRandomRGB(arg1, arg2, b"g_m");
        let v2 = makeRandomRGB(arg1, arg2, b"b_m");
        if (arg0 == 0) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueP(v0, 47), normalizeRGBValueP(v1, 33), normalizeRGBValueP(v2, 27)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 1) {
            return (rgbToHex(v0, v1, v2), rgbToHex(makeRandomRGB(arg1, arg2, b"r_s"), makeRandomRGB(arg1, arg2, b"g_s"), makeRandomRGB(arg1, arg2, b"b_s")), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 2) {
            return (rgbToHex(v0, v1, v2), rgbToHex(makeRandomRGB(arg1, arg2, b"r_s"), makeRandomRGB(arg1, arg2, b"g_s"), makeRandomRGB(arg1, arg2, b"b_s")), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 3) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueP(v0, 26), normalizeRGBValueP(v1, 14), normalizeRGBValueP(v2, 10)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 4) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueN(v0, 28), normalizeRGBValueN(v1, 38), normalizeRGBValueN(v2, 75)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 5) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueN(v0, 10), normalizeRGBValueP(v1, 24), normalizeRGBValueP(v2, 49)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 6) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueP(v0, 47), normalizeRGBValueP(v1, 33), normalizeRGBValueP(v2, 27)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 7) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueN(v0, 25), normalizeRGBValueN(v1, 45), normalizeRGBValueN(v2, 45)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 8) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueN(v0, 28), normalizeRGBValueN(v1, 125), normalizeRGBValueN(v2, 84)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 9) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueP(v0, 41), normalizeRGBValueP(v1, 42), normalizeRGBValueP(v2, 9)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 10) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueP(v0, 42), normalizeRGBValueP(v1, 56), normalizeRGBValueP(v2, 68)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 11) {
            return (rgbToHex(v0, v1, v2), rgbToHex(makeRandomRGB(arg1, arg2, b"r_s"), makeRandomRGB(arg1, arg2, b"g_s"), makeRandomRGB(arg1, arg2, b"b_s")), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 12) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueP(v0, 12), normalizeRGBValueP(v1, 50), normalizeRGBValueN(v2, 3)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 13) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueP(v0, 42), normalizeRGBValueP(v1, 56), normalizeRGBValueP(v2, 68)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        if (arg0 == 14) {
            return (rgbToHex(v0, v1, v2), rgbToHex(normalizeRGBValueN(v0, 136), normalizeRGBValueN(v1, 24), normalizeRGBValueN(v2, 98)), rgbToHex(255 - v0, 255 - v1, 255 - v2))
        };
        (rgbToHex(v0, v1, v2), rgbToHex(makeRandomRGB(arg1, arg2, b"r_s"), makeRandomRGB(arg1, arg2, b"g_s"), makeRandomRGB(arg1, arg2, b"b_s")), rgbToHex(255 - v0, 255 - v1, 255 - v2))
    }

    public fun getCavesProfitInSec(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 * 100 / 36
    }

    public fun getLevelUpFee(arg0: u64) : u64 {
        let v0 = vector[450000, 486000, 524880, 566870, 612220, 661198, 714093, 771221, 832919, 899552, 971516, 1049238, 1133177, 1223831, 1321737, 1427476, 1541674, 1665008, 1798209, 1942065, 2097431, 2265225, 2446443, 2642159, 2853531, 3081814, 3328359, 3594628, 3882198, 4192774];
        *0x1::vector::borrow<u64>(&v0, arg0) * 10000
    }

    public fun makeRandomRGB(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        randomColor(arg0, &v0)
    }

    fun normalizeRGBValueN(arg0: u64, arg1: u64) : u64 {
        0x2::math::min(arg0 + arg1, 255)
    }

    fun normalizeRGBValueP(arg0: u64, arg1: u64) : u64 {
        0x2::math::min(0x2::math::max(arg0, arg1) - arg1, 255)
    }

    public fun pow(arg0: u64, arg1: u64) : u256 {
        let v0 = 1;
        let v1 = (arg0 as u256);
        while (arg1 > 0) {
            if (arg1 % 2 == 1) {
                let v2 = v1 * v0;
                v0 = (v2 as u256);
            };
            let v3 = v1 * v1;
            v1 = (v3 as u256);
            arg1 = arg1 / 2;
        };
        v0
    }

    public fun randomColor(arg0: vector<u8>, arg1: &vector<u8>) : u64 {
        let v0 = 0x2::hmac::hmac_sha3_256(&arg0, arg1);
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::drand_lib::safe_selection(255, &v0)
    }

    public fun rgbToHex(arg0: u64, arg1: u64, arg2: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, (arg0 as u8));
        0x1::vector::push_back<u8>(&mut v1, (arg1 as u8));
        0x1::vector::push_back<u8>(&mut v1, (arg2 as u8));
        0x1::vector::append<u8>(&mut v0, v1);
        0x1::string::utf8(0x2::hex::encode(v0))
    }

    public fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

