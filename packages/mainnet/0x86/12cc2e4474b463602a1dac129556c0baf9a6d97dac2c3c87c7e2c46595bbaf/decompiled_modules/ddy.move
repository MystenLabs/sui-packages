module 0x8612cc2e4474b463602a1dac129556c0baf9a6d97dac2c3c87c7e2c46595bbaf::ddy {
    struct DDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDY>(arg0, 9, b"DDY", b"Daddy", x"4272696e6720736f6d65206361736820666f72207572206461646479f09f90b3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/909d6873-8197-45e0-ae88-52d0b35c52fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

