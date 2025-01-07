module 0x8ca2d3421ebda4140bc8bf43c844c69923207d694ea88385b1024e906530cb12::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 9, b"HYPE", b"HYPE OF DAY", b"HYPE OF HOUR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://elcamperos.pl/wp-content/uploads/2023/04/hype.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HYPE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

