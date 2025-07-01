module 0xb4b1ca0c14d5dac6df1e1d6d120f13cc46761254b0e41c361e6c8eb60b764985::red_usd {
    struct RedUSD has drop {
        dummy_field: bool,
    }

    public(friend) fun new_supply() : 0x2::balance::Supply<RedUSD> {
        let v0 = RedUSD{dummy_field: false};
        0x2::balance::create_supply<RedUSD>(v0)
    }

    // decompiled from Move bytecode v6
}

