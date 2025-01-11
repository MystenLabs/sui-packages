module 0xa077735e34e202e6074fab914534d0970b825e7c43044842e8bc9c8b1fe9c133::stellix {
    struct STELLIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: STELLIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STELLIX>(arg0, 6, b"STELLIX", b"Stellix Protocol", b"Decentralized AI systems working in perfect sync. Stellix Protocol powers a connected, ever-evolving intelligent network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250112_004421_931_c7836f9906.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STELLIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STELLIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

