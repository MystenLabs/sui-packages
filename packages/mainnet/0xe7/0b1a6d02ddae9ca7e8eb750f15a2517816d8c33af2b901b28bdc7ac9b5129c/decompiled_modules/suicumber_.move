module 0xe70b1a6d02ddae9ca7e8eb750f15a2517816d8c33af2b901b28bdc7ac9b5129c::suicumber_ {
    struct SUICUMBER_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUMBER_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUMBER_>(arg0, 9, b"Suicumber", b"Suicumber", b"ee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICUMBER_>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUMBER_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUMBER_>>(v1);
    }

    // decompiled from Move bytecode v6
}

