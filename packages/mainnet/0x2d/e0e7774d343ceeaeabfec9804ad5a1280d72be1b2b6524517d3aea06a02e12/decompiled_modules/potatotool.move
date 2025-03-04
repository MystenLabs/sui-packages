module 0x2de0e7774d343ceeaeabfec9804ad5a1280d72be1b2b6524517d3aea06a02e12::potatotool {
    struct POTATOTOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTATOTOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTATOTOOL>(arg0, 9, b"PotatoTool", b"PotatoTool", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/RckFmiaVlwtjHP1g7-kNGDlLptYgC_X26VOxBAsnrx0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POTATOTOOL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTATOTOOL>>(v2, @0xb0ec095b93b7c545dff8b3bc829ad9cce9348a7ca1cd478cec14baa1a90e2867);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTATOTOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

