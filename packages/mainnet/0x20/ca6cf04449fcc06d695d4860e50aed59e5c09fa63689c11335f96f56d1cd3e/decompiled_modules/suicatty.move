module 0x20ca6cf04449fcc06d695d4860e50aed59e5c09fa63689c11335f96f56d1cd3e::suicatty {
    struct SUICATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATTY>(arg0, 9, b"SUICATTY", b"SUICATTY", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICATTY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

