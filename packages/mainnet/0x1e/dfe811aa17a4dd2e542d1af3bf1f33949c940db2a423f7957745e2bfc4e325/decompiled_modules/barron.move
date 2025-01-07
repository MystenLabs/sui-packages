module 0x1edfe811aa17a4dd2e542d1af3bf1f33949c940db2a423f7957745e2bfc4e325::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRON>(arg0, 6, b"Barron", b"Sui Trump son", b"\"The Future is YUGE! Son of Trump CoinBuilt for Bold Moves and Big Gains. Hold, Win, and Make Meme Coins Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014691_ea9358cce4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

