module 0x37f5189ff3d265a396994e45f25ea8debb04658b9177d677bfbdfd874ea85b13::wonkey {
    struct WONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONKEY>(arg0, 6, b"Wonkey", b"water monkey", b"Wonkey Wonk ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bildschirmfoto_2024_09_26_um_15_06_06_fb532fdf4c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

