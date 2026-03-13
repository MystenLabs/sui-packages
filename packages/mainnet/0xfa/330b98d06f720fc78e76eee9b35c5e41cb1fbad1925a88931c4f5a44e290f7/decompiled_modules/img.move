module 0xfa330b98d06f720fc78e76eee9b35c5e41cb1fbad1925a88931c4f5a44e290f7::img {
    struct IMG has drop {
        dummy_field: bool,
    }

    public entry fun update_description(arg0: &mut 0x2::coin::TreasuryCap<IMG>, arg1: &mut 0x2::coin::CoinMetadata<IMG>, arg2: 0x1::string::String) {
        0x2::coin::update_description<IMG>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url(arg0: &mut 0x2::coin::TreasuryCap<IMG>, arg1: &mut 0x2::coin::CoinMetadata<IMG>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<IMG>(arg0, arg1, arg2);
    }

    public entry fun update_name(arg0: &mut 0x2::coin::TreasuryCap<IMG>, arg1: &mut 0x2::coin::CoinMetadata<IMG>, arg2: 0x1::string::String) {
        0x2::coin::update_name<IMG>(arg0, arg1, arg2);
    }

    public entry fun update_symbol(arg0: &mut 0x2::coin::TreasuryCap<IMG>, arg1: &mut 0x2::coin::CoinMetadata<IMG>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<IMG>(arg0, arg1, arg2);
    }

    public entry fun freeze_coin_metadata(arg0: 0x2::coin::CoinMetadata<IMG>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMG>>(arg0);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<IMG>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IMG>>(arg0);
    }

    fun init(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        let v1 = b"https://ctf.cx/ipfs/bafkreiav47hvj5a3odgh72w7tzi43k5rl2xutxo7nnet3hxpvtotfw6yf4";
        if (0x1::vector::length<u8>(&v1) > 0) {
            v0 = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1));
        };
        let (v2, v3) = 0x2::coin::create_currency<IMG>(arg0, 6, b"IMG", b"Test image", b"test", v0, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<IMG>(&mut v4, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IMG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMG>>(v4, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_coin_metadata(arg0: 0x2::coin::CoinMetadata<IMG>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IMG>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<IMG>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMG>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

