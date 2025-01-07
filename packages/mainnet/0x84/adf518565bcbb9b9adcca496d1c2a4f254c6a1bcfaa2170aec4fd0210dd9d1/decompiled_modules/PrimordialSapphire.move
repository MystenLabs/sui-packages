module 0x84adf518565bcbb9b9adcca496d1c2a4f254c6a1bcfaa2170aec4fd0210dd9d1::PrimordialSapphire {
    struct PRIMORDIALSAPPHIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIMORDIALSAPPHIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMORDIALSAPPHIRE>(arg0, 0, b"COS", b"Primordial Sapphire", b"A world has faded... but honor, the word of Ancients, does remain...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Primordial_Sapphire.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMORDIALSAPPHIRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIMORDIALSAPPHIRE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

