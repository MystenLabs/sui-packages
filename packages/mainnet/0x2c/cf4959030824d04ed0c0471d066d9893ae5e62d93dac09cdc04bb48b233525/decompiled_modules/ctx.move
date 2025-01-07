module 0x2ccf4959030824d04ed0c0471d066d9893ae5e62d93dac09cdc04bb48b233525::ctx {
    struct CTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTX>(arg0, 9, b"CTX", b"CrateX", x"2a2a4e6574776f726b2a2a3a2042696e616e636520536d61727420436861696e20284245502d32302920200a2a2a546f74616c20537570706c792a2a3a20312c3030302c3030302c3030302043545820200a2a2a446973747269627574696f6e2a2a3a20200a2d205465616d2026204465763a2032302520200a2d2049434f2f49444f3a2033352520200a2d20436f6d6d756e6974793a2032352520200a2d20526573657276653a2031302520200a2d20506172746e657273686970733a20313025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0012f66-58c3-4a02-9081-d3234e086d6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTX>>(v1);
    }

    // decompiled from Move bytecode v6
}

