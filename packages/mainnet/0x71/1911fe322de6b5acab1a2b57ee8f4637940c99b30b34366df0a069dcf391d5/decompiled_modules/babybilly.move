module 0x711911fe322de6b5acab1a2b57ee8f4637940c99b30b34366df0a069dcf391d5::babybilly {
    struct BABYBILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBILLY>(arg0, 6, b"BABYBILLY", b"Baby Billy Dolphin", b"lets make this thing CTO, fucking stupid dev before", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_CA_3_B133_4_D72_44_FA_8_C11_AB_0_EFD_7820_A1_f454b047ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

