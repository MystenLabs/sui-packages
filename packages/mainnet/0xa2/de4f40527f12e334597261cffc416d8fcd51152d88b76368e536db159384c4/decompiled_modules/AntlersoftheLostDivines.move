module 0xa2de4f40527f12e334597261cffc416d8fcd51152d88b76368e536db159384c4::AntlersoftheLostDivines {
    struct ANTLERSOFTHELOSTDIVINES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTLERSOFTHELOSTDIVINES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTLERSOFTHELOSTDIVINES>(arg0, 0, b"COS", b"Antlers of the Lost Divines", b"This forest shall crawl out of the darkness-once they return...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Antlers_of_the_Lost_Divines.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANTLERSOFTHELOSTDIVINES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTLERSOFTHELOSTDIVINES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

