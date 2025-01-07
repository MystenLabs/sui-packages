module 0xfff9b1a37d08f766643470cd6d477b3b04fef5a100507a4a7681a7e42a383615::eft {
    struct EFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EFT>(arg0, 9, b"EFT", b"EfToken ", b"A tokenized assets on Sui network designed to aid transactions for solar installation and system in the solar Blockchain ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b005618a-a50d-4502-9e1a-b78f3232a48e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

