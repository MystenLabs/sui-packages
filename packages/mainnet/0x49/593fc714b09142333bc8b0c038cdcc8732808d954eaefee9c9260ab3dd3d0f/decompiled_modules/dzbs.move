module 0x49593fc714b09142333bc8b0c038cdcc8732808d954eaefee9c9260ab3dd3d0f::dzbs {
    struct DZBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DZBS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DZBS>(arg0, 9, b"DZBS", b"Dummy Zombie Sui Coin", b"Reward Token from Zombie Sui NFTs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/12192.png")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DZBS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<DZBS>>(0x2::coin::mint<DZBS>(&mut v3, 1000000000000000000, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DZBS>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

