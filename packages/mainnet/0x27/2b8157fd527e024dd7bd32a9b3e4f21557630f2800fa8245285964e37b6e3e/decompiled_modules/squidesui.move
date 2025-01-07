module 0x272b8157fd527e024dd7bd32a9b3e4f21557630f2800fa8245285964e37b6e3e::squidesui {
    struct SQUIDESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDESUI>(arg0, 6, b"SQUIDESUI", b"SQUID SUI", x"5371756964205375692069732061206e6577206d656d6520636f696e206275696c74206f6e207468652053756920626c6f636b636861696e2e2044657369676e656420776974682061207374726f6e6720636f6d6d756e69747920666f6375732c205371756964205375692061696d7320746f2062652061206c656164696e672063727970746f63757272656e63792077697468696e20746865205375692065636f73797374656d2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movepump_logo_2_d54ef58091_40a6282947.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

