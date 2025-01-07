module 0x704ca20d56c186b00c65c97178826a7d2190e6f0099746ef9fa4e2c578d5e0fd::sjoker {
    struct SJOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJOKER>(arg0, 6, b"Sjoker", b"Suidartio", b"Retardio on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gereryeryer_c0ad1f3583.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SJOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

