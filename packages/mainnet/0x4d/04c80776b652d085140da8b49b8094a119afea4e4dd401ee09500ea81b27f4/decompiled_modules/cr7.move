module 0x4d04c80776b652d085140da8b49b8094a119afea4e4dd401ee09500ea81b27f4::cr7 {
    struct CR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7>(arg0, 9, b"CR7", b"RONALDOFT", x"437269737469616e6f20526f6e616c646f2046616e20546f6b656e2028435237292069732074686520756c74696d617465206d656d6520746f6b656e20666f722066616e732077686f2077616e7420746f20666c657820746865697220474f4154206c6f79616c74792077697468207374796c6521204e6f207265616c2d776f726c64207574696c6974792c206e6f2067756172616e74656573e280946a75737420707572652066756e20616e64206c6567656e646172792076696265732e20486f6c642043523720616e642073686f772074686520776f726c6420796f75e280997265207465616d20526f6e616c646f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a61e963b-6ec3-496e-829a-e94dac80f363.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR7>>(v1);
    }

    // decompiled from Move bytecode v6
}

