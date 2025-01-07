module 0xd0d04bbc508a7fd11d0450bb35d3f6b7ff52fb13a6b61845d596af47c2ecbddc::suikitty {
    struct SUIKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKITTY>(arg0, 9, b"SUIKITTY", b"Suikitty", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIKITTY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKITTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

