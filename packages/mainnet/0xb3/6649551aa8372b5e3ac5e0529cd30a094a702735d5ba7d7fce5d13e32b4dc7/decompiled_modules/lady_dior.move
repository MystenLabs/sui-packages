module 0xb36649551aa8372b5e3ac5e0529cd30a094a702735d5ba7d7fce5d13e32b4dc7::lady_dior {
    struct LADY_DIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADY_DIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADY_DIOR>(arg0, 9, b"LADY DIOR", x"f09f919b4c6164792044696f72", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LADY_DIOR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADY_DIOR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADY_DIOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

