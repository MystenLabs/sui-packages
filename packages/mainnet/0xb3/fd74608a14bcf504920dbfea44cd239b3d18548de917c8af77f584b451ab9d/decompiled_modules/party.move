module 0xb3fd74608a14bcf504920dbfea44cd239b3d18548de917c8af77f584b451ab9d::party {
    public fun test(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : (address, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::singleton<0x2::object::ID>(0x2::object::id_from_address(@0x942950eb452c4be91b6e24faab32c92e83a3bac79eb8d04142c3127295f8890f)), 1);
        (@0x0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0))
    }

    // decompiled from Move bytecode v6
}

