module 0x5188326532e9532f8eb6e3da6e50cc0997d0fed11821a843631da10a691a53ec::SeafarersWings {
    struct SEAFARERSWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAFARERSWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAFARERSWINGS>(arg0, 0, b"COS", b"Seafarer's Wings", b"Weave through the debris... beach the ruination of Eleriah...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Seafarer's_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAFARERSWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAFARERSWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

