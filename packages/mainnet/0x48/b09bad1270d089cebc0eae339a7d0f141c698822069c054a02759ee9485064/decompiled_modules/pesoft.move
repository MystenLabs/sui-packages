module 0x48b09bad1270d089cebc0eae339a7d0f141c698822069c054a02759ee9485064::pesoft {
    struct PESOFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESOFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESOFT>(arg0, 6, b"PESOFT", b"PepeSoft", b"PESOFT the error Pepe on SUI..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_02_20_13_50_14sadasdas_SADASDASDASD_4cbf20b2b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESOFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESOFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

