module 0x1c1a232818dad1e7649098018ab8e55eaff3697825080bb99635d88b1840718::posuidon {
    struct POSUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSUIDON>(arg0, 6, b"POSUIDON", b"PoSuiDon", b"PoSUIdon the Lord of all Seas and Oceans the real OG of Atlantis put some respect on his name when you are talking to him!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736203580198.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POSUIDON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSUIDON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

