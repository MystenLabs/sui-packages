module 0xe323f3f51792a7ccf364e81265bfbf3b0a1770ca25d366f9982cd51f94bd38f5::HatoftheHelper {
    struct HATOFTHEHELPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HATOFTHEHELPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HATOFTHEHELPER>(arg0, 0, b"COS", b"Hat of the Helper", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Hat_of_the_Helper.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HATOFTHEHELPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HATOFTHEHELPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

