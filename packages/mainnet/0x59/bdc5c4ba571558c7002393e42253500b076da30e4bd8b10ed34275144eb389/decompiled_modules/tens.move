module 0x59bdc5c4ba571558c7002393e42253500b076da30e4bd8b10ed34275144eb389::tens {
    struct TENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TENS>(arg0, 6, b"TENS", b"Trump's Elons Nutt Sack by SuiAI", b"Trumps Elon Bromance will not last, two egotistical Pricks can not co-exist in the same planet. TENS ( Trump is Elons NUtt Sack) is a MEME PROJECT created just for fun. No dev. team, and we are not developing anything. 100% CTO. 0% tax buy/sale.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/elon_e_trump_coin_logo_938d85d150.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TENS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

