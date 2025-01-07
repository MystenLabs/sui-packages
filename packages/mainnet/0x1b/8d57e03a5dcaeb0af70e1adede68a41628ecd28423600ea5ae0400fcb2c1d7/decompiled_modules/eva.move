module 0x1b8d57e03a5dcaeb0af70e1adede68a41628ecd28423600ea5ae0400fcb2c1d7::eva {
    struct EVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVA>(arg0, 9, b"EVA", b"Eva", b"official token of Eva", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EVA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

