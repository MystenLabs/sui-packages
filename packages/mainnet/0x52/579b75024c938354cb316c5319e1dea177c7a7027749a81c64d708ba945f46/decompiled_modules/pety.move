module 0x52579b75024c938354cb316c5319e1dea177c7a7027749a81c64d708ba945f46::pety {
    struct PETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETY>(arg0, 9, b"PETY", b"Pete", b"Suiper Pete token is here, merging around the corner to make his way into the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840602851887968256/Yup2w3nd.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PETY>(&mut v2, 7000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETY>>(v1);
    }

    // decompiled from Move bytecode v6
}

