module 0x33f64a8833605a916d784e9a78ebda38d1234f5d2ac66edfa4545bc05bdbf853::aisp {
    struct AISP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISP>(arg0, 9, b"AISP", b"AISP", b"AISP is the ultimate MEME on Sui, Cybertron Legacy, Honor of Autobots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1877712058365730816/nLySZu2P_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AISP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AISP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

