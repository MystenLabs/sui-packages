module 0x35810fa8fc002dec0efd6fa26bd76f7176d26fb99b22a16a97d60f583904e620::honk {
    struct HONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONK>(arg0, 6, b"HONK", b"Honk On Sui", b"Remember the Honk meme? The audacious goose that originated from the viral video game \"Untitled Goose Game\" and ultimately became an internet sensation? This iconic goose, known for its desire to be a boss, became one of the most iconic memes on the internet. Also known as the BONK true rival", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_c160cbf0ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

