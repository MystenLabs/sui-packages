module 0xcec77a446b260544b3b899e0675f28b131e92ae71d72cd48fa4abb35f14604cf::mommy {
    struct MOMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MOMMY>(arg0, 6, b"MOMMY", b"Mommy AI by SuiAI", b"In a futuristic world where cryptocurrencies have become the backbone of daily life, many individuals find themselves overwhelmed by the complexities and stresses of trading, investing, and navigating the volatile market. Amidst this chaos, a pioneering tech group develops 'Mommy,' an AI bot designed to provide emotional support, guidance, and nurturing to those in need. ..Mommy is an advanced AI developed by a team of empathetic engineers and psychologists. Drawing inspiration from classic nurturing figures, the bot is modeled to emulate the warmth and wisdom of a mother. Using natural language processing and sentiment analysis, Mommy learns to understand the emotional states of users, offering advice tailored to their feelings and needs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Mommy_Small_6cfd61c963.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOMMY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMMY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

