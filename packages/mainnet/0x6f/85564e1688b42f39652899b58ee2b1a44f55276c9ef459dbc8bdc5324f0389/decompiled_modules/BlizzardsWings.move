module 0x6f85564e1688b42f39652899b58ee2b1a44f55276c9ef459dbc8bdc5324f0389::BlizzardsWings {
    struct BLIZZARDSWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIZZARDSWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLIZZARDSWINGS>(arg0, 0, b"COS", b"Blizzard's Wings", b"Where others are lost, you will find the way...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Blizzard's_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLIZZARDSWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLIZZARDSWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

