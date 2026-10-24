module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state {
    struct ReviewKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Review has drop, store {
        stars: u8,
        text_hash: vector<u8>,
        by: address,
        at_ms: u64,
    }

    public(friend) fun by(arg0: &Review) : address {
        arg0.by
    }

    public(friend) fun key() : ReviewKey {
        ReviewKey{dummy_field: false}
    }

    public(friend) fun new(arg0: u8, arg1: vector<u8>, arg2: address, arg3: u64) : Review {
        Review{
            stars     : arg0,
            text_hash : arg1,
            by        : arg2,
            at_ms     : arg3,
        }
    }

    public(friend) fun replace(arg0: &mut Review, arg1: u8, arg2: vector<u8>, arg3: address, arg4: u64) {
        arg0.stars = arg1;
        arg0.text_hash = arg2;
        arg0.by = arg3;
        arg0.at_ms = arg4;
    }

    public(friend) fun stars(arg0: &Review) : u8 {
        arg0.stars
    }

    // decompiled from Move bytecode v7
}

