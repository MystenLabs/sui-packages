module 0x16c8272c76337d75db68bcf2ebd3d92bced2f188aa47af4c17a68d10bd080272::EarsoftheWise {
    struct EARSOFTHEWISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARSOFTHEWISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARSOFTHEWISE>(arg0, 0, b"COS", b"Ears of the Wise", b"Artistry of silence... poetry of wind...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Ears_of_the_Wise.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARSOFTHEWISE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARSOFTHEWISE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

