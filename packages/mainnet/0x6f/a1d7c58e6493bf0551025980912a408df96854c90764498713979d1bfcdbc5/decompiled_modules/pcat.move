module 0x6fa1d7c58e6493bf0551025980912a408df96854c90764498713979d1bfcdbc5::pcat {
    struct PCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCAT>(arg0, 6, b"PCAT", b"POORCAT", b"Kucing got", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/img_20200914_005017_db1a3a1da93b0e121cdfce2cd8cb328d_f0e9f449e09e34a1a6f9155185f4c680_d55a7e9acf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

