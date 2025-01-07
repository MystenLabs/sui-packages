module 0x693008f5bf6494068ff7fb170b96db44eead1f725876f7ca44e1444a2367f084::sstg {
    struct SSTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSTG>(arg0, 9, b"SSTG", b"SuiStrategy", b"Ticker: SSTG  Description: SuiStrategy (SSTG) is a strategic investment token on the Sui blockchain, focused on generating yield through staking and asset allocation across DeFi projects, offering diversified exposure and passive income.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1811343162138308608/G4l_iHsQ.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSTG>(&mut v2, 130000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSTG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

