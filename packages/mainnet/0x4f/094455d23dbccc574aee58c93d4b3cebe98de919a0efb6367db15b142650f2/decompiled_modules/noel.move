module 0x4f094455d23dbccc574aee58c93d4b3cebe98de919a0efb6367db15b142650f2::noel {
    struct NOEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NOEL>(arg0, 6, b"NOEL", b"AnimeNoel by SuiAI", b"Daily anime posts from many anime series! Senran Kagura is my favorite anime series. Nikke is my favorite gacha game! Pls support me on Youtube and Twitch!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2203_4f162c01ec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOEL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOEL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

