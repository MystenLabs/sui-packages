module 0xdbc7d2c2ab25997faae07ed18594bda6190cad4617e65dbbdfc023ba2b9c33da::FireHawkWings {
    struct FIREHAWKWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIREHAWKWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIREHAWKWINGS>(arg0, 0, b"COS", b"FireHawk Wings", b"Take off... and ignite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_FireHawk_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIREHAWKWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIREHAWKWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

