module 0x48bda48bc4e6fbf95568046484bb635507c2358bc5acc5aa4ea8f05965ed4acf::smeow {
    struct SMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEOW>(arg0, 11, b"SMEOW", b"SUI MEOW", b"MEOW MEOW MEOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/36042/standard/meow.png?1710400599")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMEOW>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEOW>>(v2, @0x6d7406e970e5ac192957e4fcda1e45b8efaedc60d4f237deb5d52e4ea221e992);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

