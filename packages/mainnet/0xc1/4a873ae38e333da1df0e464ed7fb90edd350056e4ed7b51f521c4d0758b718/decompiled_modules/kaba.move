module 0xc14a873ae38e333da1df0e464ed7fb90edd350056e4ed7b51f521c4d0758b718::kaba {
    struct KABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABA>(arg0, 6, b"KABA", b"Japan's Moo Deng", b"(Kaba): Believe it or not, these hippo boats are REAL! They cruise the waters of Japan, and now they're taking over the internet as the newest meme sensation. Get ready for cuteness overload with (Kaba)!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/532112312131231_74a2a17d56.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

