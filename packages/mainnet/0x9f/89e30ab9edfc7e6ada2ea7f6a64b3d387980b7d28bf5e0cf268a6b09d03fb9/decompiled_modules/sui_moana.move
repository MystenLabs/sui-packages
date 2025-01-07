module 0x9f89e30ab9edfc7e6ada2ea7f6a64b3d387980b7d28bf5e0cf268a6b09d03fb9::sui_moana {
    struct SUI_MOANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_MOANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_MOANA>(arg0, 9, b"SUI MOANA", x"f09f8cba537569204d6f616e61", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_MOANA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_MOANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_MOANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

