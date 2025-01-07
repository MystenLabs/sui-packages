module 0xc84ee356338bf2fce18d9019e78426a1e4180b600f2cafa8ad43c99befbc898::eft {
    struct EFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EFT>(arg0, 9, b"EFT", b"EfToken ", b"A tokenized assets on Sui network designed to aid transactions for solar installation and system in the solar Blockchain ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31f3cd24-fba3-4733-bfb2-473a41846af8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

