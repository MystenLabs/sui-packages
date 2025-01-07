module 0xd26e79c63b6cc51bdbcafb58eb497a4604264ffce70b997b7cda8b961fb1c4ba::coce {
    struct COCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCE>(arg0, 6, b"COCE", b"Crocodile", b"i  am  Crocodile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1728981798833_e94cdceca4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

