module 0x3005d095fbb073e2d2c8220046902eb01721a16f7b51c138d524668837b9d26::dbuy {
    struct DBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBUY>(arg0, 6, b"DBUY", b"Don't Buy This Token", b"Its probably best if you avoid this token. After all, why get involved in something that's poised to take off when you could just wait and miss out?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logodbuy_441d7240e8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

