module 0xbdb6e8facb361e8b7bf99c52db868b93781633482677831dd0338fcaaf7e4436::party {
    public fun test(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : (address, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x2::object::id_from_address(@0xd00409456fd4806a7bfb477651083cd858f6865ffa43160ccbe21d708b42a49d);
        0x1::vector::push_back<0x2::object::ID>(&mut v0, v1);
        (0x2::object::id_to_address(&v1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::index(arg0))
    }

    // decompiled from Move bytecode v6
}

