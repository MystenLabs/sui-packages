module 0xe7d05b77503f4b8230cb4a7a3c72f6a5511599ee3eab6eb6c4d35e9511a4a927::tens {
    struct TENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TENS>(arg0, 6, b"TENS", b"Trump's Elons Nutt Sack by SuiAI", b"Two egotistical pricks can not co-exist on the same planet. TENS ( Trump is Elons Nutt Sack) is a MEME PROJECT, no DEV. team, and we are not developing anything. The AI agent was created to poke fun of the Trump/Elon bromance which is not likely to last very long. TENS is 100% CTO, 0% tax on BUY/sale.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/elon_e_trump_coin_logo_046f15f1e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TENS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

