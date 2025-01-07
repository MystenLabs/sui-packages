module 0x67f772930d47d61b364df9fb253ee5eca75fbc191890a226ff406cda34157175::eft {
    struct EFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EFT>(arg0, 9, b"EFT", b"EfToken ", b"A tokenized assets on Sui network designed to aid transactions for solar installation and system in the solar Blockchain ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69913d36-a98e-46a8-a8ff-5b13d2e96d0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

