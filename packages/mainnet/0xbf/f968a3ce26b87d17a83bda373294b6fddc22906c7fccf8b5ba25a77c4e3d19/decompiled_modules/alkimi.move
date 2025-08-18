module 0xbff968a3ce26b87d17a83bda373294b6fddc22906c7fccf8b5ba25a77c4e3d19::alkimi {
    struct ALKIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALKIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALKIMI>(arg0, 9, b"ALKIMI", b"Alkimi Exchange", b"Alkimi bridges traditional advertising with DeFi (AdFi), creating a decentralised protocol where digital ad spend becomes a yield-generating asset. Built for enterprise scale on Sui, ALKIMI rewards holders through protocol fees, staking, and liquidity provision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.alkimi.org/images/img1_circle.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALKIMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ALKIMI>>(0x2::coin::mint<ALKIMI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ALKIMI>>(v2);
    }

    // decompiled from Move bytecode v6
}

