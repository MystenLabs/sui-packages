module 0xe5efd18137bc7fec345493dbb62db4f9b3834f2d5bc0b0891a0a2627126c79b5::wdogs {
    struct WDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOGS>(arg0, 9, b"WDOGS", b"WORK DOGS", b"Telegram Original MeMe Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7b2a0ef-5c86-48ae-b343-e92437a86be6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

