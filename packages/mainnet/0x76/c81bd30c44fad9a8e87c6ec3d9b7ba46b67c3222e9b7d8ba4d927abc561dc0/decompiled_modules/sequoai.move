module 0x76c81bd30c44fad9a8e87c6ec3d9b7ba46b67c3222e9b7d8ba4d927abc561dc0::sequoai {
    struct SEQUOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEQUOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEQUOAI>(arg0, 9, b"SEQUOAI", b"Sequoai", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXTRVkifsChygwYQQvr1oG8pQ5Y7FSy2YbxBTrDCkEqvF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEQUOAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEQUOAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEQUOAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

