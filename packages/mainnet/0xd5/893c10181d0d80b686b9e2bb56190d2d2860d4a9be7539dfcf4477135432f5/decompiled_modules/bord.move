module 0xd5893c10181d0d80b686b9e2bb56190d2d2860d4a9be7539dfcf4477135432f5::bord {
    struct BORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORD>(arg0, 9, b"Bord", b"BorderCoin", b"BorderCoin (BORD)  Description: BorderCoin (BORD) is a meme coin inspired by the Border Collie, one of the smartest and most active dog breeds. This meme coin embodies the energy and intelligence of its furry counterpart. BorderCoin is designed for those who love fun and an active lifestyle, both in real life and in the crypto world. This coin was created to unite the community, bring a bit of humor, and still remain a reliable asset for true crypto enthusiasts.  Tagline: \"The smart choice for those who lead the way!\"  Concept: BorderCoin represents the symbol of speed, precision, and reliability, highlighted by the image of the Border Collie. Like this dog breed, BorderCoin is always ahead of the pack, guiding the community toward success and bringing a new level of fun to the world of cryptocurrencies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-photo/funny-portrait-puppy-dog-border-collie-comical-eyeglasses-isolated-white-background_80942-5548.jpg?w=1800")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BORD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

