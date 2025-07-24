module 0x65bbd10d800efe86520d6858f3ec8866656c1131d808464f1b3fd3aa0c1a0807::b_steafu {
    struct B_STEAFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STEAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STEAFU>(arg0, 9, b"bSTEAFU", b"bToken STEAFU", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STEAFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STEAFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

