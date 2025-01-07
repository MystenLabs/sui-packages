module 0x4c6d4faaf6c30f93ab4e2eb08bff895668622928e75e7f705cd340dc79b16f50::createtoken {
    struct CREATETOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREATETOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREATETOKEN>(arg0, 6, b"CreateToken", b"Create Token", b"meme what", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_at_15_13_23_df3fc74521.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREATETOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CREATETOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

