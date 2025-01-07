module 0xc2383376d3c161fb12253b0785f1d94d767aa9874290380020fc4454f681ebcd::jgb {
    struct JGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JGB>(arg0, 9, b"JGB", b"OCEAN", b"crypto in your pocket", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/440545b7-b9d6-4b3b-a2c4-09e31e2794e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

