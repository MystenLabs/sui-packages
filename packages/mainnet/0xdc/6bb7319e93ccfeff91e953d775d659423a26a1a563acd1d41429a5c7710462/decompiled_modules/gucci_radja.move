module 0xdc6bb7319e93ccfeff91e953d775d659423a26a1a563acd1d41429a5c7710462::gucci_radja {
    struct GUCCI_RADJA has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUCCI_RADJA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GUCCI_RADJA>>(0x2::coin::mint<GUCCI_RADJA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GUCCI_RADJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUCCI_RADJA>(arg0, 9, b"GUCCI_RADJA", b"GUCCI_RADJA Token", b"GUCCI_RADJA token on the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/tg7w30K0/T-image2-Small.gif")), arg1);
        let v2 = v0;
        let v3 = 0x2::coin::mint<GUCCI_RADJA>(&mut v2, 1500000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GUCCI_RADJA>>(0x2::coin::split<GUCCI_RADJA>(&mut v3, 1000000000000000000, arg1), @0x9752d337036cfbb6a91dae286ad3840a419475ea0e8162ab3a39b888ddd8931);
        let v4 = 250000000000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<GUCCI_RADJA>>(0x2::coin::split<GUCCI_RADJA>(&mut v3, v4, arg1), @0xe2f6e1d10584c74264e84f3bd4faa9d0139e194d38216c0e807723441240d167);
        0x2::transfer::public_transfer<0x2::coin::Coin<GUCCI_RADJA>>(0x2::coin::split<GUCCI_RADJA>(&mut v3, v4, arg1), @0x9068681c94d578cc4fe28b23149c4ee996fcdde6111183e60e072bdfdd37bfd7);
        if (0x2::coin::value<GUCCI_RADJA>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<GUCCI_RADJA>>(v3, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<GUCCI_RADJA>(v3);
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUCCI_RADJA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUCCI_RADJA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

