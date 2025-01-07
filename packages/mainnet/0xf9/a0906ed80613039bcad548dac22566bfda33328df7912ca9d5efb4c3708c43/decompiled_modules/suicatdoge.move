module 0xf9a0906ed80613039bcad548dac22566bfda33328df7912ca9d5efb4c3708c43::suicatdoge {
    struct SUICATDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATDOGE>(arg0, 9, b"SUICATDOGE", b"SUICATDOGE", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICATDOGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATDOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

