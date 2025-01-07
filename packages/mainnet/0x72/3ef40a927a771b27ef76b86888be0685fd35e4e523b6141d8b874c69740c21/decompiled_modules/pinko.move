module 0x723ef40a927a771b27ef76b86888be0685fd35e4e523b6141d8b874c69740c21::pinko {
    struct PINKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKO>(arg0, 9, b"PINKO", b"Pinko by Matt Furie", b"Pinko is a full time degen, on a quest to become the 5th member of the boys club. Is it pink?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINKO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

