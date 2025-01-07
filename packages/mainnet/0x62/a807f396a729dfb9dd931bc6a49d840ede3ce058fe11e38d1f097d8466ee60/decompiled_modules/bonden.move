module 0x62a807f396a729dfb9dd931bc6a49d840ede3ce058fe11e38d1f097d8466ee60::bonden {
    struct BONDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONDEN>(arg0, 9, b"BONDEN", b"Joe Boden", b"Largest stable coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/200x200/29687.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BONDEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONDEN>>(v2, @0x94fbcf49867fd909e6b2ecf2802c4b2bba7c9b2d50a13abbb75dbae0216db82a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

