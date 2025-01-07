module 0x1169ff82b7b621f9703d71f1a8ec1279ca4ba4d9e6d3d7fd4def888d5932c431::lindy {
    struct LINDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINDY>(arg0, 9, b"LINDY", b"LindyMan", b"LindyMan is the meme token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/7XTaE1FWddkSvMxjk4sVLD3HVFCWkTaQsCehPvzVBmXK.png?size=xl&key=fe5833")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LINDY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LINDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINDY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

