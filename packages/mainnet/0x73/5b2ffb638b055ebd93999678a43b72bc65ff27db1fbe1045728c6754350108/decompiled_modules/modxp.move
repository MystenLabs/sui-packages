module 0x735b2ffb638b055ebd93999678a43b72bc65ff27db1fbe1045728c6754350108::modxp {
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

