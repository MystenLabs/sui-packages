module 0x34c1e68b39ac0b44a4b36af627dc85886eb6f18e6b828a4458977b0611e07e3b::heysui {
    struct HEYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEYSUI>(arg0, 9, b"HEYSUI", b"Heysuioi", b"Heysuioi is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c27ffbe3-535c-481e-a759-c14d4cdb38a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

