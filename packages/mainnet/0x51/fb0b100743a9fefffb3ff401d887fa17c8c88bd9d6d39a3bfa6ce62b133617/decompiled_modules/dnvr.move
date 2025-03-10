module 0x51fb0b100743a9fefffb3ff401d887fa17c8c88bd9d6d39a3bfa6ce62b133617::dnvr {
    struct DNVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNVR>(arg0, 9, b"DNVR", b"Denver City", b"Denver City Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DNVR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNVR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNVR>>(v1);
    }

    // decompiled from Move bytecode v6
}

