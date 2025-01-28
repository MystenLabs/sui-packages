module 0xcb962a4fb08d41e4a59abbc353c354cdbbc268b87ee5071d7f92d3450743a0a9::pif {
    struct PIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIF>(arg0, 6, b"PIF", b"pufferwifcarrot", b"Just a puffer wif carrot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_025647_969_f352777b14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

