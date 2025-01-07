module 0xb0503e4af2c86f67aca1c84a33e2caa91b1858696b24d83a080411b8e627793b::hippotube {
    struct HIPPOTUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOTUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOTUBE>(arg0, 9, b"HIPPOTUBE", b"HIPPOTUBE", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/50450/large/sudeng.png?1727772414")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIPPOTUBE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOTUBE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOTUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

