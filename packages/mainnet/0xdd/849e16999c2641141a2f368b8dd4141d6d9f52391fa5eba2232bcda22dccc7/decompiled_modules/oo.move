module 0xdd849e16999c2641141a2f368b8dd4141d6d9f52391fa5eba2232bcda22dccc7::oo {
    struct OO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OO>(arg0, 7, b"oo", b"oo", b"fjasjgsda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OO>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OO>>(v1);
    }

    // decompiled from Move bytecode v6
}

