module 0xf0977aa92ad1f80cdc35e620fa9107929d4b2715a1ade2af71f056e03cf4da04::RazmosRoyalLegbanEars {
    struct RAZMOSROYALLEGBANEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAZMOSROYALLEGBANEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAZMOSROYALLEGBANEARS>(arg0, 0, b"COS", b"Razmo's Royal Legban Ears", b"We glow because we see What is to Be Seen... we hear What is to Be Heard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Razmos_Royal_Legban_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAZMOSROYALLEGBANEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAZMOSROYALLEGBANEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

