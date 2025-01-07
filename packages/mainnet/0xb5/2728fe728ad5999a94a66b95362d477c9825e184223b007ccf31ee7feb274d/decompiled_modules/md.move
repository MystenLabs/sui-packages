module 0xb52728fe728ad5999a94a66b95362d477c9825e184223b007ccf31ee7feb274d::md {
    struct MD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MD>(arg0, 6, b"MD", b"Maple the Dachshund", b"Our beloved Maple is one year old today, so I thought I'd launch a meme to celebrate. May she live on forever!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732274754673.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

