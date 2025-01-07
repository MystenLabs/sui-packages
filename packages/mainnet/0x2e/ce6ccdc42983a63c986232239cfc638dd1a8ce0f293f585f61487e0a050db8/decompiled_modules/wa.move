module 0x2ece6ccdc42983a63c986232239cfc638dd1a8ce0f293f585f61487e0a050db8::wa {
    struct WA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WA>(arg0, 6, b"Wa", b"Wa Seal", b"$WA - Seal says waa, wa, wah, wha, whaa, aah, waaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ri8_W_Okh_400x400_aed630f2b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WA>>(v1);
    }

    // decompiled from Move bytecode v6
}

