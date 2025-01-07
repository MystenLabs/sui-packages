module 0x9bc1edba8981241d64baff4bc8c4f0777ed1b1ced41d34a7238065bdf7954fc8::bukele {
    struct BUKELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUKELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUKELE>(arg0, 6, b"BUKELE", b"BUKELE TRUE HEROE", b"THE FIRST MEME IN THE WORLD by BUKELE. tribute to a true HERO. Nayib Bukele is the first president of a nation in the history of humanity to legalize BTC as a legal currency of circulation in a country in the world. Bukele changed the history of humanity and opened the doors of the world to BTC to become the next largest and most important reserve of value on the planet. BUKELE TRUE HEROE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/btc_2821ad3729.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUKELE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUKELE>>(v1);
    }

    // decompiled from Move bytecode v6
}

