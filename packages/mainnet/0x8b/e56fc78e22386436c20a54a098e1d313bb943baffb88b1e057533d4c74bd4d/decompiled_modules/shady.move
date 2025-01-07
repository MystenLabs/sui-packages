module 0x8be56fc78e22386436c20a54a098e1d313bb943baffb88b1e057533d4c74bd4d::shady {
    struct SHADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHADY>(arg0, 9, b"SHADY", b"ShadyShiba", b"ShadyShiba (SHADY): A mischievous meme token with a sly, playful twist, designed for those who love risk, fun, and a hint of mystery in the crypto game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1819299856768552962/dwDeWGbk.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHADY>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHADY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

