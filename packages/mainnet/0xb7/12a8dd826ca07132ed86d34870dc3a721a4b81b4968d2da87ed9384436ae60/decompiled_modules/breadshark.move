module 0xb712a8dd826ca07132ed86d34870dc3a721a4b81b4968d2da87ed9384436ae60::breadshark {
    struct BREADSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREADSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREADSHARK>(arg0, 6, b"BREADSHARK", b"Bread Shark", b"Watch out for the bread shark with the waves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0215_76c9248eb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREADSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREADSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

