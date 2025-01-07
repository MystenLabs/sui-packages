module 0x5cf27d504a1b1d183c4426ac7247b3b3da4f77d1b01e33390108edadd8075fbc::sutl {
    struct SUTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUTL>(arg0, 6, b"SUTL", b"Suirtle", b"Legendry Suirtle the guardian of the waters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_4_b843faad21_b91dd5e4f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

