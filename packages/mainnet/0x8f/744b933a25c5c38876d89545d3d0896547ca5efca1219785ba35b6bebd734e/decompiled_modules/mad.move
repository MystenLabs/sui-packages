module 0x8f744b933a25c5c38876d89545d3d0896547ca5efca1219785ba35b6bebd734e::mad {
    struct MAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAD>(arg0, 6, b"MAD", b"Meme Addiction Disorder", x"57656c636f6d6520746f20746865206162737572646c792064656c6967687466756c20776f726c64206f6620244d41440a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/If_you_find_yourself_questioning_your_reality_outside_of_the_latest_Kermit_meme_or_if_Blub_adventures_seem_more_tangible_than_your_daily_life_ita_s_time_to_consult_a_MAD_professional_Your_neares_761a548da3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

