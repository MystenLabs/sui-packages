module 0x70a21bddcf72a5d0b3e9ce92a0bd9ddf685d213c0acda0bc291912bfdf53d7bb::tocat {
    struct TOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOCAT>(arg0, 6, b"TOCAT", b"Tongue Cat", b"Tocat Coin is the next-generation memecoin inspired by the Internets favorite phenomenon: the adorable, tongue-out blep expression cats make!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020320_5868ca1b10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

