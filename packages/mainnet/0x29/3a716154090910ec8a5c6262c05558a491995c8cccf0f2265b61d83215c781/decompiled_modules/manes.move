module 0x293a716154090910ec8a5c6262c05558a491995c8cccf0f2265b61d83215c781::manes {
    struct MANES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANES>(arg0, 6, b"MANES", b"Mafia Manes", b"he MafiaManes Token ($MANES) represents power and loyalty within the MafiaManes ecosystem. Holders access exclusive features, participate in governance, and stake for rewards. $MANES drives community growth, offering incentives and rewards to participants.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240913234704_658b1a290c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANES>>(v1);
    }

    // decompiled from Move bytecode v6
}

