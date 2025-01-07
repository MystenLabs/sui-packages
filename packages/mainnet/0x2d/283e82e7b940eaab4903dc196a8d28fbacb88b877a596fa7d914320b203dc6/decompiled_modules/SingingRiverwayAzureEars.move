module 0x2d283e82e7b940eaab4903dc196a8d28fbacb88b877a596fa7d914320b203dc6::SingingRiverwayAzureEars {
    struct SINGINGRIVERWAYAZUREEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINGINGRIVERWAYAZUREEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINGINGRIVERWAYAZUREEARS>(arg0, 0, b"COS", b"Singing Riverway Azure Ears", b"Listen to the water-the song of Gods, echoes of falling tears...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Singing_Riverway_Azure_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SINGINGRIVERWAYAZUREEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINGINGRIVERWAYAZUREEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

