module 0xd4cdee32baffc43b305e347dff332f134ed2c3a031151d0d32937b1d96332234::lm {
    struct LM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LM>(arg0, 6, b"LM", b"LumaAI", b"You are different here with the world of artificial intelligence... We will make you a moving machine... Be creative... Here is the beginning ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034918_b36c9aa7c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LM>>(v1);
    }

    // decompiled from Move bytecode v6
}

