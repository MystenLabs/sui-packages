module 0xf7eafd3308d25a9004a12939dd0e092e850366a628f0c1d5edfef016c194b19d::suibitch {
    struct SUIBITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBITCH>(arg0, 9, b"suibitch", b"suibitch", b"suibitch is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBITCH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBITCH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

