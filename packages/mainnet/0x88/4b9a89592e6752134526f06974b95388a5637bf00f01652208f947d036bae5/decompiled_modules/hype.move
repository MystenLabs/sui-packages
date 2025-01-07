module 0x884b9a89592e6752134526f06974b95388a5637bf00f01652208f947d036bae5::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 9, b"HYPE", b"HYPE OF WEAK", b"To the Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fstock.adobe.com%2Fpl%2Fsearch%2Fimages%3Fk%3Dhype&psig=AOvVaw2nB-ajzmB6KLrcsMTVpYKZ&ust=1728483653129000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCOiWj8P9_ogDFQAAAAAdAAAAABAE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HYPE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

