module 0x81229ab828a942d3c796e0943d7431ed99899803eec15f74a89671fed9e8c32b::lotus {
    struct LOTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOTUS>(arg0, 9, b"LOTUS", b"Lotus Finance", b"Trading strategy protocol on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1849821984810516480/H3JLat54_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOTUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LOTUS>>(0x2::coin::mint<LOTUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOTUS>>(v2);
    }

    // decompiled from Move bytecode v6
}

