module 0x300bc3fbfbcc6372a8bca5006284c96a817c8e954408849e701aea00e5755f7a::suicoin {
    struct SUICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOIN>(arg0, 9, b"SUICOIN", b"SUICOIN", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICOIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

