module 0x5b219d3c2d02766b57bc24de5f2468d9c9938305d1909331770f5ab036ab311b::suiai {
    struct SUIAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIAI>, arg1: 0x2::coin::Coin<SUIAI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<SUIAI>(&arg1) >= arg2, 0);
        0x2::coin::burn<SUIAI>(arg0, 0x2::coin::split<SUIAI>(&mut arg1, arg2, arg3));
        if (0x2::coin::value<SUIAI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIAI>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIAI>(arg1);
        };
    }

    fun init(arg0: SUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1654120529119571973/9p7rU6Yj_400x400.jpg"));
        let v1 = 0x2::tx_context::sender(arg1);
        let (v2, v3) = 0x2::coin::create_currency<SUIAI>(arg0, 6, b"SAI", b"SUIAI GPT", b"SUIAI GPT is a project built on SuiNetwork with a diverse ecosystem including: AI, NFTs, Web3, SocialFi.", v0, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUIAI>(&mut v4, 690139420000000000, v1, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAI>>(v4, v1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAI>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIAI>(arg0, arg1, arg2, arg3);
    }

    public entry fun multi_burn(arg0: &mut 0x2::coin::TreasuryCap<SUIAI>, arg1: vector<0x2::coin::Coin<SUIAI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIAI>>(&mut arg1);
        0x2::pay::join_vec<SUIAI>(&mut v0, arg1);
        assert!(0x2::coin::value<SUIAI>(&v0) >= arg2, 0);
        0x2::coin::burn<SUIAI>(arg0, 0x2::coin::split<SUIAI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIAI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIAI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIAI>(v0);
        };
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIAI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIAI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

