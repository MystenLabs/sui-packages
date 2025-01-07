module 0xcb7f72da5511afc45cd8c9f0d5b1b99cc0686cb4f5fb84f7423bfdc70ba312d7::wcdognlad {
    struct WCDOGNLAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCDOGNLAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCDOGNLAD>(arg0, 6, b"WCDOGNLAD", b"WcDognlad On Sui", b" This dogs like the meme king of WcDonalds, where every days a wild ride of burgers, fries, and more memes than you can shake a McFlurry...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_25_54a2bc0f90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCDOGNLAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCDOGNLAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

