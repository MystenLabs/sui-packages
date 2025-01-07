module 0x3d8a976b34225a640a9ca4261a87e9e1cbc6386da86904d0d88feddbf9067a53::koala {
    struct KOALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOALA>(arg0, 6, b"KOALA", b"CryptoKoala", b"CryptoKoala is here to teach everyone what he learned troughout years of trading, if you wanna learn smth Join his tg for more info!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_1_1748ff7654.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

