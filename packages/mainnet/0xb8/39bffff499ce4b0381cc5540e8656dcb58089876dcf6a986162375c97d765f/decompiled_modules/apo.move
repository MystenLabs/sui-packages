module 0xb839bffff499ce4b0381cc5540e8656dcb58089876dcf6a986162375c97d765f::apo {
    struct APO has drop {
        dummy_field: bool,
    }

    fun init(arg0: APO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APO>(arg0, 6, b"APO", b"APOSTROPHE", b"Just an apostrophe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/_b616548c39.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APO>>(v1);
    }

    // decompiled from Move bytecode v6
}

