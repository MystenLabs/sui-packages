module 0x23865773127fb91e316f69c9a344fc2489df0ca43697fa2fb7d871536248957c::lecoin1 {
    struct LECOIN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LECOIN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LECOIN1>(arg0, 9, b"lc1", b"lecoin1", b"lc1 desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/3b6a7651-03d9-4253-91fc-cb1d62ee5755.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LECOIN1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LECOIN1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

