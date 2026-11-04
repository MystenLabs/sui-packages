module 0x720dd1cfb34110e8dab99200d8c12504d1385cbc59eb20e273fc74301f7ec196::selector {
    public fun chosen_amount(arg0: &vector<u128>, arg1: &vector<bool>) : u128 {
        0xfaba31b9c292d7cb6372ad80f80f685c1d6301f74f582e4bc700ac0df65cf45d::selector::chosen<u128>(arg0, arg1)
    }

    public fun chosen_results(arg0: &vector<0xfaba31b9c292d7cb6372ad80f80f685c1d6301f74f582e4bc700ac0df65cf45d::optimizer::OptimizeResult>, arg1: &vector<bool>) : 0xfaba31b9c292d7cb6372ad80f80f685c1d6301f74f582e4bc700ac0df65cf45d::optimizer::OptimizeResult {
        0xfaba31b9c292d7cb6372ad80f80f685c1d6301f74f582e4bc700ac0df65cf45d::selector::chosen<0xfaba31b9c292d7cb6372ad80f80f685c1d6301f74f582e4bc700ac0df65cf45d::optimizer::OptimizeResult>(arg0, arg1)
    }

    public fun new() : vector<bool> {
        0xfaba31b9c292d7cb6372ad80f80f685c1d6301f74f582e4bc700ac0df65cf45d::selector::new()
    }

    public fun take_first(arg0: &mut vector<bool>, arg1: bool) : bool {
        0xfaba31b9c292d7cb6372ad80f80f685c1d6301f74f582e4bc700ac0df65cf45d::selector::take_first(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

