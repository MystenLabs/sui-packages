module 0xbea4c434f812c854c650fd9ea7b32c780e9ee8f7ea24df24a9a935bf2c632b48::jav {
    struct JAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAV>(arg0, 6, b"Jav", b"Javsu", x"4a617673752e2041205355492077617465722d7479706520506f6bc3a96d6f6e2e0a0a4669676874696e67204d6f7665733a20200a0a484f444c202d20486f736564202d2044726f75676874202d20436c617269747920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748279775705.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

