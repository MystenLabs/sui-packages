module 0x9cc817d282a236a70e849c5393c9357c48c25f19a29b90d6f92c9f500aa08a71::cummies {
    struct CUMMIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUMMIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUMMIES>(arg0, 6, b"Cummies", b"CumRocket", b"Exactly what the name implies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/st_small_507x507_pad_600x600_f8f8f8_b0a39e6cf0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUMMIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUMMIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

