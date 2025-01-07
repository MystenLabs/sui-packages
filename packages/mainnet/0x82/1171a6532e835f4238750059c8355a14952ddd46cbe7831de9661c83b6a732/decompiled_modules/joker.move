module 0x821171a6532e835f4238750059c8355a14952ddd46cbe7831de9661c83b6a732::joker {
    struct JOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER>(arg0, 6, b"JOKER", b"Joker", x"4d414b45204a4f4b455220475245415420414741494e0a45766572796f6e65204c6f766573204d656d6573200a426520556e69717565202c2042652061204a6f6b6572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_26_003652_91ece0e680.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

