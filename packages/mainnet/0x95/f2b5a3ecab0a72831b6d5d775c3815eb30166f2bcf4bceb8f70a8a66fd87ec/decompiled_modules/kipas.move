module 0x95f2b5a3ecab0a72831b6d5d775c3815eb30166f2bcf4bceb8f70a8a66fd87ec::kipas {
    struct KIPAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIPAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIPAS>(arg0, 9, b"kipas", b"kipas", b"kipascoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KIPAS>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIPAS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIPAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

