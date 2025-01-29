module 0x187854fc7f0d968f90fa789c4da826c4462c5e3c0603854f4ea93befd48aad67::meowcoin {
    struct MEOWCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWCOIN>(arg0, 6, b"MEOWCOIN", b"meow meme coin", b"Meow Meme Coin: Where feline fun meets digital finance.Join the meow meme coin community and lets make some waves together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_WA_0019_e78b1b40e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

