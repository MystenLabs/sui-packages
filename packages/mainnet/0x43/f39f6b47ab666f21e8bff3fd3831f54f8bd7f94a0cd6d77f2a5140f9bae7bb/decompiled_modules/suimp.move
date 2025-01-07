module 0x43f39f6b47ab666f21e8bff3fd3831f54f8bd7f94a0cd6d77f2a5140f9bae7bb::suimp {
    struct SUIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMP>(arg0, 6, b"Suimp", b"suimpsons", b"One day, Homer overhears gossip at Moes Tavern about SUI Coin, the meme coin that can make you rich. Without a second thought, he uses the family savings to buy SUI! Marge panics, while Bart and Lisa start making memes to promote it, and Maggie? She becomes the SUI Coin mascot! It turns out this chaos goes viral, and the whole of Springfield becomes obsessed with SUI, making it the hottest meme coin in town!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimpsons_664628fd9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

