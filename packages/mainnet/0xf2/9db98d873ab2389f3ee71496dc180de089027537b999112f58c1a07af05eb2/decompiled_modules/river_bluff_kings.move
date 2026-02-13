module 0xf29db98d873ab2389f3ee71496dc180de089027537b999112f58c1a07af05eb2::river_bluff_kings {
    struct RIVER_BLUFF_KINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIVER_BLUFF_KINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIVER_BLUFF_KINGS>(arg0, 9, b"RBK", b"River Bluff Kings", b"A fixed-supply community token created for the River Bluff Crypto Kings, a private crypto investing group.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/abryant0716/RBK/main/rbk.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<RIVER_BLUFF_KINGS>>(0x2::coin::mint<RIVER_BLUFF_KINGS>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIVER_BLUFF_KINGS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RIVER_BLUFF_KINGS>>(v2);
    }

    // decompiled from Move bytecode v6
}

