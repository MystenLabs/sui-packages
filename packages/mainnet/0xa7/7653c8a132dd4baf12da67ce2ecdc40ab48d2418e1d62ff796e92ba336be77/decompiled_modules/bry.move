module 0xa77653c8a132dd4baf12da67ce2ecdc40ab48d2418e1d62ff796e92ba336be77::bry {
    struct BRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRY>(arg0, 9, b"BRY", b"blue eyes", b"like the sky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/511692cb-1a5d-40e7-ae9a-da1c59aeeb39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

