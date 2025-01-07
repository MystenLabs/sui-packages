module 0x79eb3bf5c717169d4f90149162cc6437128679002431d4f3b2808882cec0187f::cats {
    struct CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS>(arg0, 9, b"CATS", b"CATS", b"CATS is a crypto exchange CEO simulator game built on Telegram with 300 million players. Its mission is to smoothly onboard 1,000,000,000 Web2 users into Web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1811319840465969152/4n3Ic5d__400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

