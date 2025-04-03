module 0x198c07aff4db2d19482f0ec8b9cb082f87a1b5fa7f5a4644e0893cbc00c20b0d::tjtoken {
    struct TJTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJTOKEN>(arg0, 6, b"TJtoken", b"tom and jerry", b"Welcome to the next generation of meme coins, join the journey of tom and jerry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/487043053_1605932233453324_9162250011966436365_n_207eda82b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TJTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

