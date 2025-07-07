module 0x5a4151b35fa8df97d9dedbff9880e7926bec8f8b4dcf6f2ee4f0e4fc07b7dc26::red_usd {
    struct RedUSD has drop {
        dummy_field: bool,
    }

    public(friend) fun new_supply() : 0x2::balance::Supply<RedUSD> {
        let v0 = RedUSD{dummy_field: false};
        0x2::balance::create_supply<RedUSD>(v0)
    }

    // decompiled from Move bytecode v6
}

