module 0x5c2975a37bd7240d4ae0f1848c6637e2acc13c4b95507f0568f8ef637daad80b::party {
    public fun test(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : (address, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id_from_address(@0xd00409456fd4806a7bfb477651083cd858f6865ffa43160ccbe21d708b42a49d));
        (@0x0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0))
    }

    // decompiled from Move bytecode v6
}

