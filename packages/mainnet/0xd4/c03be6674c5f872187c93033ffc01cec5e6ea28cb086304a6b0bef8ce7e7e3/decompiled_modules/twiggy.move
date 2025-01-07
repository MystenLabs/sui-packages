module 0xd4c03be6674c5f872187c93033ffc01cec5e6ea28cb086304a6b0bef8ce7e7e3::twiggy {
    struct TWIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIGGY>(arg0, 6, b"TWIGGY", b"twiggy", b"twiggy the world famous skiing squirrel ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731563730456.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWIGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

