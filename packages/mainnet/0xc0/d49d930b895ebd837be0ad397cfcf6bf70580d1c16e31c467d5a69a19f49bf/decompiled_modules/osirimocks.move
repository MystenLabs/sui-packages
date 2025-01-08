module 0xc0d49d930b895ebd837be0ad397cfcf6bf70580d1c16e31c467d5a69a19f49bf::osirimocks {
    struct OSIRIMOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSIRIMOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSIRIMOCKS>(arg0, 9, b"OSIRIMOCKS", b"OSIRIMOCK", b"SA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OSIRIMOCKS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSIRIMOCKS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSIRIMOCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

