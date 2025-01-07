module 0xb6faf6d5e135c1bc738fdbe0f68d4f08e8ba6a09526663d4338210aca08532af::ac_b_brace {
    struct AC_B_BRACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC_B_BRACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC_B_BRACE>(arg0, 6, b"ac_b_BRACE", b"TicketForLABRACEACCESA", b"Pre sale ticket of bonding curve pool for the following memecoin: LABRACEACCESA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ytimg.com/vi/L-b6sO6rHGI/maxresdefault.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AC_B_BRACE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC_B_BRACE>>(v2, @0x86e3289eada655152a41cb1045c0b26b3ed981eee9529fcdebda70f2c511595a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC_B_BRACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

