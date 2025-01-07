module 0x33596b9b7175c56b9dd0ed41ca6f7e3f8cf104ef87d1ad572f88ad4e7ea19afd::WelcomingGrandeur {
    struct WELCOMINGGRANDEUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WELCOMINGGRANDEUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WELCOMINGGRANDEUR>(arg0, 0, b"COS", b"Welcoming Grandeur", b"A greeting... a warm salutation... a murmur beneath the ebbs of the marketplace...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Welcoming_Grandeur.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WELCOMINGGRANDEUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WELCOMINGGRANDEUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

