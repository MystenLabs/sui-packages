module 0x4eccebc748c50eb159a9293d2a61dde3bb90d92dd8e43120f4ce90bb38683c8d::tasko {
    struct TASKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TASKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TASKO>(arg0, 9, b"Tasko", b"Tasko Coin", x"53696d706c69667920596f757220576f726b77697468205461736b6f20436f696e2041690d0a596f757220736d61727420617373697374616e7420666f72207461736b732c20616e73776572732c20616e642070726f6475637469766974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZu8LpXcA5MQQmDfxYBPUyrDnwK5jCjifULgqih2aubLj")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TASKO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TASKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TASKO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

