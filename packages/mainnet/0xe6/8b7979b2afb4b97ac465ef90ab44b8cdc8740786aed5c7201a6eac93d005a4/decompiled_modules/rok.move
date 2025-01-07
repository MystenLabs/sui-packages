module 0xe68b7979b2afb4b97ac465ef90ab44b8cdc8740786aed5c7201a6eac93d005a4::rok {
    struct ROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROK>(arg0, 6, b"ROK", b"ROKMAS", b"Its xmas for rockers!  Merry merry, ho ho ho, muthafugga!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/851fb3d7_fdf0_4ca0_b44f_cabba40a3f34_e3d174f12f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

