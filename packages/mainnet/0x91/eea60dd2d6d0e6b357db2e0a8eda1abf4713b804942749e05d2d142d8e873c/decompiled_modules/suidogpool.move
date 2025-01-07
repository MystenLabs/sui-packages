module 0x91eea60dd2d6d0e6b357db2e0a8eda1abf4713b804942749e05d2d142d8e873c::suidogpool {
    struct SUIDOGPOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGPOOL>(arg0, 6, b"SuiDogPool", b"Sui DogPool", b"Dogpool Coin: Unleashing Meme-Powered Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_05_11_05_626f84d2fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGPOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGPOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

