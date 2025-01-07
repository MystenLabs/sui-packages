module 0x216ff31df72b74e6a9e774af2d0c5e06a57193789afd7858793d66a8da969bd7::hajfhffuf3 {
    struct HAJFHFFUF3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAJFHFFUF3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAJFHFFUF3>(arg0, 9, b"HAJFHFFUF3", b"TRUMP MOON", b"HDOEOQUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa9d78bb-64e7-4d98-b78f-25bd1fcc7c82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAJFHFFUF3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAJFHFFUF3>>(v1);
    }

    // decompiled from Move bytecode v6
}

