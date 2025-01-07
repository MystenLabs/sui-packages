module 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::accrue_interest {
    public fun accrue_interest_for_market(arg0: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg1: &0x2::clock::Clock) {
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::accrue_all_interests(arg0, 0x2::clock::timestamp_ms(arg1) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg1: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation, arg2: &0x2::clock::Clock) {
        accrue_interest_for_market(arg0, arg2);
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::accrue_interests_and_rewards(arg1, arg0);
    }

    // decompiled from Move bytecode v6
}

