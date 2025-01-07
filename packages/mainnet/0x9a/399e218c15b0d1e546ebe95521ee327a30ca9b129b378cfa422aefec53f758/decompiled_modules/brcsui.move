module 0x9a399e218c15b0d1e546ebe95521ee327a30ca9b129b378cfa422aefec53f758::brcsui {
    struct BRCSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BRCSUI>, arg1: vector<0x2::coin::Coin<BRCSUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BRCSUI>>(&mut arg1);
        0x2::pay::join_vec<BRCSUI>(&mut v0, arg1);
        0x2::coin::burn<BRCSUI>(arg0, 0x2::coin::split<BRCSUI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BRCSUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BRCSUI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BRCSUI>(v0);
        };
    }

    fun init(arg0: BRCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BRCSUI>(arg0, 7, b"BSUI", b"BRCSUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<BRCSUI>(&mut v3, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRCSUI>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRCSUI>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BRCSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BRCSUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BRCSUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BRCSUI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

