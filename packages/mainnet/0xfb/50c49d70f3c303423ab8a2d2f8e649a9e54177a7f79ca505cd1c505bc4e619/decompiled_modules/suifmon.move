module 0xfb50c49d70f3c303423ab8a2d2f8e649a9e54177a7f79ca505cd1c505bc4e619::suifmon {
    struct SUIFMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFMON>(arg0, 6, b"SUIFMON", b"SUIFMOON", b"SAFEMOON + SUI = SUIFMOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_21_55_55_5a06088949.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

