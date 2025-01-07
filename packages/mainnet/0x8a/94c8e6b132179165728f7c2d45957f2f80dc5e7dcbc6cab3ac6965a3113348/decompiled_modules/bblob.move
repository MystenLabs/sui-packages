module 0x8a94c8e6b132179165728f7c2d45957f2f80dc5e7dcbc6cab3ac6965a3113348::bblob {
    struct BBLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBLOB>(arg0, 6, b"BBLOB", b"BABY BLOB", b"ready to take your first bblob?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_182353300_f80f9b449d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

