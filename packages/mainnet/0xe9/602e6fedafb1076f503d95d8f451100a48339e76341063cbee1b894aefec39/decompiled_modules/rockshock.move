module 0xe9602e6fedafb1076f503d95d8f451100a48339e76341063cbee1b894aefec39::rockshock {
    struct ROCKSHOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKSHOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKSHOCK>(arg0, 6, b"ROCKSHOCK", b"ROCK SHOCK", b"Rock Shock Rock Shock Rock Shock Rock Shock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_4_a5f8abe524.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKSHOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKSHOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

