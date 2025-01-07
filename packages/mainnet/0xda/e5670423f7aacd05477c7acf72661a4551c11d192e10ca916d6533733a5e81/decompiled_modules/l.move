module 0xdae5670423f7aacd05477c7acf72661a4551c11d192e10ca916d6533733a5e81::l {
    struct L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L>(arg0, 6, b"L", b"LoL", b"Lol Lol ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732297381885.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

