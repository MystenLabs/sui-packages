module 0x748baa449d719f60065107a25a00940e6d3b647be0e273299f6ab18bdb944452::party {
    public fun test(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : (address, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::singleton<0x2::object::ID>(0x2::object::id_from_address(@0xd2588e9917fc3a34f3f78c598bb0e6c1d9075ee54a3ed3562808d27479e3dca9)), 1);
        (@0x0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0))
    }

    // decompiled from Move bytecode v6
}

