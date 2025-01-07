module 0xe083c5c6d89c0f034412cad709725f19f261d0675a68549b85fbf2e28302e8e3::modxp {
    struct MODXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MODXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MODXP>(arg0, 6, b"MODXP", b"_MonkeyOnDuck_XP", b"_MonkeyOnDuck_XP_Raydium_DEX_PAID_degenplay_1Top_Trending_Dex_Coinmarketcap_100000000x_100milliMcap_CEX_$MODXP_number1_memecoin_on_sol_LFG!!!!!!_monkeyonduckxp.xyz.exe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5796348001822819531_x_d6ebfa2e0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MODXP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MODXP>>(v1);
    }

    // decompiled from Move bytecode v6
}

