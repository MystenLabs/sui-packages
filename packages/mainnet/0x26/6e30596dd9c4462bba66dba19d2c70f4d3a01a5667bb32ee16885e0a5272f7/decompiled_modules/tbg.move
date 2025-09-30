module 0x266e30596dd9c4462bba66dba19d2c70f4d3a01a5667bb32ee16885e0a5272f7::tbg {
    struct TBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBG>(arg0, 6, b"TBG", b"The Big Pump", b"$SUI its time for The Big Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_09_29_192131_92913dd521.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

