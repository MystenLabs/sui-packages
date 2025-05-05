module 0x74e60cac84a26fa948178fcef754eb6be1504537c0ec275fe5f8c81983d7c47c::jkj {
    struct JKJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKJ>(arg0, 6, b"JKJ", b"feqw", b"fwfw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/waves_by_the_coast_at_night_wallpaper_2560x1080_d367bc92f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JKJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

