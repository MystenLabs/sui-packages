module 0x9294a29fac8a646daa6168d3d7e0729769a699778f8b9708064af69d7f4f091b::snowhite {
    struct SNOWHITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWHITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWHITE>(arg0, 9, b"SNOWHITE", b"Snow White", b"Live-action adaptation of the 1937 Disney animated film 'Snow White and the Seven Dwarfs'.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/SNOWHITE.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNOWHITE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWHITE>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWHITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

