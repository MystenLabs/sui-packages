module 0x30f03bbaeb2794e6476025e006d44a7ee36882ebd6dc2eeb586f12c266e80352::FragmentsofWar {
    struct FRAGMENTSOFWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRAGMENTSOFWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRAGMENTSOFWAR>(arg0, 0, b"COS", b"Fragments of War", b"Return them, one day, to where they belong.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Fragments_of_War.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRAGMENTSOFWAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRAGMENTSOFWAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

