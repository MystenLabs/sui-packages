module 0x62f5f3fa93109b2582c41f228500c192930ebd3876614d6a5d572593b47b034d::code {
    struct CODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODE>(arg0, 9, b"CODE", b"Code Token", b"A token for coding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CODE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

