module 0x7c4389ea44a39e8414af38ac18b8faeee5f7dc211d94def0e52b5e6d3bda1a1a::DivineElderEars {
    struct DIVINEELDEREARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIVINEELDEREARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIVINEELDEREARS>(arg0, 0, b"COS", b"Divine ElderEars", b"A glow of Gods long since fallen...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Divine_ElderEars.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIVINEELDEREARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIVINEELDEREARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

