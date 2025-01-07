module 0x2c27dcc59370b9bdcac26dd5dcebd50940c4d46dc174012e57381f5ce76467b::sat_goj0 {
    struct SAT_GOJ0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAT_GOJ0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAT_GOJ0>(arg0, 9, b"SAT_GOJ0", b"GOJO", x"5361746f727520476f6a6f206973206261636b20776974682053756b756e6120696e20686973207369646520746f20736176652074686520776f726c642066726f6d207573656c657373206d656d65732e20496e737069726564206279204a756a75747375204b616973656e2e2e20476f6a6f2077697468206869732052656420616e6420426c75652e2e2053756b756e612077697468206869732064656d6f6e696320737472656e6774682e2e204275636b6c652075702067757973212121f09f9881f09fa7bff09f8c80f09f92a5f09f92aa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d64f2d82-8d6b-48fc-8dcd-286733fa3e28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAT_GOJ0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAT_GOJ0>>(v1);
    }

    // decompiled from Move bytecode v6
}

