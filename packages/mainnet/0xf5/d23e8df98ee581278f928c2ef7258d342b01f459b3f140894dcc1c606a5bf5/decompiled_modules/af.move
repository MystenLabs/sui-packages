module 0xf5d23e8df98ee581278f928c2ef7258d342b01f459b3f140894dcc1c606a5bf5::af {
    struct AF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF>(arg0, 6, b"AF", b"ALF", b"ALF ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748630549396.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

