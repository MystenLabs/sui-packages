module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order_validator {
    public(friend) fun validate(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order, arg1: &0x2::clock::Clock) {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::verifier::verify_time(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::order_start_time(arg0), 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::order_end_time(arg0), true, arg1);
    }

    // decompiled from Move bytecode v6
}

