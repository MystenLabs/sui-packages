module 0x3717986c988d470f2d21e8a593a6f23c916a36b28c0c7ae522d8ee18329d4c3b::thegwilla {
    struct THEGWILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEGWILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEGWILLA>(arg0, 6, b"THEGWILLA", b"THEGWILLASUI", b" A Different Breed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WLD_Ez_ny_400x400_997db63e85.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEGWILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEGWILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

