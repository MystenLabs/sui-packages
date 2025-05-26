module 0x3e3116ccee731cc7d541c8cfb9607ea28443d5980c67528a141421747495a1a7::vuongthiscoin {
    struct VUONGTHISCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUONGTHISCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VUONGTHISCOIN>(arg0, 6, b"VUONGTHISCOIN", b"VUONG THI TAM XUAN Coin", x"412072656d696e646572206f6620636865726973686564206d6f6d656e74732073686172656420696e206c6f76653b206120746f6b656e206f6620657465726e616c206d656d6f7269657320776974682056554f4e47205448492054414d205855414e20f09f9297205b4149204d656d65202d2042792053756941495d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/hQ1iLx.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VUONGTHISCOIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUONGTHISCOIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

