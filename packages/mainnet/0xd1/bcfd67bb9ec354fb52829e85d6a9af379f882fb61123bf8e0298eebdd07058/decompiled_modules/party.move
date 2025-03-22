module 0xd1bcfd67bb9ec354fb52829e85d6a9af379f882fb61123bf8e0298eebdd07058::party {
    public fun test<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : 0x2::object::ID {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::singleton<0x2::object::ID>(0x2::object::id_from_address(@0xd2588e9917fc3a34f3f78c598bb0e6c1d9075ee54a3ed3562808d27479e3dca9)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0) - 25597);
        let v1 = 0x2::object::id_from_address(@0x0);
        if (!0x1::vector::is_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&v0)) {
            let v2 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&mut v0);
            v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(&v2);
            0x2::object::id_to_address(&v1);
        };
        v1
    }

    // decompiled from Move bytecode v6
}

