module 0xece2b1065ea8b8008ef4d4375f833039ff8bb155e19491b93b9828a0f34ac8b9::crup {
    struct CRUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUP>(arg0, 9, b"CRUP", b"Cruptolume", x"d09fd0bed0b3d180d183d0b7d0b8d182d0b5d181d18c20d0b220d0b1d183d0b4d183d189d0b5d0b520d184d0b8d0bdd0b0d0bdd181d0bed0b220d1812043727970746f4c756d656e7320e2809320d0b8d0bdd0bdd0bed0b2d0b0d186d0b8d0bed0bdd0bdd18bd0bc20d0bad180d0b8d0bfd182d0bed0b0d0bad182d0b8d0b2d0bed0bc2c20d0bad0bed182d0bed180d18bd0b920d181d0bed187d0b5d182d0b0d0b5d18220d0b220d181d0b5d0b1d0b520d0b2d18bd181d0bed0bad183d18e20d181d182d0b5d0bfd0b5d0bdd18c20d0b1d0b5d0b7d0bed0bfd0b0d181d0bdd0bed181d182d0b82c20d181d0bad0bed180d0bed181d182d18c20d182d180d0b0d0bdd0b7d0b0d0bad186d0b8d0b92e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0e25074-e1c1-423e-baa6-3eb23b912f1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

