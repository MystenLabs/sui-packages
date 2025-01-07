module 0x32624fe90975a1b0af677f6a4b18a32ac290e8a9d883ac9f75edabbd8c05fde7::suiwukong {
    struct SUIWUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWUKONG>(arg0, 9, b"SUIWUKONG", b"SuiWukong", b"Black Myth Wukong Game Sui Meme Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1692949540540956672/e-43p0Yh_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIWUKONG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWUKONG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

