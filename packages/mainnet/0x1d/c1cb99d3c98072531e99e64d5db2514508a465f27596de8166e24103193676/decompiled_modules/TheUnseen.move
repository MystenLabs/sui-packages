module 0x1dc1cb99d3c98072531e99e64d5db2514508a465f27596de8166e24103193676::TheUnseen {
    struct THEUNSEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEUNSEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEUNSEEN>(arg0, 0, b"COS", b"The Unseen", b"Sightless are eyes in a forgotten abyss...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_The_Unseen.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEUNSEEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEUNSEEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

