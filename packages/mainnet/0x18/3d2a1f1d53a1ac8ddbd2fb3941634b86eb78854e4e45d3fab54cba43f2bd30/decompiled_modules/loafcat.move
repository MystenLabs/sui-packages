module 0x183d2a1f1d53a1ac8ddbd2fb3941634b86eb78854e4e45d3fab54cba43f2bd30::loafcat {
    struct LOAFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOAFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOAFCAT>(arg0, 6, b"LOAFCAT", b"LOAFCAT SUI", b"Freshly baked from the bakery ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spinning_loaf_df17e32b76.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOAFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOAFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

