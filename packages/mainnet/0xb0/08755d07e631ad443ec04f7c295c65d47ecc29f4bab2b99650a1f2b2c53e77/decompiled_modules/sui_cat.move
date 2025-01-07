module 0xb008755d07e631ad443ec04f7c295c65d47ecc29f4bab2b99650a1f2b2c53e77::sui_cat {
    struct SUI_CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_CAT>(arg0, 9, b"SUI CAT", x"f09f90b153756920436174", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_CAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_CAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

