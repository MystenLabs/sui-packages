module 0x40b6804a86919e494b4297b656d53ee8f40740146be8062fa7db277562744042::gt {
    struct GT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GT>(arg0, 6, b"GT", b"The King Gator", x"536f6d652070656f706c65207361792074686174207468652041676772696761746f722077617320626f726e2066726f6d2074686520647265616d206f662061206d616420646567656e2077697a6172640a0a536f6d652070656f706c65207361792074686174205468652041676772696761746f72206973206a75737420612067757920696e206120737569742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_03_at_9_15_35a_am_0d88e5b8a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GT>>(v1);
    }

    // decompiled from Move bytecode v6
}

