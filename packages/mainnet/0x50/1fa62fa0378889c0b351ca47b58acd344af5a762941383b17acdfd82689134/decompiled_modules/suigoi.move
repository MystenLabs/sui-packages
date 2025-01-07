module 0x501fa62fa0378889c0b351ca47b58acd344af5a762941383b17acdfd82689134::suigoi {
    struct SUIGOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOI>(arg0, 9, b"SUIGOI", b"suigoi", b"SUBARASHI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGOI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

