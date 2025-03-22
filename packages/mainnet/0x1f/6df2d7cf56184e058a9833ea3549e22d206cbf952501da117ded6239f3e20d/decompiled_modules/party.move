module 0x1f6df2d7cf56184e058a9833ea3549e22d206cbf952501da117ded6239f3e20d::party {
    public fun test(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : (address, u64) {
        let v0 = @0x0;
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::empty<0x2::object::ID>(), 1);
        if (!0x1::vector::is_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&v1)) {
            let v2 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&mut v1);
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_key(&v2);
            v0 = 0x2::object::id_to_address(&v3);
        };
        (v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0))
    }

    // decompiled from Move bytecode v6
}

