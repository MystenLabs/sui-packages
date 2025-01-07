module 0x82a2697ddd9b9115bd9a9369118bae643feb26385f76d6fa8f1443d894bc49e9::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 6, b"PAC", b"PACMOON", b"PACMOON is a Cult & Culture SUI's community memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949814404.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

