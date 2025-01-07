module 0xc8a1b69b7c8e91f5753fdeb117d67a0eaffa21eca0a968c72e5ce6e4703b859e::sloth {
    struct SLOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTH>(arg0, 6, b"SLOTH", b"Sloth On Sui", b"Sloth is the cutest $SLOTH on SUI, bringing $SLOTH to the world of memes. No cats, no dogs. Only $SLOTH.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_91e0ce3fdb_3e0cf16405.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

