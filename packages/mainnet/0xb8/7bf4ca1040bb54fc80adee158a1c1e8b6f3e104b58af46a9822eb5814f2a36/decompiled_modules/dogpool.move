module 0xb87bf4ca1040bb54fc80adee158a1c1e8b6f3e104b58af46a9822eb5814f2a36::dogpool {
    struct DOGPOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGPOOL>(arg0, 6, b"DOGPOOL", b"SUI DOGPOOL", b"Sui top meme dog is here, the badass hero villian that combines crypto and meme together.  Dogpool Coin is the ultimate tribute to the Regenerating Degenerate, combining his unpredictable nature with cutting-edge blockchain technology to give rewards and gain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_20_57_59_6dcf118750.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGPOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGPOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

