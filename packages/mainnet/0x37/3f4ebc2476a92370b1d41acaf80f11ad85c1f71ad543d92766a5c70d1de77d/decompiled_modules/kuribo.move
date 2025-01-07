module 0x373f4ebc2476a92370b1d41acaf80f11ad85c1f71ad543d92766a5c70d1de77d::kuribo {
    struct KURIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KURIBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KURIBO>(arg0, 9, b"KURIBO", b"KuriboSUI", b"Kuribo is the best on DOG on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e032b4c0-d97e-4a09-baa1-defdb4f2ce8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KURIBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KURIBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

