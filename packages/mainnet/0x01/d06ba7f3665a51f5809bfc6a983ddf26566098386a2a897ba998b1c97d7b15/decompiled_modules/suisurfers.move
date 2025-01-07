module 0x1d06ba7f3665a51f5809bfc6a983ddf26566098386a2a897ba998b1c97d7b15::suisurfers {
    struct SUISURFERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISURFERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISURFERS>(arg0, 6, b"SUISURFERS", b"Sui Surfers", b"Introducing \"Sui Surfers\" the ultimate meme coin inspired by the popular mobile game \"Subway Surfers\"! Ride the waves of the crypto market just like Jake and his friends dodge trains. Sui Surfers is all about fun, speed, and nostalgia.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733755055743.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISURFERS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISURFERS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

