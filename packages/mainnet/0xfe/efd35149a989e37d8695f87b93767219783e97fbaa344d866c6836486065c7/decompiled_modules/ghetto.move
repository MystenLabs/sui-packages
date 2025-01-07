module 0xfeefd35149a989e37d8695f87b93767219783e97fbaa344d866c6836486065c7::ghetto {
    struct GHETTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHETTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHETTO>(arg0, 6, b"GHETTO", b"Sui Ghetto", b"GHETTO king of the deep sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lopy_b010883aa5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHETTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHETTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

