module 0x57206fa1bef7f7a106e076da7312a949b6dc8c2e97df0b13b613bdadaa8f3536::party {
    public fun test(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::empty<0x2::object::ID>(), 1)
    }

    // decompiled from Move bytecode v6
}

