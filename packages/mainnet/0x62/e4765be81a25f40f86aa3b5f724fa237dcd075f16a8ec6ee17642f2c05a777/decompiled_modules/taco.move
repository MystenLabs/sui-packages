module 0x62e4765be81a25f40f86aa3b5f724fa237dcd075f16a8ec6ee17642f2c05a777::taco {
    struct TACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TACO>(arg0, 6, b"TACO", b"Typical Agendas Chicken Out", b"Yo, fam! You know that legendary 'TACO' meme where big talk turns into a big YEET? $TACO Coin takes that glorious meme and cranks it to ELEVEN! We're talking about those 'Typical Agendas' that promise the moon but bail harder than your crypto portfolio during a flash crash. This ain't your grandpa's meme coin. $TACO is the official anthem for every time someone says 'nah, I'm good' after flexing hard. We're here to laugh at the ultimate plot twist: when the hype train derails into a pile of 'oopsie!' moments. So grab your $TACO, buckle up, and let's watch the world chicken out together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gemini_Generated_Image_tcgi4otcgi4otcgi_1_i_i_i_i_i_eb91e1a406.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

