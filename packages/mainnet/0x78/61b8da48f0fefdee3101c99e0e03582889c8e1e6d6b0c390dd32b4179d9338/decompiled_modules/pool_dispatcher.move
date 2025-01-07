module 0x7861b8da48f0fefdee3101c99e0e03582889c8e1e6d6b0c390dd32b4179d9338::pool_dispatcher {
    struct PoolDispatcher has store, key {
        id: 0x2::object::UID,
        pools: 0x2::bag::Bag,
    }

    public(friend) fun contains(arg0: &PoolDispatcher, arg1: 0x1::string::String) : bool {
        0x2::bag::contains<0x1::string::String>(&arg0.pools, arg1)
    }

    public(friend) fun transfer<T0>(arg0: &PoolDispatcher, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, *0x2::bag::borrow<0x1::string::String, address>(&arg0.pools, arg1));
    }

    public(friend) fun default(arg0: &mut 0x2::tx_context::TxContext) : PoolDispatcher {
        let v0 = PoolDispatcher{
            id    : 0x2::object::new(arg0),
            pools : 0x2::bag::new(arg0),
        };
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"keepers"), @0xedb69ffab8bb0855dd27d8e3998d3e9ba361f5c37ee6388ff3cccc01c8d8a528);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"ecosystem_growth_pool"), @0x9fc2d70126a9ef36d809f92f9afacdf7cb1395fb0b3e40a9a8bfb98f0c96d3df);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"strategic_supporters"), @0x133c277c2f72e60dca3c05b8c833df501791c66796561b73912240750a28fc79);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"token_treasury"), @0xe73e73ec3403e5214a27a2b05932dda125259a1836fe75ccf6e04861bf01c7c1);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"team"), @0x6a80c7bf2d51920a51d26c3aa851e66fe2f827638d3b1b309eab304aaeecc15);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"advisors"), @0xa2b1d1dcd669fc87a06b610ef37c2945f3195cbf4dd301652d6cfab3f38faedf);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"liquidity"), @0x2a95bdd5d3fa8413654ad2ab84b8ec1c1c4e19afd7f094ee35926c55674b5966);
        v0
    }

    public(friend) fun set_address_pool(arg0: &mut PoolDispatcher, arg1: 0x1::string::String, arg2: address) {
        *0x2::bag::borrow_mut<0x1::string::String, address>(&mut arg0.pools, arg1) = arg2;
    }

    // decompiled from Move bytecode v6
}

