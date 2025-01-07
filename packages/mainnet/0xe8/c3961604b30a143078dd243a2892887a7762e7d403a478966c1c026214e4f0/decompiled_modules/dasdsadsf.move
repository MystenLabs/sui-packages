module 0xe8c3961604b30a143078dd243a2892887a7762e7d403a478966c1c026214e4f0::dasdsadsf {
    struct DASDSADSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DASDSADSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DASDSADSF>(arg0, 6, b"DASDSADSF", b"DSADA", b"SDADSAF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_09_35_29_81734e2f38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DASDSADSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DASDSADSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

