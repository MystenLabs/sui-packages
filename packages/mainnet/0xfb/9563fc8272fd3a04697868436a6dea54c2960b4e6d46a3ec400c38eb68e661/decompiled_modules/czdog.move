module 0xfb9563fc8272fd3a04697868436a6dea54c2960b4e6d46a3ec400c38eb68e661::czdog {
    struct CZDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZDOG>(arg0, 6, b"CZDOG", b"CZ DOG", b"CZ Dog ($CZDOG) is the ultimate tribute to the legend himselfCZ of Binance! Inspired by the crypto kings vision, this meme coin blends the spirit of decentralization with unstoppable DOGE energy. Whether you're hodling, trading, or just vibing in the crypto space, $CZDOG is here to lead the pack. With the loyalty of a Shiba and the strategy of a true Binance master, this dog is ready to run wild in the markets! Get ready for moon missions and meme-fueled madnessbecause in CZ we trust!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/main_2d9b0737c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

