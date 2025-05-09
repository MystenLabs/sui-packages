module 0xd1c649cf838e95520773b875c283e2149927dce2ad891d859de6554ef7ca5d98::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 9, b"bobo", b"bobo on sui", b"bobo, savior of the trenches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWszuQnwfxQZ3QiS7djTcVwikAyY8eb2Wwa2xafEhnBFK")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOBO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

