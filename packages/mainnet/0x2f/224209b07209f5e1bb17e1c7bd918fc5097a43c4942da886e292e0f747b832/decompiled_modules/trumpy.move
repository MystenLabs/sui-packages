module 0x2f224209b07209f5e1bb17e1c7bd918fc5097a43c4942da886e292e0f747b832::trumpy {
    struct TRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPY>(arg0, 6, b"TRUMPY", b"OFFICIAL MAID TRUMPY", x"4275696c647320746865206e6578742d67656e65726174696f6e2063756c7475726520616e6420636f6d6d756e697479206f66205355492c2061206d656d6520726f6f74656420696e20616e206f726967696e616c2049500a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737724638174.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

