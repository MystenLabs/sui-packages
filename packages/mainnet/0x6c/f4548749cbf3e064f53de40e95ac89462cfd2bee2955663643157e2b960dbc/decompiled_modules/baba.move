module 0x6cf4548749cbf3e064f53de40e95ac89462cfd2bee2955663643157e2b960dbc::baba {
    struct BABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABA>(arg0, 6, b"BABA", b"BABA RAMI ON SUI", b"Rami is the epitome of fun and reliability, always ready for new adventures and a loyal companion on every journey in the Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HAUPT_Sticker_5f8026ddd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

