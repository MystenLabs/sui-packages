module 0x17e56b23d6ad417375db336e3121cd9bd97de88e026dfdf0db36facec598b66f::quokka {
    struct QUOKKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUOKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUOKKA>(arg0, 6, b"QUOKKA", b"The Quokka", b"Quokka Coin is a fun, community-driven meme coin that captures the cheerful and lighthearted spirit of the quokka, often called the worlds happiest animal. Like the quokkas charming smile, Quokka Coin aims to bring positivity and excitement to the meme coin scene on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Quokka_5b8874d9e8.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUOKKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUOKKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

