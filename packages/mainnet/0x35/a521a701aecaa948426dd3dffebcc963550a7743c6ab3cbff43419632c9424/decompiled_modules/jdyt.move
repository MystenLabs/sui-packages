module 0x35a521a701aecaa948426dd3dffebcc963550a7743c6ab3cbff43419632c9424::jdyt {
    struct JDYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDYT>(arg0, 9, b"JDYT", b"JDYA TOKEN", b"A token that transfer culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9af98b0-a040-41c9-915a-f63c735446c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JDYT>>(v1);
    }

    // decompiled from Move bytecode v6
}

