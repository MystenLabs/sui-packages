module 0xc9f4acc698c8207a8fb42c90a8e004278bbb0da1dbaaf6198c2bcaea71867318::trumpus {
    struct TRUMPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPUS>(arg0, 6, b"TRUMPUS", b"Trumpus Maximus", b"Trumpus Maximus, the supreme ruler of the United States of America.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735769228304.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

