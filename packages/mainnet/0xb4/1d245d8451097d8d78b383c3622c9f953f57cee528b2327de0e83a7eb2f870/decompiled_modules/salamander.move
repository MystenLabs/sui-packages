module 0xb41d245d8451097d8d78b383c3622c9f953f57cee528b2327de0e83a7eb2f870::salamander {
    struct SALAMANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALAMANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALAMANDER>(arg0, 6, b"Salamander", b"Sully Sui", b"Salamanders are a group of amphibians typically characterized by their lizard-like appearance, with slender bodies, blunt snouts, short limbs projecting at right angles to the body, and the presence of a tail in both larvae and adults", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733485383980.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALAMANDER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALAMANDER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

