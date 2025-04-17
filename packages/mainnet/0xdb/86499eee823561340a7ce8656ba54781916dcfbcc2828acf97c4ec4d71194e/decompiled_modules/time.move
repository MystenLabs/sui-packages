module 0xdb86499eee823561340a7ce8656ba54781916dcfbcc2828acf97c4ec4d71194e::time {
    struct TIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIME>(arg0, 6, b"TIME", b"TIME", b"So I've measured time, I've compressed and condensed time, I've bent it, my day is 6 am to noon and I'm not crazy, you're crazy to think it takes 24 hours just like some dude in a cave did 300 years ago, my second day starts at noon and goes till 6pm, that's day 2, and the next day is from 6pm to midnight, what I've done now is I have changed and manipulated time I now get 24 days a week, stack it up over a week I kick your butt, stack it up over a month you're toast, stack it up over 5 years my entire life is different than it would've been otherwise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.weforum.org/organization/image/responsive_small_webp_-U1eoouwmtUl-8qSLruyb8XjsHkbuNwQUIQhAmxfRPM.webp"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIME>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TIME>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIME>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

