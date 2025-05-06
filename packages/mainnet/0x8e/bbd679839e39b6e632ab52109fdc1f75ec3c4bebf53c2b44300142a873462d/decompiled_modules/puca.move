module 0x8ebbd679839e39b6e632ab52109fdc1f75ec3c4bebf53c2b44300142a873462d::puca {
    struct PUCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCA>(arg0, 6, b"PUCA", b"Purple Cat", x"486579212c206d79206e616d6527732050554341202049276d20612063617420616e642049276d20707572706c652c2070757272205e5f5e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/puca_logo_c349a088b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

