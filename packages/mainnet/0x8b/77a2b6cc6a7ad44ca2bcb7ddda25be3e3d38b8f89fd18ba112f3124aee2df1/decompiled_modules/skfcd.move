module 0x8b77a2b6cc6a7ad44ca2bcb7ddda25be3e3d38b8f89fd18ba112f3124aee2df1::skfcd {
    struct SKFCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKFCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKFCD>(arg0, 6, b"SKFCD", b"SUIKFCDOG", b"KFC dogs on the Sui chain Ni bien ni mal solo existiendo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KFC_DOG_4ae5668231.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKFCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKFCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

