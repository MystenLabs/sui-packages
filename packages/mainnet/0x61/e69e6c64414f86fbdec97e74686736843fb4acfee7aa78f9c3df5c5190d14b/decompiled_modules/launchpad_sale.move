module 0x61e69e6c64414f86fbdec97e74686736843fb4acfee7aa78f9c3df5c5190d14b::launchpad_sale {
    struct Sale<phantom T0: store + key, T1: store> has store, key {
        id: 0x2::object::UID,
        whitelist: bool,
        nfts: 0x2::object_table::ObjectTable<0x2::object::ID, T0>,
        reg: SaleRegistry<T0>,
        launchpad: T1,
    }

    struct SaleRegistry<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        born: u64,
        nft_index: vector<0x2::object::ID>,
    }

    public(friend) fun create_sale<T0: store + key, T1: store>(arg0: bool, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) : Sale<T0, T1> {
        let v0 = SaleRegistry<T0>{
            id        : 0x2::object::new(arg2),
            born      : 0,
            nft_index : 0x1::vector::empty<0x2::object::ID>(),
        };
        Sale<T0, T1>{
            id        : 0x2::object::new(arg2),
            whitelist : arg0,
            nfts      : 0x2::object_table::new<0x2::object::ID, T0>(arg2),
            reg       : v0,
            launchpad : arg1,
        }
    }

    public(friend) fun delist_item<T0: store + key, T1: store>(arg0: &mut Sale<T0, T1>, arg1: vector<0x2::object::ID>) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = 0;
        let v2 = &mut arg0.reg;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v3 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            let (_, v5) = 0x1::vector::index_of<0x2::object::ID>(&v2.nft_index, &v3);
            assert!(0x1::vector::swap_remove<0x2::object::ID>(&mut v2.nft_index, v5) == v3, 0);
            0x1::vector::push_back<T0>(&mut v0, 0x2::object_table::remove<0x2::object::ID, T0>(&mut arg0.nfts, v3));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_launchpad<T0: store + key, T1: store>(arg0: &Sale<T0, T1>) : &T1 {
        &arg0.launchpad
    }

    public(friend) fun get_mut_market<T0: store + key, T1: store>(arg0: &mut Sale<T0, T1>) : &mut T1 {
        &mut arg0.launchpad
    }

    public(friend) fun get_mut_sale<T0: store + key, T1: store>(arg0: &mut Sale<T0, T1>) : (&mut T1, &mut 0x2::object_table::ObjectTable<0x2::object::ID, T0>, &mut SaleRegistry<T0>) {
        (&mut arg0.launchpad, &mut arg0.nfts, &mut arg0.reg)
    }

    public fun get_nfts<T0: store + key, T1: store>(arg0: &Sale<T0, T1>) : &0x2::object_table::ObjectTable<0x2::object::ID, T0> {
        &arg0.nfts
    }

    public(friend) fun list_multi_item<T0: store + key, T1: store>(arg0: &mut Sale<T0, T1>, arg1: vector<T0>) {
        let v0 = 0;
        let v1 = &mut arg0.reg;
        while (v0 < 0x1::vector::length<T0>(&arg1)) {
            let v2 = 0x1::vector::pop_back<T0>(&mut arg1);
            let v3 = 0x2::object::id<T0>(&v2);
            0x1::vector::push_back<0x2::object::ID>(&mut v1.nft_index, v3);
            0x2::object_table::add<0x2::object::ID, T0>(&mut arg0.nfts, v3, v2);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public(friend) fun modify_whitelist_status<T0: store + key, T1: store>(arg0: &mut Sale<T0, T1>, arg1: bool) {
        arg0.whitelist = arg1;
    }

    public entry fun whitelist_status<T0: store + key, T1: store>(arg0: &Sale<T0, T1>) : bool {
        arg0.whitelist
    }

    public(friend) fun withdraw<T0: store + key, T1: store>(arg0: &mut Sale<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = &mut arg0.reg;
        v0.born = v0.born + 1;
        0x2::object_table::remove<0x2::object::ID, T0>(&mut arg0.nfts, 0x1::vector::swap_remove<0x2::object::ID>(&mut v0.nft_index, 0x61e69e6c64414f86fbdec97e74686736843fb4acfee7aa78f9c3df5c5190d14b::random::rand_u64_range(0, 0x1::vector::length<0x2::object::ID>(&arg0.reg.nft_index), arg1)))
    }

    // decompiled from Move bytecode v6
}

