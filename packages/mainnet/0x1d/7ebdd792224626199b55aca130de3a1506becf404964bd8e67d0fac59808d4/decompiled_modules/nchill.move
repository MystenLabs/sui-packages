module 0x1d7ebdd792224626199b55aca130de3a1506becf404964bd8e67d0fac59808d4::nchill {
    struct NCHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCHILL>(arg0, 6, b"NCHILL", b"Not a Chill Guy", b"Not a chill guy on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U557_F_o_400x400_2fc8b5886c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NCHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

