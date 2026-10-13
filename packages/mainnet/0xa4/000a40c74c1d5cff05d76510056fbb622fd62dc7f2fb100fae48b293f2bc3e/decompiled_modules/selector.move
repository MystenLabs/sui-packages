module 0xa4000a40c74c1d5cff05d76510056fbb622fd62dc7f2fb100fae48b293f2bc3e::selector {
    public fun new() : vector<bool> {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::selector::new()
    }

    public fun take_first(arg0: &mut vector<bool>, arg1: bool) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::selector::take_first(arg0, arg1)
    }

    public fun chosen_results(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>, arg1: &vector<bool>) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::selector::chosen<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

