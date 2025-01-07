module 0x8d5612886d1c5aa5d8138949bfde1a7b702f9443356d8ec44c98e36669c8f5b::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"Suishi cat", x"637574652026207461737479202d200a405375694e6574776f726b0a202d2024737569736869206f6e2024737569200a687474703a2f2f742e6d652f737569736869636174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suishi_cat_1cf81be1e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

