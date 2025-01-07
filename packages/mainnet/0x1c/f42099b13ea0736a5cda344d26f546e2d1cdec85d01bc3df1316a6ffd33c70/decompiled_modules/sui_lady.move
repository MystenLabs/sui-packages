module 0x1cf42099b13ea0736a5cda344d26f546e2d1cdec85d01bc3df1316a6ffd33c70::sui_lady {
    struct SUI_LADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_LADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_LADY>(arg0, 9, b"SUI LADY", x"f09f9283537569204c616479", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_LADY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_LADY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_LADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

