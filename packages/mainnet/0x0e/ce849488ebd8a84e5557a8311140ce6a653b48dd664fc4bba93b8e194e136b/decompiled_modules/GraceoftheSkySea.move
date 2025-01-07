module 0xece849488ebd8a84e5557a8311140ce6a653b48dd664fc4bba93b8e194e136b::GraceoftheSkySea {
    struct GRACEOFTHESKYSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHESKYSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHESKYSEA>(arg0, 0, b"COS", b"Grace of the Sky-Sea", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Sky-Sea.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHESKYSEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHESKYSEA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

