module 0x932e670cdfbcee65b99e9f8129f95df2d4fb449fc45c24ef11299f88fc546535::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIN>(arg0, 6, b"SUIJIN", b"SuiJin", x"245355494a494e0a0a4a6170616e65736520676f6464657373206f662077617465722c20656d626f6479696e6720666c6f772c2061646170746162696c6974792c20616e642070726f737065726974792e2044657369676e656420666f72207468652053756920626c6f636b636861696e2c205375694a696e20636f6d62696e65732063756c747572616c207265766572656e636520776974682063757474696e672d6564676520746563686e6f6c6f677920746f20637265617465206120746f6b656e207468617420697320626f746820706c617966756c20616e6420706f77657266756c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6318974517346682299_211f14335f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

