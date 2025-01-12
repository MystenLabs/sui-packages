module 0x36fc8216e32cae0f09373344e74631aa64012cd16a577c0d79506f1611cfb988::pepeta {
    struct PEPETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPETA>(arg0, 6, b"Pepeta", b"PEPETA", b"Pepeta the Pepe wife", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5666_01762a415a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPETA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPETA>>(v1);
    }

    // decompiled from Move bytecode v6
}

