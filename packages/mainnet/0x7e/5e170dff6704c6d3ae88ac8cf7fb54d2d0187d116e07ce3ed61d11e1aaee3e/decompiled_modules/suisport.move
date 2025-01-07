module 0x7e5e170dff6704c6d3ae88ac8cf7fb54d2d0187d116e07ce3ed61d11e1aaee3e::suisport {
    struct SUISPORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISPORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISPORT>(arg0, 9, b"SUISPORT", b"SUISPORT", b"SUISPORTSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISPORT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISPORT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISPORT>>(v1);
    }

    // decompiled from Move bytecode v6
}

