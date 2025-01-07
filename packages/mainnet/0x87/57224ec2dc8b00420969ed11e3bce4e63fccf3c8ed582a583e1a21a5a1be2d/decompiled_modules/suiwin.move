module 0x8757224ec2dc8b00420969ed11e3bce4e63fccf3c8ed582a583e1a21a5a1be2d::suiwin {
    struct SUIWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIN>(arg0, 6, b"SUIWIN", b"SuiWin Game Coin", b"This is a collection of cryptocurrency gambling games that ensure fairness and transparency, utilizing SuiNetwork for provably fair random numbers, allowing bets and results to be determined in a single transaction!no KYC!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M2e_Rpx_Fl_400x400_fd18ae914c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

