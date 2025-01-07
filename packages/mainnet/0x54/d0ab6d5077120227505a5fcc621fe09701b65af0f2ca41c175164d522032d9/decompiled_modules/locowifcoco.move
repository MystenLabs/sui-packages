module 0x54d0ab6d5077120227505a5fcc621fe09701b65af0f2ca41c175164d522032d9::locowifcoco {
    struct LOCOWIFCOCO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOCOWIFCOCO>, arg1: vector<0x2::coin::Coin<LOCOWIFCOCO>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<LOCOWIFCOCO>>(&mut arg1);
        0x2::pay::join_vec<LOCOWIFCOCO>(&mut v0, arg1);
        0x2::coin::burn<LOCOWIFCOCO>(arg0, 0x2::coin::split<LOCOWIFCOCO>(&mut v0, arg2, arg3));
        if (0x2::coin::value<LOCOWIFCOCO>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LOCOWIFCOCO>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<LOCOWIFCOCO>(v0);
        };
    }

    fun init(arg0: LOCOWIFCOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmaCf4REcv396ExAet5GvEtvYpHRRVQ32c44vSLGA2bKe6"));
        let (v2, v3) = 0x2::coin::create_currency<LOCOWIFCOCO>(arg0, 7, b"LOCO", b"LocoWifCoco", b"LOCO brings crazy energy to SUI, embracing the chaos and thriving in the wettest moments!", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOCOWIFCOCO>>(v3);
        0x2::coin::mint_and_transfer<LOCOWIFCOCO>(&mut v4, 10000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCOWIFCOCO>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOCOWIFCOCO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LOCOWIFCOCO>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<LOCOWIFCOCO>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOCOWIFCOCO>>(arg0);
    }

    // decompiled from Move bytecode v6
}

