module 0x80ae09a443b394dbcc1ac7af3c19b8a9194dab35c67dd29da9af543e915ba5d8::pacasui {
    struct PACASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACASUI>(arg0, 6, b"PACASUI", b"Paca suinami", b"Al the Alpaca is diving headfirst into the crypto world as the newest face of SUI meme coins. With his flippers steering towards making an upcoming splash on the highly successful PCA Finance site, he aims to glide to an all time high in the meme coin market along the way. Al's journey is all about riding the tides of crypto volatility, winning over fans with his playful yet determined spirit. As the community rallies behind him, Al's rise to victory seems inevitable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_16_at_19_13_38_9f7d6c01fa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

