module 0x771ab1b31995677883dfbea883e2131507270023214924c3c2621f747864b704::doodle {
    struct DOODLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODLE>(arg0, 9, b"DOODLE", b"Doodle Jump Solana", x"46726f6d20746865206368696c64686f6f642073637265656e20746f2074686520626c6f636b636861696e202d2024444f4f444c45206e657665722073746f70206a756d70696e672c20616e64206e6569746865722073686f756c6420752e0a0a54656c656772616d3a68747470733a2f2f742e6d652f446f6f646c65536f6c4a756d705c6e547769747465723a68747470733a2f2f782e636f6d2f446f6f646c65536f6c4a756d705c6e576562736974653a68747470733a2f2f646f6f646c656a756d702e636c69636b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbWfmER3xvZbFMV4FAQ7xdZSP2MbX95H3QQBdxXoJfstt")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOODLE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOODLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

