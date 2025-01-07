module 0xc4545b002bb68dcf8b8e7b3effdeda37b3947f610552bf4e0150c945ecb1d37f::mage {
    struct MAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGE>(arg0, 9, b"MAGE", b"Md Farhan", b"Hi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bead8436-13eb-43c5-9ac8-4efdb726fbb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

