module 0x2b2c2eecc3e8b507a5ec6e33feef65603b4f2bf05f78e2ad19094ec749a02c33::gogoji {
    struct GOGOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGOJI>(arg0, 9, b"GOGOJI", b"GOGO", b"Muje testnet mila", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31ad5adc-c231-4281-84dd-aa035f598f3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOGOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

