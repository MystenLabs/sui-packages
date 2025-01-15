module 0xd4553bd279fbb3227c923bccb15f9501337d57b7aa7fd88a38125de8a268fd03::block {
    struct BLOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOCK>(arg0, 9, b"block", b"block AI", b"Create with AI $block revolutionise crypto management with  AItoken bots. Create, Own, Monetized Apps, Agents and Staking using the AI tech powered by $block", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQwqMtrcdFbGS5prFEkgMFitdB67nHKpxbyyavHbFgrkF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLOCK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOCK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

