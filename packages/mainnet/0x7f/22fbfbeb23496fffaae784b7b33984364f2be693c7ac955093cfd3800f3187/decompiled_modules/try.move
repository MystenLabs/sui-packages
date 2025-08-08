module 0x7f22fbfbeb23496fffaae784b7b33984364f2be693c7ac955093cfd3800f3187::try {
    struct TRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRY>(arg0, 6, b"TRY", b"TEST", b"blacktesttest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaoszgyn5fu2awhpwaqndvk4s3t7knmd5fw2qwkf25w7yva2zdp5e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

