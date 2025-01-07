module 0x63ff24bf8e37f272c62bdf7967e6d6c644adc88bc2a3e3cb642a4bf3a5187972::trumpei {
    struct TRUMPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPEI>(arg0, 6, b"TRUMPEI", b"Trumpei on SUI", b"The electrifying meme coin on the SUI blockchain featuring Donald Trump wearing a traditional Vietnamese hat, TRUMPEI combines political satire with cultural flair for a truly unique digital currency. Perfect for meme lovers and crypto enthusiasts, TRUMPEI brings a fresh and humorous twist to the world of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_11_17_17_08_832a04d626.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

