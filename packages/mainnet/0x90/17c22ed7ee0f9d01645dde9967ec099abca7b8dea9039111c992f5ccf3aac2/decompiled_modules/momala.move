module 0x9017c22ed7ee0f9d01645dde9967ec099abca7b8dea9039111c992f5ccf3aac2::momala {
    struct MOMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMALA>(arg0, 6, b"MOMALA", b"KAMALA COIN (MOMALA)", b"A unique and spirited digital currency created to celebrate and honor the remarkable achievements of Vice President Kamala Harris. As a meme coin built on the innovative Sui Blockchain, The Kamala Coin represents a community-driven initiative that merges the worlds of cryptocurrency and public admiration for one of America's foremost political figures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Coin_512x512_8ac273d0d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

