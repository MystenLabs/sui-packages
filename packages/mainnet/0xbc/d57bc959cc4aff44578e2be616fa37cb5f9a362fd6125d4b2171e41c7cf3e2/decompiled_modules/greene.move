module 0xbcd57bc959cc4aff44578e2be616fa37cb5f9a362fd6125d4b2171e41c7cf3e2::greene {
    struct GREENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENE>(arg0, 6, b"GREENE", b"Sui Greene", b"Another great meme coin born on sui , just buy and share it with foriends , you can not misss it, because it is Greene .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ab3adeba50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

