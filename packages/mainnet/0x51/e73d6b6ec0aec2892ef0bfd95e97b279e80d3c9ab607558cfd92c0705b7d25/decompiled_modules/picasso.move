module 0x51e73d6b6ec0aec2892ef0bfd95e97b279e80d3c9ab607558cfd92c0705b7d25::picasso {
    struct PICASSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICASSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICASSO>(arg0, 9, b"PICASSO", x"f09f96bcefb88f5069636173736f", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PICASSO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICASSO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICASSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

