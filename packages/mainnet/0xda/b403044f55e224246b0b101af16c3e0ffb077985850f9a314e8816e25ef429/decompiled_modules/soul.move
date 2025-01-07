module 0xdab403044f55e224246b0b101af16c3e0ffb077985850f9a314e8816e25ef429::soul {
    struct SOUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUL>(arg0, 6, b"Soul", b"Soulgraph", x"61757261202620696e66726120666f722068756d616e2d6167656e7420696e746572616374696f6e0a0a6275696c74206279200a407234646963616c63656e747269736d0a0a0a646f6373202d2068747470733a2f2f736f756c67726170682e676974626f6f6b2e696f2f736f756c67726170682d646f6373", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9do_RR_Aik5gvhb_Ewjb_Z_Db_ZR_6_Gx_XS_Afdoomy_JR_57x_Kpump_c8fa009f04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

