module 0xf7feead0e05414f2a2bfdda44d8488f29b6de13d8214517c09f122e348de8ded::mtt {
    struct MTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTT>(arg0, 6, b"MTT", b"MoonBags Test Token", b"MoonBags Test Token...MoonBags Test Token...MoonBags Test Token...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaoszgyn5fu2awhpwaqndvk4s3t7knmd5fw2qwkf25w7yva2zdp5e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

