module 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd {
    struct RedUSD has drop {
        dummy_field: bool,
    }

    public(friend) fun new_supply() : 0x2::balance::Supply<RedUSD> {
        let v0 = RedUSD{dummy_field: false};
        0x2::balance::create_supply<RedUSD>(v0)
    }

    // decompiled from Move bytecode v6
}

