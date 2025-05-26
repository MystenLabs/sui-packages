module 0x4ee28f894879228a497c11fe34fbf974a51e9e5bc79ca3a1ff117030c709be1f::mbtc {
    struct MBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBTC>(arg0, 6, b"MBTC", b"Merlin BTC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

