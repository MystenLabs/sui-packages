module 0xe0d3ca43d12b03cb247ddab71064cb6dc0cbd1d5fc293ae5113dbeaa55b03b8e::enzo {
    struct ENZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENZO>(arg0, 9, b"ENZO", b"Enzo", b"Official token of Enzo the boss of the planet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ENZO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENZO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

