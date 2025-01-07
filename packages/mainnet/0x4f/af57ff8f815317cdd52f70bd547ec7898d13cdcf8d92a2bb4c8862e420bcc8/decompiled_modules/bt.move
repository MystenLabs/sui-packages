module 0x4faf57ff8f815317cdd52f70bd547ec7898d13cdcf8d92a2bb4c8862e420bcc8::bt {
    struct BT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BT>(arg0, 9, b"BT", b"Bethu", b"Troll peoplejile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/805883fc-f190-40e2-ae67-c0b904d146e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BT>>(v1);
    }

    // decompiled from Move bytecode v6
}

