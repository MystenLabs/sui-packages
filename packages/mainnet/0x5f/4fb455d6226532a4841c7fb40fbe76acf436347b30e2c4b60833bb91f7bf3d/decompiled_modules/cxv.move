module 0x5f4fb455d6226532a4841c7fb40fbe76acf436347b30e2c4b60833bb91f7bf3d::cxv {
    struct CXV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CXV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CXV>(arg0, 9, b"CXV", b"BHF", b"VXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e0d4eee-d8b1-4c35-8dbf-fd0af079375c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CXV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CXV>>(v1);
    }

    // decompiled from Move bytecode v6
}

