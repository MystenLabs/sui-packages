module 0xccb194bea7dee995c7c3272efc716c073c0e98c641f8c7152772196794bc0aa5::enzo {
    struct ENZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENZO>(arg0, 9, b"ENZO", b"ENZO", b"I love you enzo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/474x/9c/1d/76/9c1d7625b0511001ecb6cf26b9d253c8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ENZO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENZO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

