module 0x8fc6f8fd091817cc76784430fc455b735e6db111156f49bc76a06eb47b7f374f::punk {
    struct PUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNK>(arg0, 6, b"PUNK", b"Punk", b"Just another anti-social punk rocker millenial", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731069405060.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

