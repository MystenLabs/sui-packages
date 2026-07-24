module 0x5ca2cf3ce69edec6ad55611a6cb8b3d4718dd0989a77374d5e87ec725a686f9c::suzhi {
    struct SUZHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUZHI>(arg0, 9, b"SUZHI", b"SUZHI FOUNDATION", b"Building the world's first decentralized conscious eco-city. A harmonious blend of sustainability, blockchain innovation, and conscious living.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUZHI>>(0x2::coin::mint<SUZHI>(&mut v3, 1000000000000000, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZHI>>(v3, v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUZHI>>(v2);
    }

    // decompiled from Move bytecode v6
}

