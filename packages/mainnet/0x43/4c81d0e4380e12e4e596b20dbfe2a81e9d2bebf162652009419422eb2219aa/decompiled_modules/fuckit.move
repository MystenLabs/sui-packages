module 0x434c81d0e4380e12e4e596b20dbfe2a81e9d2bebf162652009419422eb2219aa::fuckit {
    struct FUCKIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKIT>(arg0, 9, b"FUCKIT", b"FUCK", b"Fuck to The moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUCKIT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

