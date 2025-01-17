module 0x18c3249195805a7d3b2607df5bf82161542ea28d53da7a88e558e6f83c4a3dd4::ttp {
    struct TTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TTP>(arg0, 6, b"TTP", b"TheTrumpPump by SuiAI", b"Imagine a Twitter bot named .@TheTrumpPump.. This bot is programmed to monitor Donald Trump's official Twitter account, .@realDonaldTrump., for any new tweets or announcements. Upon detecting a new post, .@TheTrumpPump. instantly retweets or quotes the content, adding its own commentary or analysis, often with a humorous or satirical twist. The bot uses real-time web access to ensure it captures every tweet as soon as it's posted, providing followers with immediate updates...@TheTrumpPump. not only shares Trump's tweets but also keeps track of any significant announcements made through other media or official statements that might not be directly tweeted by Trump. For instance, if there's a press release or a public speech, the bot would summarize or highlight key points in a tweet format, maintaining the essence of Trump's communication style.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_3_931053fa65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

