module 0xb312081e0e78dd891fc513b3736038274e1759dda927d47da085f8c5ca7321d3::FormlessGlowEars {
    struct FORMLESSGLOWEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORMLESSGLOWEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORMLESSGLOWEARS>(arg0, 0, b"COS", b"Formless Glow Ears", b"Lose yourself to confront the void of Nindfall...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Formless_Glow_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORMLESSGLOWEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORMLESSGLOWEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

