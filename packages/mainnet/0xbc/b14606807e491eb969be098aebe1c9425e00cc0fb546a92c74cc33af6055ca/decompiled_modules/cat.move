module 0xbcb14606807e491eb969be098aebe1c9425e00cc0fb546a92c74cc33af6055ca::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"Confidence, Acceptance, Tranquility", b"Meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.inspiremore.com/wp-content/uploads/2022/03/cute-cats-11.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAT>(&mut v2, 4200000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

