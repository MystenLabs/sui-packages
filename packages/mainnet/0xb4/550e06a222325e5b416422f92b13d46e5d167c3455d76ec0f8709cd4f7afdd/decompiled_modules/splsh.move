module 0xb4550e06a222325e5b416422f92b13d46e5d167c3455d76ec0f8709cd4f7afdd::splsh {
    struct SPLSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLSH>(arg0, 9, b"SPLSH", b"SuiSplash", b"SuiSplash is a playful meme token on the Sui blockchain, making waves with fun and community-driven engagement in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1620009358661939200/5KoIti_p.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPLSH>(&mut v2, 333333333000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLSH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

