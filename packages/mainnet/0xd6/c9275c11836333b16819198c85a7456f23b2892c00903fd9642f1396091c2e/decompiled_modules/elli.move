module 0xd6c9275c11836333b16819198c85a7456f23b2892c00903fd9642f1396091c2e::elli {
    struct ELLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELLI>(arg0, 9, b"ELLI", b"Elli", b"Explore Sui with help ELLI - powerful wallet on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63aa7b75-7b16-4f8b-b8ba-90ecac0797d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

