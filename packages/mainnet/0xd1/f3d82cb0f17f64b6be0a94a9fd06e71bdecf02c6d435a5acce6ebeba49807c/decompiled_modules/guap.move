module 0xd1f3d82cb0f17f64b6be0a94a9fd06e71bdecf02c6d435a5acce6ebeba49807c::guap {
    struct GUAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUAP>(arg0, 9, b"GUAP", b"GUAP", b"Something majestic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://source.boomplaymusic.com/group10/M00/07/24/a23c9736285741b083f841a58367c9b4.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GUAP>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUAP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

