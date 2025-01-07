module 0x9a0e6779d750516dc2c8e786e8f42e82778673b1dfad4e40952f19ada7f34432::suitroll {
    struct SUITROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITROLL>(arg0, 6, b"SuiTroll", b"Sui Troll", b"$SuiTroll is a memebreaking cryptocurrency that embraces the spirit of internet culture. With a strong community and a renounced contract, it aims to bring laughter and fun. Join us on this exciting journey to becoming one of the top meme coins available on thy internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Movepump_3c1b4b1ecd_91df4d9348.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

