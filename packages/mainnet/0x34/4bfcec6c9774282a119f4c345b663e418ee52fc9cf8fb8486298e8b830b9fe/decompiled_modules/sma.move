module 0x344bfcec6c9774282a119f4c345b663e418ee52fc9cf8fb8486298e8b830b9fe::sma {
    struct SMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMA>(arg0, 9, b"SMA", b"vann samba", b"blue with green", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d3311a8-cbc5-4462-a7ab-e1a2a4124a72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

