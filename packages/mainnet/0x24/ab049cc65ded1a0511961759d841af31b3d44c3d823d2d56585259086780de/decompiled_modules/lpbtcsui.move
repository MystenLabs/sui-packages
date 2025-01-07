module 0x24ab049cc65ded1a0511961759d841af31b3d44c3d823d2d56585259086780de::lpbtcsui {
    struct LPBTCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPBTCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPBTCSUI>(arg0, 9, b"LPBTCSUI", b"btcethltcbushobamatrumpbidensui", b"TELEGRAM : https://t.me/belbotbsui WEBSITE : http://btcethltcbushobamatrumpbidensui.xyz/ BTCETHLTCBUSHOBAMATRUMPBIDENSUI  IS LITERALLY A MEME COIN. NO UTILITY. NO ROADMAP. NO PROMISES. NO BULLSHIT. NO EXPECTATION OF FINANCIAL RETURN. JUST 100% MEMES. JUST MOON X100000000000000000000000000000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LPBTCSUI>(&mut v2, 45689984000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPBTCSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LPBTCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

