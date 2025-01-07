module 0x7a6128583db22f18926696b1055b13ccf7809cdc577b929a0388d4cea3ad28d1::maow {
    struct MAOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAOW>(arg0, 6, b"MAOW", b"Maow", b"Maow : Where the future of digital currency meets the rebellious spirit of the internet's favorite Animal-Cats. Enter a world where Neon lights meet feline curiosity and Cryptocurrency infused with the edgy Futuristic of the culture. $Maow isn't just a token it's a movement that blends the aesthetic of Dystopian Tech with the playful energy of cat memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241216_020015_885a28c9c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

