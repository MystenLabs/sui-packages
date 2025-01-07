module 0x5a12dd96e6b57fcbb216ca5cf6f61753fdbf5d15fb96ff12dcec0e520cef3fbf::sf {
    struct SF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SF>(arg0, 9, b"SF", b"JL", b"DG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae769819-6e2a-444e-9cd2-461b7f84ecd3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SF>>(v1);
    }

    // decompiled from Move bytecode v6
}

