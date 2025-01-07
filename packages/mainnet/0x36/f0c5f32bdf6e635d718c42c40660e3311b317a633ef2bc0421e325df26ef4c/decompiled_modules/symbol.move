module 0x36f0c5f32bdf6e635d718c42c40660e3311b317a633ef2bc0421e325df26ef4c::symbol {
    struct SYMBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYMBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYMBOL>(arg0, 6, b"Symbol", b"Name", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_1_31ab96c9d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYMBOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYMBOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

