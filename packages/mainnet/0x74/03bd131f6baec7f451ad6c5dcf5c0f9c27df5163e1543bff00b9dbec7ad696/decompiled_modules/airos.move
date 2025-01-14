module 0x7403bd131f6baec7f451ad6c5dcf5c0f9c27df5163e1543bff00b9dbec7ad696::airos {
    struct AIROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIROS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIROS>(arg0, 6, b"AIROS", b"AIROS AI by SuiAI", b"AIROS is an intelligent, decentralized AI robot harnessing Sui Network's cutting-edge blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_01_14_10_20_51_9e3b45c203.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIROS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIROS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

