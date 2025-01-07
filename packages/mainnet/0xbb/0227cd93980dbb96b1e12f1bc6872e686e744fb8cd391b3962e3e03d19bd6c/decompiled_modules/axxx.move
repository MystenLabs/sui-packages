module 0xbb0227cd93980dbb96b1e12f1bc6872e686e744fb8cd391b3962e3e03d19bd6c::axxx {
    struct AXXX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AXXX>, arg1: vector<0x2::coin::Coin<AXXX>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<AXXX>>(&mut arg1);
        0x2::pay::join_vec<AXXX>(&mut v0, arg1);
        0x2::coin::burn<AXXX>(arg0, 0x2::coin::split<AXXX>(&mut v0, arg2, arg3));
        if (0x2::coin::value<AXXX>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<AXXX>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<AXXX>(v0);
        };
    }

    fun init(arg0: AXXX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/bitcoin-btc-logo.png"));
        let (v2, v3) = 0x2::coin::create_currency<AXXX>(arg0, 7, b"axxx", b"axxx", b"x", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXXX>>(v3);
        0x2::coin::mint_and_transfer<AXXX>(&mut v4, 100000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXXX>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AXXX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AXXX>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<AXXX>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AXXX>>(arg0);
    }

    // decompiled from Move bytecode v6
}

