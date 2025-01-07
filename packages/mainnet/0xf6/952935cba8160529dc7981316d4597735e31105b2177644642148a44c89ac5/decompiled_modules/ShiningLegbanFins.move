module 0xf6952935cba8160529dc7981316d4597735e31105b2177644642148a44c89ac5::ShiningLegbanFins {
    struct SHININGLEGBANFINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHININGLEGBANFINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHININGLEGBANFINS>(arg0, 0, b"COS", b"Shining Legban Fins", b"Swim the UnSwum... cross the Never Seen...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Shining_Legban_Fins.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHININGLEGBANFINS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHININGLEGBANFINS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

