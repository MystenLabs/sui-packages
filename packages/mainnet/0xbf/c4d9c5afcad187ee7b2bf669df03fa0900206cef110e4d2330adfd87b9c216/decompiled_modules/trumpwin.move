module 0xbfc4d9c5afcad187ee7b2bf669df03fa0900206cef110e4d2330adfd87b9c216::trumpwin {
    struct TRUMPWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWIN>(arg0, 6, b"TrumpWIN", b"WIN", b"Trump must win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_569_2d454d0a1c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

