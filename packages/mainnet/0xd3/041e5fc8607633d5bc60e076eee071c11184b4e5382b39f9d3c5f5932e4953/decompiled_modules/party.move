module 0xd3041e5fc8607633d5bc60e076eee071c11184b4e5382b39f9d3c5f5932e4953::party {
    public fun test(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : address {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::empty<0x2::object::ID>(), 1);
        let v1 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&mut v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(&v1);
        0x2::object::id_to_address(&v2)
    }

    // decompiled from Move bytecode v6
}

