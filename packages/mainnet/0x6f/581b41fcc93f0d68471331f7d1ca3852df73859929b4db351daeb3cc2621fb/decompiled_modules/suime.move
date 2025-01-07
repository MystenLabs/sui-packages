module 0x6f581b41fcc93f0d68471331f7d1ca3852df73859929b4db351daeb3cc2621fb::suime {
    struct SUIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIME>(arg0, 6, b"SUIME", b"SUIGAME", b"SquidGame On SUICHAIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_19_45_31_e11bbf7bf0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

