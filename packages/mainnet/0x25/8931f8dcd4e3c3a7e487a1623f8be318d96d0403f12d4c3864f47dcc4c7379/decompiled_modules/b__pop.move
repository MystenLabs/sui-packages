module 0x258931f8dcd4e3c3a7e487a1623f8be318d96d0403f12d4c3864f47dcc4c7379::b__pop {
    struct B__POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B__POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B__POP>(arg0, 9, b"b$POP", b"bToken $POP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B__POP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B__POP>>(v1);
    }

    // decompiled from Move bytecode v6
}

