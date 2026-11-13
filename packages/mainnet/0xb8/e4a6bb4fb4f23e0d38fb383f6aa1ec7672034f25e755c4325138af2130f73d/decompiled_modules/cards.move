module 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::cards {
    public fun apply<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: 0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::cards::CardsAction<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg1, arg0);
        0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::cards::apply<T0>(&v0, arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

