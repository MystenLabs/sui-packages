module 0xb74f8b378fef712972a80d83a086f0d7a4d738eb5c6578866b6fe768f104ce33::chile {
    struct CHILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILE>(arg0, 9, b"chile", b"chile", b"chileee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHILE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

