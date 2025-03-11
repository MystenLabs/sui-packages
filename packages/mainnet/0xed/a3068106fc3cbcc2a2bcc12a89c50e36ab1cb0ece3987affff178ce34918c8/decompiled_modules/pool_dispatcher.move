module 0xa490a3c4cdbc713e9666d89de8fb715cc75251ae04552b0b7b585331b6782020::pool_dispatcher {
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

    public(friend) fun add_address_pool(arg0: &mut PoolDispatcher, arg1: 0x1::string::String, arg2: address) {
        0x2::bag::add<0x1::string::String, address>(&mut arg0.pools, arg1, arg2);
    }

    public(friend) fun default(arg0: &mut 0x2::tx_context::TxContext) : PoolDispatcher {
        let v0 = PoolDispatcher{
            id    : 0x2::object::new(arg0),
            pools : 0x2::bag::new(arg0),
        };
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"keepers"), @0xa8fe52622f63be3bc2c7032d25f61a30f01d20f4ec27e71638b34c04a5299115);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"ecosystem_growth_pool"), @0x2c8004e874d4c8862b27f79f4bf95aaede1157ff4d87e34911049a28a6ec876b);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"strategic_supporters"), @0xe5f3ac62faba2a915a7bb47be20f7c204fc043f7f5b49db96cbffa66c206dfa1);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"token_treasury"), @0xa44c710a3baee57b67d53104aff0bcd22b9b7780d566357377c4f214312afadc);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"team"), @0xcd43e11fad9a01caad85159c9bf9aa02bbd5910eea2d6f95531d8ad1f1272ef7);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"advisors"), @0xee7c15989e4f071ef022b5ea27420e855c08395bec4998fc54820c9a682e84b7);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"liquidity"), @0xeae12f80d9b462b60284984a3d6a216f4edcf4cc31c18842941c95fd030aa47f);
        0x2::bag::add<0x1::string::String, address>(&mut v0.pools, 0x1::string::utf8(b"lockup"), @0xefaaecff5491118ffca9090afa473c53b937a5d2beb5b566c347bd386e5a656f);
        v0
    }

    public(friend) fun set_address_pool(arg0: &mut PoolDispatcher, arg1: 0x1::string::String, arg2: address) {
        *0x2::bag::borrow_mut<0x1::string::String, address>(&mut arg0.pools, arg1) = arg2;
    }

    // decompiled from Move bytecode v6
}

