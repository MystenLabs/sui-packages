module 0x27f683ad3976847bb0c6b9c3a2266053a12e1bf78b37efda586a16a3afabe62e::tartaria {
    struct TARTARIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARTARIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARTARIA>(arg0, 6, b"TARTARIA", b"TARTARIA MAGNA", b"TARTARIA MAGNA: In Search of the Lost Civilization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_MOVEPUMP_2dbf10c247.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARTARIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARTARIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

