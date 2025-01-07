module 0x7a5d847eb9c74694cf85ba8f46d3af554d002f5160217c5931291b453ef3f77a::cok {
    struct COK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<COK>, arg1: vector<0x2::coin::Coin<COK>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<COK>>(&mut arg1);
        0x2::pay::join_vec<COK>(&mut v0, arg1);
        0x2::coin::burn<COK>(arg0, 0x2::coin::split<COK>(&mut v0, arg2, arg3));
        if (0x2::coin::value<COK>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<COK>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<COK>(v0);
        };
    }

    fun init(arg0: COK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://em-content.zobj.net/source/microsoft/378/cookie_1f36a.png"));
        let (v2, v3) = 0x2::coin::create_currency<COK>(arg0, 9, b"COK", b"COK", b"COK IS LITERALLY A MEME COIN.NO UTILITY. NO ROADMAP. NO PROMISES.", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COK>>(v3);
        0x2::coin::mint_and_transfer<COK>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COK>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COK>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<COK>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COK>>(arg0);
    }

    // decompiled from Move bytecode v6
}

