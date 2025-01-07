module 0x3b93ef34464b5e0283d978495c189c31eb58e89d44d52c2386f67da27ecb30eb::nana {
    struct NANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANA>(arg0, 9, b"NANA", b"Nana", b"Nanana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9e62ce5-531b-4542-9d85-1fb2ca99f3ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

