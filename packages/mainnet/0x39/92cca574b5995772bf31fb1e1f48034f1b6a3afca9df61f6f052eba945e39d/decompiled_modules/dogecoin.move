module 0x3992cca574b5995772bf31fb1e1f48034f1b6a3afca9df61f6f052eba945e39d::dogecoin {
    struct DOGECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGECOIN>(arg0, 6, b"Dogecoin", b"SuiDog", b"SuiDog (DOGE)  the meme coin that's fetching fun on the Sui blockchain! Inspired by the legendary Dogecoin, SuiDog brings the same playful spirit and community vibes, but with a shiny new Sui twist. Get ready to fetch some laughs and ride the meme wave with SuiDog!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dogecoin_5abd553518.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

