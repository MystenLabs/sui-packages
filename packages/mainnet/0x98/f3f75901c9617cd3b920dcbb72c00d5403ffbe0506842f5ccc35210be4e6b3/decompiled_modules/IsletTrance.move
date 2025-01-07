module 0x98f3f75901c9617cd3b920dcbb72c00d5403ffbe0506842f5ccc35210be4e6b3::IsletTrance {
    struct ISLETTRANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISLETTRANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISLETTRANCE>(arg0, 0, b"COS", b"Islet Trance", b"Listen, but see not... for a mirror has drained our night...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Islet_Trance.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISLETTRANCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISLETTRANCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

