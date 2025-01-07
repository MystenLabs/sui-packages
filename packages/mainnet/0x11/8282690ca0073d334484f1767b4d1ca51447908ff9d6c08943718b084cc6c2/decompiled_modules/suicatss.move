module 0x118282690ca0073d334484f1767b4d1ca51447908ff9d6c08943718b084cc6c2::suicatss {
    struct SUICATSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATSS>(arg0, 9, b"SUICATSS", b"SUICATSS", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICATSS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATSS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

