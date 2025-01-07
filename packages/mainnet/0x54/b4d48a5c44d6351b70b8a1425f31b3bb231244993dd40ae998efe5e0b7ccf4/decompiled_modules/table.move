module 0x54b4d48a5c44d6351b70b8a1425f31b3bb231244993dd40ae998efe5e0b7ccf4::table {
    struct TABLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TABLE>(arg0, 6, b"TABLE", b"TABLEonSUI", b"Carpentarrer built the most suitable Table on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/table_c2b6449327.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TABLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TABLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

