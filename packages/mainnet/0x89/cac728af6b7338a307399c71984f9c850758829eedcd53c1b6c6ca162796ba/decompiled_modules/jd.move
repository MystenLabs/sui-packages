module 0x89cac728af6b7338a307399c71984f9c850758829eedcd53c1b6c6ca162796ba::jd {
    struct JD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JD>(arg0, 6, b"JD", b"JingDong", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_11_05_00_19_15_8fb0d9b378.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JD>>(v1);
    }

    // decompiled from Move bytecode v6
}

