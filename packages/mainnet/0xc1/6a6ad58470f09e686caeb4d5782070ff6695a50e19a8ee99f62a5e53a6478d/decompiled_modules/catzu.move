module 0xc16a6ad58470f09e686caeb4d5782070ff6695a50e19a8ee99f62a5e53a6478d::catzu {
    struct CATZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZU>(arg0, 6, b"CATZU", b"Catzu On Sui", b"The three legged meme Cat! - Real Story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017523_aa4087a1ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

