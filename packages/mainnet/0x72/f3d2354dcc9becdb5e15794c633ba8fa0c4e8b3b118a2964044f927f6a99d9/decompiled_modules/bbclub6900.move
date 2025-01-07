module 0x72f3d2354dcc9becdb5e15794c633ba8fa0c4e8b3b118a2964044f927f6a99d9::bbclub6900 {
    struct BBCLUB6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBCLUB6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBCLUB6900>(arg0, 6, b"BBCLUB6900", b"BULLISH BOYS CLUB6900", x"57656c636f6d6520746f20244242434c5542363930302c20776865726520746865204368617269736d617469632043454f73202d2042726574746572696e2c20546f70204720506570652c205472756d7020426972642c20456c616e64204d75736b2c20616e6420435a20416e6479202d2073686f77636173652074686569722062756c6c6973682073706972697420776974680a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BULLISH_BOYS_CLUB_6900_7b2470c999.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBCLUB6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBCLUB6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

