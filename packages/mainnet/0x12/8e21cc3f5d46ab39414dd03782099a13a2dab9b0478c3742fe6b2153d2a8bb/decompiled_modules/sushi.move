module 0x128e21cc3f5d46ab39414dd03782099a13a2dab9b0478c3742fe6b2153d2a8bb::sushi {
    struct SUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSHI>(arg0, 6, b"Sushi", b"SUISHI", x"5375692061706573206172652068756e6772792e200a0a24737569736869", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3984_e33249647b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

