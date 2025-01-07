module 0xf35e7ee895903898a859f46beaa24a1aa0097336c09474611b8d5279d8e06853::suipeople {
    struct SUIPEOPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEOPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEOPLE>(arg0, 9, b"SPeople", b"Sui People", b"Sui People", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.shopify.com/s/files/1/0276/3250/0771/products/2022-Batman-Classic-Au-1oz-Coin-Rev-Edge_640x.png?v=1672789455")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPEOPLE>>(0x2::coin::mint<SUIPEOPLE>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEOPLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEOPLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

