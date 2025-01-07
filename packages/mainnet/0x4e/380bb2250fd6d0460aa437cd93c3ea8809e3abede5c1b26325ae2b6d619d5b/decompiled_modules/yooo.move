module 0x4e380bb2250fd6d0460aa437cd93c3ea8809e3abede5c1b26325ae2b6d619d5b::yooo {
    struct YOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOOO>(arg0, 6, b"YOOO", b"YOO", b"YO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Artist_Pose_80ae82ffbf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

