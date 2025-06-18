module 0x31c6e54f7d750f2a1c3b8068490b5a5671198cb69717e3326f91f63c826f412a::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICE>(arg0, 6, b"ICE", b"SUIce", x"53554963652c20546865204368696c6c657374204d656d65636f696e206f6e20535549200a466f7267656420696e2066726f73742c20706f7765726564206279205355492e0a535549636520667265657a6573204655442c206d656c7473206368617274732c20616e64206272696e67732069637920766962657320746f2074686520626c6f636b636861696e2e0a436f6c64202620436c65616e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifq2sjwfvk6v57zc53xim5fm5elcwy7fycbxkdi2gephwoloiehbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ICE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

