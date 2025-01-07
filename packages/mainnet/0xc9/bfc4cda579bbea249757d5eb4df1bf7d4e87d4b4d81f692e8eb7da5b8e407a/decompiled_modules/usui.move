module 0xc9bfc4cda579bbea249757d5eb4df1bf7d4e87d4b4d81f692e8eb7da5b8e407a::usui {
    struct USUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USUI>(arg0, 9, b"USUI", x"f09f87ba535549", x"f09f958aefb88f20506561636520666f7220556b7261696e6520f09f87baf09f87a6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f06d37f7-e7ad-44c6-aa77-8c8df9f908f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

