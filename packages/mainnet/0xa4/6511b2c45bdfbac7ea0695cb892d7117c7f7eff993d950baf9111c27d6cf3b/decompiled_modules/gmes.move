module 0xa46511b2c45bdfbac7ea0695cb892d7117c7f7eff993d950baf9111c27d6cf3b::gmes {
    struct GMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMES>(arg0, 6, b"GMES", b"GameStop on Sui", b"Join the revolution!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5731_cc50b5ade2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

