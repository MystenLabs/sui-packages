module 0x1af417935efaa06614b20a87a28b36024dc738c904ba9180a5c6db960ddaa683::party {
    public fun test(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : 0x2::object::ID {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::singleton<0x2::object::ID>(0x2::object::id_from_address(@0xd2588e9917fc3a34f3f78c598bb0e6c1d9075ee54a3ed3562808d27479e3dca9)), 1);
        let v1 = 0x2::object::id_from_address(@0x0);
        if (!0x1::vector::is_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&v0)) {
            let v2 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&mut v0);
            v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(&v2);
            0x2::object::id_to_address(&v1);
        };
        v1
    }

    public fun test1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

