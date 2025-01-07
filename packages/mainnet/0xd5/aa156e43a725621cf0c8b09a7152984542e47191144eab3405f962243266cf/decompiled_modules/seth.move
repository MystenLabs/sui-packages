module 0xd5aa156e43a725621cf0c8b09a7152984542e47191144eab3405f962243266cf::seth {
    struct SETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SETH>(arg0, 6, b"SETH", b"Suithereum", b"CTO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_e319d2fd02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

