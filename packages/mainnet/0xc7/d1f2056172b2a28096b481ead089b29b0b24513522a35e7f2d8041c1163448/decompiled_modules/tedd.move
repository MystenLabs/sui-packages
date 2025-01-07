module 0xc7d1f2056172b2a28096b481ead089b29b0b24513522a35e7f2d8041c1163448::tedd {
    struct TEDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEDD>(arg0, 9, b"TEDD", b"Teddy Tokens", b"Our sweet and beloved Ted", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1235582736317861888/a-CMEv2U.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEDD>(&mut v2, 2800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEDD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

