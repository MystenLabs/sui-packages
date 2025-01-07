module 0xfcb6592391b041293a375d7938fd8db3955cf20102ae509eec795c3313165bbc::magadope {
    struct MAGADOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGADOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGADOPE>(arg0, 6, b"MAGADOPE", b"MAGA DOPE", b"MAGADOPE FEELS LIKE DOPAMINE, MAGA DOPE IS A POLITICAL meme that gives us a good feeling. We're going to hit Raydium in less than 3 days for sure. Join our VC, this is more than a meme, its a politify token and I have a community of 370 members that will join the ride with us to the million MC. Be an early buyer before we moon this to the top! BUY AND HOLD to have your daily dose of Dopamine with MAGA DOPE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_7_110c7a71bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGADOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGADOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

