module 0x40fb93c01104c27707a1d78b246035de4f1c5dec9c22d616e7b1b27bc86d0b4f::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 9, b"USDT", b"USD Tether", b"USDT, or Tether, is a cryptocurrency stablecoin that aims to maintain a value of approximately 1 US dollar.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/522fcfb1-3aaf-4a64-8a45-212fe5462a51.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

