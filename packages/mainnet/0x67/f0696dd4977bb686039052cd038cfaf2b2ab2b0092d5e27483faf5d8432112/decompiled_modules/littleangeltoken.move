module 0x67f0696dd4977bb686039052cd038cfaf2b2ab2b0092d5e27483faf5d8432112::littleangeltoken {
    struct LITTLEANGELTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITTLEANGELTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITTLEANGELTOKEN>(arg0, 6, b"LittleAngelToken", b"Little Angel", b"Welcome to the next generation of meme coin, the cutest little angel to ever appear on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/486613700_1193156412216637_2172944309279384989_n_13a2faa65d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITTLEANGELTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LITTLEANGELTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

