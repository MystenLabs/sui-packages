module 0x31cc5de62c05c5d16f5d380ce1d1a02834de70ea11c98e3a4d4781f4ed13a3b1::kc_coin {
    struct KC_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KC_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KC_COIN>>(0x2::coin::mint<KC_COIN>(arg0, arg1, arg3), arg2);
    }

    public fun balance(arg0: &0x2::coin::Coin<KC_COIN>) : u64 {
        0x2::coin::value<KC_COIN>(arg0)
    }

    fun init(arg0: KC_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KC_COIN>(arg0, 9, b"KC", b"KC Meme Coin", b"A fun meme coin created on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1914739288799084544/HIgBb62n_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KC_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KC_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

