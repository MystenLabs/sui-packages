module 0x5c5500bcc6e5d06e35ba313abc7d6aaab8c92825409776ca76a9709e92544dd2::KITTY {
    struct KITTY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KITTY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KITTY>>(0x2::coin::mint<KITTY>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KITTY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<KITTY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: KITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<KITTY>(arg0, 9, b"KITTY", b"Kitty honey millions", b"Kitty honey millions $$$", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<KITTY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITTY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<KITTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KITTY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<KITTY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

