module 0xd1af2b774cd8a58c48a8026276f39c56c29fa04d3857f6b36c11ddde14976c43::terry {
    struct TERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERRY>(arg0, 6, b"TERRY", b"Terry the Goat", b"TERRY IS A FRENCH BOURGEOISIE GOAT WHO LAUNCHED HIMSELF TO MOON SUI. Terry the Goat is an ambitious meme project, looking to build a kingdom on Sui with the help of our community. With a goal of making you laugh, at the heart, we also want to grow together so that we can all be bourgeoisies thanks to the G.O.A.T.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/terry_logo_feec418401.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

