module 0x83aba1a768fab06dc28f12010c63558cfce10792ed6b30a954dcffd857b28ddc::suiwhale {
    struct SUIWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWHALE>(arg0, 6, b"SUIWHALE", b"suiwhale", x"42652070617274206f6620746865205768616c6520696e2074686520426f7820436f6d6d756e697479200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x6b56e688acc6b4b3e0e60143d77af6c2cccf719c_624aaebacc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

