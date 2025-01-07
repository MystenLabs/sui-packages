module 0x98e2536bc0fc46b30cd0539c8ad9857db0098462e3adcba79605cbd1a7fd58::newnormal {
    struct NEWNORMAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWNORMAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWNORMAL>(arg0, 6, b"NewNormal", b"The New Normal", x"476976696e672065766572796f6e65206f6e6520612073686f7420616e64206c61756e6368696e672077697468206e6f206e6f746963652e200a4772656574696e67732c2045617274686c696e677321204920636f6d6520696e2070656163652e2e2e20616e642070726f666974212049276d206865726520746f20696e74726f6475636520746865206d6f7374206f75742d6f662d746869732d776f726c64206d656d6520636f696e2e204e6f7468696e6720746f2073656520686572652c206a75737420746865206e6577206e6f726d616c20616c69656e7320666c79696e672064726f6e6573206576657279206e696768742e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734313945862.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWNORMAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWNORMAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

