module 0x57bca3395454b74f08baed36852003f83746e1992f3e88a5242993661fa418c5::chepe {
    struct CHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEPE>(arg0, 6, b"Chepe", b"Chad pepe", b"Fair Launch 12.11 18:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731270237402.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

