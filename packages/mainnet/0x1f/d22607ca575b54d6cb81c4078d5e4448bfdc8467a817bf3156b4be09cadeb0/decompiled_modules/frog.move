module 0x1fd22607ca575b54d6cb81c4078d5e4448bfdc8467a817bf3156b4be09cadeb0::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"HypnoFROG", b"HYPNOFROG is a meme token built on the SUI blockchain that seeks to unite the cryptocurrency and meme community in a fun and accessible format. HYPNOFROG is based on the popular concept of memes and offers participants the opportunity to interact, have fun and perhaps invest in a promising project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hypnotoad_c75c7a3276.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

