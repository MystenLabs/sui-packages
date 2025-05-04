module 0x11cab8e702755e3f6ea37f0918df248213c4a74aadd472488c3dfe907137769e::waddlebag {
    struct WADDLEBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WADDLEBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WADDLEBAG>(arg0, 9, b"WADDLE", b"Waddlebag", b"When you're not fast, but you always arrive with a bag.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidbvzrethfpsj5r7ijhzek6qp2duana5jtesngdddknjsv2au7vmq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WADDLEBAG>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WADDLEBAG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WADDLEBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

