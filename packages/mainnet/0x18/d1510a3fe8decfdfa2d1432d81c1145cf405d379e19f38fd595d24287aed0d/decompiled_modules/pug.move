module 0x18d1510a3fe8decfdfa2d1432d81c1145cf405d379e19f38fd595d24287aed0d::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 9, b"PUG", b"The Pug Satoshi", b"The Pug Satoshi is the first dog registered in the bitcoin blockchain and crypto space. $PUG is the OG before Doge, Shiba and all of inu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pugbitcoin.com/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

