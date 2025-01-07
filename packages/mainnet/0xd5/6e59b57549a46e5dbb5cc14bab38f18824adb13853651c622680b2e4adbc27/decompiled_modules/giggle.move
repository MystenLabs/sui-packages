module 0xd56e59b57549a46e5dbb5cc14bab38f18824adb13853651c622680b2e4adbc27::giggle {
    struct GIGGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGGLE>(arg0, 9, b"GIGGLE", b"SuiGiggles", b"SuiGiggles is a playful, community-powered token on the SUI blockchain, designed to bring laughter and fun to the world of crypto. With its lighthearted spirit, SuiGiggles makes decentralized finance (DeFi) more approachable and enjoyable for users of all levels. Perfect for those who love to mix humor with innovation, SuiGiggles offers fast, secure transactions while keeping the mood cheerful and entertaining in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1838631598054379520/DpXfxNt5.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIGGLE>(&mut v2, 1300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGGLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

