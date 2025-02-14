module 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::version::Version, arg1: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::Market, arg2: &0x2::clock::Clock) {
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::version::assert_current_version(arg0);
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::version::Version, arg1: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::Market, arg2: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

