module 0x7f44717f7dccf31070f2f84f290a01ab5943b175df97515244fa9da7f15f57b0::red_usd {
    struct RedUSD has drop {
        dummy_field: bool,
    }

    public(friend) fun new_supply() : 0x2::balance::Supply<RedUSD> {
        let v0 = RedUSD{dummy_field: false};
        0x2::balance::create_supply<RedUSD>(v0)
    }

    // decompiled from Move bytecode v6
}

