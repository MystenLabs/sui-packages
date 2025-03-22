module 0x5fd6239d273dab9842d166e314b19447f293004771457257e02d19a2fc4d40bd::party {
    public fun test(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : (address, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id_from_address(@0xd00409456fd4806a7bfb477651083cd858f6865ffa43160ccbe21d708b42a49d));
        let v1 = @0x0;
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, v0, 1);
        if (!0x1::vector::is_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&v2)) {
            let v3 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&mut v2);
            let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(&v3);
            v1 = 0x2::object::id_to_address(&v4);
        };
        (v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0))
    }

    // decompiled from Move bytecode v6
}

