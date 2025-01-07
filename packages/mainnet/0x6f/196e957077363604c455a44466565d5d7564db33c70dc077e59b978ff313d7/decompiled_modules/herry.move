module 0x6f196e957077363604c455a44466565d5d7564db33c70dc077e59b978ff313d7::herry {
    struct HERRY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HERRY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HERRY>>(0x2::coin::mint<HERRY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERRY>(arg0, 6, b"HERRY", b"HERRY", b"This is Herry token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HERRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

