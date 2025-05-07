module 0xb0122063e1fff1ce9b117cc6627b2cda2595db56859ae344679ff813b5b57696::gbull {
    struct GBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBULL>(arg0, 6, b"GBULL", b"GuzBull", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihmslyx3lrw2ezw2ewilkjirvfcenikxpqoznbj4w3k5jwy5gluzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GBULL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

