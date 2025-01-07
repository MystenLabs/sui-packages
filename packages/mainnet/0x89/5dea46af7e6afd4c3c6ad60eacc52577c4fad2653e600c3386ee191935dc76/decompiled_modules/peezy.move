module 0x895dea46af7e6afd4c3c6ad60eacc52577c4fad2653e600c3386ee191935dc76::peezy {
    struct PEEZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEZY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PEEZY>(arg0, 6, b"PEEZY", b"PEEZY ON SUIAI", b"IT'S PEEZY COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_peezy_2659d777b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEEZY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEZY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

