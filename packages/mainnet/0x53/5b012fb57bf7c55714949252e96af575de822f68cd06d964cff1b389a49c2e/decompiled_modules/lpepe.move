module 0x535b012fb57bf7c55714949252e96af575de822f68cd06d964cff1b389a49c2e::lpepe {
    struct LPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPEPE>(arg0, 9, b"LPEPE", b"LilPepe", b"LilPepe is a meme-inspired token on the Sui network, blending fun with DeFi. Despite its small size, it offers staking, governance, and exclusive Pepe NFTs. Powered by community-driven growth, LilPepe brings serious potential to the meme-token world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1648767224440578060/k1Gch_S-.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LPEPE>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

