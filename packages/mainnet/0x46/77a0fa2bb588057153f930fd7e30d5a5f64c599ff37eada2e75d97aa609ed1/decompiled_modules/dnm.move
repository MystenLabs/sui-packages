module 0x4677a0fa2bb588057153f930fd7e30d5a5f64c599ff37eada2e75d97aa609ed1::dnm {
    struct DNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNM>(arg0, 6, b"DNM", b"Don't Mices", b"By stopping the hunting and trading of wild animals, we not only protect vulnerable species but also create a crucial barrier against the emergence and spread of new diseases. This protective approach benefits both wildlife conservation and global public health security.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/62c91313_6839_460d_a18f_2ec86d7a664d_3157fbc1ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

