module 0x186925d46c5e6e91db5c59532cff033dacf340bb201aff5c5bcdef8bd6c7d640::mbtt {
    struct MBTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBTT>(arg0, 6, b"MBTT", b"MoonBags Test Token", b"MoonBags Test Token...MoonBags Test Token...MoonBags Test Token...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaoszgyn5fu2awhpwaqndvk4s3t7knmd5fw2qwkf25w7yva2zdp5e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

