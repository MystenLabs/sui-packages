module 0xb4daaacb0c790119a99f4b07111feec5d091e92194fdfcfb710cb91daee0b277::suimonscat {
    struct SUIMONSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONSCAT>(arg0, 6, b"SUIMONSCAT", b"SuimonsCat", b"ONE CAT, BILLIONS OF OWNERS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953080933.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMONSCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONSCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

