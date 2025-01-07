module 0xf8f3312fd45f91cac2fbc160228fb2a50f83d2d8c634b297533773d3e6653e::suiwukong {
    struct SUIWUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWUKONG>(arg0, 6, b"SUIWUKONG", b"BLACK MYTH", b"BLACK MYTH WUKONG  GAME OF KING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GW_1_C6if_XQAAHXQC_66daadc1be.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

