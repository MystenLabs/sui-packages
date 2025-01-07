module 0x1cacfba454d921e7e934aed207de8ed375c778c2df3924e7552ed78ac771dc82::mery {
    struct MERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERY>(arg0, 9, b"MERY", b"Mystery", b"The Mystery SUI Token is a unique digital asset for exploring DeFi and Web3, offering access to exclusive features, governance participation, and rewards. Its mysterious nature unfolds progressively, adding intrigue as users unlock hidden benefits through staking, liquidity pools, and NFT integrations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1804945506361102336/NWJdI_7F.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MERY>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERY>>(v1);
    }

    // decompiled from Move bytecode v6
}

