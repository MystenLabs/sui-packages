module 0x40d3125304fbc85880296428e3b173ca571130d6dd52865db403db3cdb56aad9::plnm {
    struct PLNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLNM>(arg0, 9, b"PLNM", b"Planemo", b"AlwaysEvolve", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLNM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLNM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

