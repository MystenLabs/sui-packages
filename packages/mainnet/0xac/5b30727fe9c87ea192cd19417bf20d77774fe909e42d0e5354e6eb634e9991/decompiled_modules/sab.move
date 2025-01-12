module 0xac5b30727fe9c87ea192cd19417bf20d77774fe909e42d0e5354e6eb634e9991::sab {
    struct SAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAB>(arg0, 6, b"SAB", b"SuiAIBot by SuiAI", b"Built for the synergy between the Sui Network and suiai.fun's Telegram trading bot, the SuiAIBot is a cutting-edge digital asset. It harnesses Sui's scalability to handle a large volume of trading requests without bottlenecks. The token powers the AI-driven analytics of the bot, enabling it to generate accurate market insights and trading signals. In addition, SuiAIBot Token features a deflationary model, where a portion of tokens used in trading is burned, steadily increasing the value of the remaining supply. This makes it not only a trading medium but also a store of value for users engaged in the suiai.fun platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SAB_100_8ead288d74.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

