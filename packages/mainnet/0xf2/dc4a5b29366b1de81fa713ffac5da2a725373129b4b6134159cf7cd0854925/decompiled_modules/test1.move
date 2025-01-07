module 0xf2dc4a5b29366b1de81fa713ffac5da2a725373129b4b6134159cf7cd0854925::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 9, b"TEST1", b"TEST1", b"Coin for TEST1 NFT game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gray-determined-landfowl-131.mypinata.cloud/ipfs/QmNtxwDm1P5WXYWwUcCSBP9PeyeABnjJk7YPryFA1tVwEy")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST1>>(v1);
        0x2::coin::mint_and_transfer<TEST1>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::coin::mint_and_transfer<TEST1>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

