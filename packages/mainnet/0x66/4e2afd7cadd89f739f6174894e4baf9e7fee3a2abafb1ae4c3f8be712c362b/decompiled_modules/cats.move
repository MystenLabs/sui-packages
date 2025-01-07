module 0x664e2afd7cadd89f739f6174894e4baf9e7fee3a2abafb1ae4c3f8be712c362b::cats {
    struct CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS>(arg0, 9, b"CATS", b"CATS", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mimi-panda.com/wp-content/uploads/2024/03/cats-coloring-pages-2-250x250.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

