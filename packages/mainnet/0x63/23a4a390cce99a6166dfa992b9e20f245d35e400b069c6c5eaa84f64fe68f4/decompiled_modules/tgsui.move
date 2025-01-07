module 0x6323a4a390cce99a6166dfa992b9e20f245d35e400b069c6c5eaa84f64fe68f4::tgsui {
    struct TGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGSUI>(arg0, 6, b"TGSUI", b"The guardian of sui", b"the guardian is the first original meme to protect sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241003_134545_dcf9a5e846.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

