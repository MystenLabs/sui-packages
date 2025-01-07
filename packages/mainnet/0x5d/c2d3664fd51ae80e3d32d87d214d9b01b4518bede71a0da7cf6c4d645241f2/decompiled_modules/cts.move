module 0x5dc2d3664fd51ae80e3d32d87d214d9b01b4518bede71a0da7cf6c4d645241f2::cts {
    struct CTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTS>(arg0, 6, b"CTS", b"CETUS TOKEN", b"the first cetus token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000345529_296b49ca97.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

