module 0xd99f2755fd3be99311c1500ddc32e20dee8500acbfa13ddaf0c6dcb98f59061e::stnr {
    struct STNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STNR>(arg0, 9, b"STNR", b"SOTANARO", x"54686520746f6b656e206f66206d792066616d696c7920e29da4efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7274bb0-5270-4a5e-8ab1-e446dc2ac6cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STNR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STNR>>(v1);
    }

    // decompiled from Move bytecode v6
}

