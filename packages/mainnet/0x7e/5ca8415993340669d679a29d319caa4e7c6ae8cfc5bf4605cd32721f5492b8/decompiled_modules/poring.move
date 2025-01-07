module 0x7e5ca8415993340669d679a29d319caa4e7c6ae8cfc5bf4605cd32721f5492b8::poring {
    struct PORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORING>(arg0, 9, b"PORING", b"Poring", b"Sui Poring To the Moon Sui Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841719565891280896/ORpHqwRx_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PORING>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORING>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORING>>(v1);
    }

    // decompiled from Move bytecode v6
}

