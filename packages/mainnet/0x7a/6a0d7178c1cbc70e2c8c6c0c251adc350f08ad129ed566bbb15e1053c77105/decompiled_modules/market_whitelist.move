module 0x7a6a0d7178c1cbc70e2c8c6c0c251adc350f08ad129ed566bbb15e1053c77105::market_whitelist {
    struct Whitelist has store {
        contents: 0x2::table::Table<address, bool>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Whitelist {
        Whitelist{contents: 0x2::table::new<address, bool>(arg0)}
    }

    public(friend) fun add_addresses(arg0: &mut Whitelist, arg1: vector<address>) {
        let v0 = 0x1::vector::length<address>(&arg1);
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (!0x2::table::contains<address, bool>(&arg0.contents, v1)) {
                0x2::table::add<address, bool>(&mut arg0.contents, v1, true);
            };
            v0 = v0 - 1;
        };
    }

    public fun is_empty(arg0: &Whitelist) : bool {
        0x2::table::length<address, bool>(&arg0.contents) == 0
    }

    public fun is_whitelisted(arg0: &Whitelist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.contents, arg1)
    }

    public(friend) fun remove_addresses(arg0: &mut Whitelist, arg1: vector<address>) {
        let v0 = 0x1::vector::length<address>(&arg1);
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (0x2::table::contains<address, bool>(&arg0.contents, v1)) {
                0x2::table::remove<address, bool>(&mut arg0.contents, v1);
            };
            v0 = v0 - 1;
        };
    }

    // decompiled from Move bytecode v6
}

