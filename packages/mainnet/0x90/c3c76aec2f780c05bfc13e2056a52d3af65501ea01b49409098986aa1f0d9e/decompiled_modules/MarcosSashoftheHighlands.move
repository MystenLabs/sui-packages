module 0x90c3c76aec2f780c05bfc13e2056a52d3af65501ea01b49409098986aa1f0d9e::MarcosSashoftheHighlands {
    struct MARCOSSASHOFTHEHIGHLANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARCOSSASHOFTHEHIGHLANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARCOSSASHOFTHEHIGHLANDS>(arg0, 0, b"COS", b"Marco's Sash of the Highlands", b"Left behind at a Lulutin outpost...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Marcos_Sash_of_the_Highlands.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARCOSSASHOFTHEHIGHLANDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARCOSSASHOFTHEHIGHLANDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

