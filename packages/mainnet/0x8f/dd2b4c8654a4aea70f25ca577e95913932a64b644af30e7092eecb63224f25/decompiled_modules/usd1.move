module 0x8fdd2b4c8654a4aea70f25ca577e95913932a64b644af30e7092eecb63224f25::usd1 {
    struct USD1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD1>(arg0, 9, b"USD1", b"USD1", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/Zc4l6YnOgiEnrOI8_wXmKlaKEzD7waqxbEIwJMyiXGY")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USD1>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD1>>(v2, @0x64618fc023c7e6ec5fc6d7dd2046b7978402ad9c7bad279e840d56017abb1b7e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USD1>>(v1);
    }

    // decompiled from Move bytecode v6
}

