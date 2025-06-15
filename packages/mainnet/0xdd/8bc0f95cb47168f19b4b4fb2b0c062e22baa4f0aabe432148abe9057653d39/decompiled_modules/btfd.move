module 0xdd8bc0f95cb47168f19b4b4fb2b0c062e22baa4f0aabe432148abe9057653d39::btfd {
    struct BTFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTFD>(arg0, 6, b"BTFD", b"B.T.F.D", b" BTFD (Buy The F***ing Dip) is the ultimate meme coin for degens who know when to strike! Built for the bold, an engaging Telegram-based P2E game, and a strong, growing community. Dont miss your chance to join the Bulls Squad and ride the wave! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x6aabbce679815974580de2875a22aff3deba1ba8_74991a9c23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

