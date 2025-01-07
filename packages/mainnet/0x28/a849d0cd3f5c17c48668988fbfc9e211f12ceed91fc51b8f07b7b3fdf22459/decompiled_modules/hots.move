module 0x28a849d0cd3f5c17c48668988fbfc9e211f12ceed91fc51b8f07b7b3fdf22459::hots {
    struct HOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTS>(arg0, 6, b"HOTS", b"Hippo of the Sui", b"Take a swim with hippo of the sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5837_fefea2eca8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

