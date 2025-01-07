module 0x5a086175140f8e0163929fe86ea31305d523f3bb09bc271607b70d132206f9ab::promotion {
    struct PROMOTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROMOTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROMOTION>(arg0, 6, b"PROMOTION", b"P0D QUEST AI", b"THIS IS P0D QUEST ARTIFICIAL INTELLIGENCE PROMOTION! LAUNCH OCTOBER 22TH | 16:00 PM UTC ON PUMP.FUN ! PREPARED YOUR SOLANA BAGS Website : https://dev-elopstudio.com/podquest Telegram : https://t.me/podquestsolana X : https://x.com/podquestsolana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_12_a22e7d840e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROMOTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROMOTION>>(v1);
    }

    // decompiled from Move bytecode v6
}

