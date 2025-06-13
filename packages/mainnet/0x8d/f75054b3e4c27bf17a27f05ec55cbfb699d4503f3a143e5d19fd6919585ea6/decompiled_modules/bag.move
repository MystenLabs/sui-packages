module 0x8df75054b3e4c27bf17a27f05ec55cbfb699d4503f3a143e5d19fd6919585ea6::bag {
    struct BAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAG>(arg0, 9, b"SYMBOL", b"SYMBOL", b"DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"url")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BAG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

