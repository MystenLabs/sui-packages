module 0xebba7db29caa336653800cbf964e13ad4fe4213776583a8b95e1a035480ede7::xranileccars {
    struct XRANILECCARS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XRANILECCARS>, arg1: vector<0x2::coin::Coin<XRANILECCARS>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<XRANILECCARS>>(&mut arg1);
        0x2::pay::join_vec<XRANILECCARS>(&mut v0, arg1);
        0x2::coin::burn<XRANILECCARS>(arg0, 0x2::coin::split<XRANILECCARS>(&mut v0, arg2, arg3));
        if (0x2::coin::value<XRANILECCARS>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<XRANILECCARS>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<XRANILECCARS>(v0);
        };
    }

    fun init(arg0: XRANILECCARS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<XRANILECCARS>(arg0, 9, b"XRL", b"XRANILECCARS", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<XRANILECCARS>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRANILECCARS>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRANILECCARS>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XRANILECCARS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XRANILECCARS>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<XRANILECCARS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XRANILECCARS>>(arg0);
    }

    // decompiled from Move bytecode v6
}

