module 0x72483a750aaa72020dfb74ce91a1acd2a21a6bd70d1d9a97659d3b9413a286db::peace {
    struct PEACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACE>(arg0, 6, b"PEACE", b"peace", b"all we want is peace ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peace_sign_logo_8_F850349_C9_seeklogo_com_2b15aaeaee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

