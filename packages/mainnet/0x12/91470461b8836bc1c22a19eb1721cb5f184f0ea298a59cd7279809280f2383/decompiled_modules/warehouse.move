module 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::warehouse {
    struct Warehouse<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        nfts: 0x2::table_vec::TableVec<0x2::object::ID>,
        total_deposited: u64,
    }

    public fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : Warehouse<T0> {
        Warehouse<T0>{
            id              : 0x2::object::new(arg0),
            nfts            : 0x2::table_vec::empty<0x2::object::ID>(arg0),
            total_deposited : 0,
        }
    }

    public(friend) fun deposit_nft<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg0.nfts, v0);
        arg0.total_deposited = arg0.total_deposited + 1;
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
    }

    fun idx_with_id<T0: store + key>(arg0: &Warehouse<T0>, arg1: &0x2::object::ID) : u64 {
        let v0 = arg0.total_deposited;
        assert!(v0 > 0, 1);
        let v1 = 0;
        while (v1 < v0) {
            if (0x2::table_vec::borrow<0x2::object::ID>(&arg0.nfts, v1) == arg1) {
                return v1
            };
            v1 = v1 + 1;
        };
        abort 3
    }

    public(friend) fun redeem_nft<T0: store + key>(arg0: &mut Warehouse<T0>) : T0 {
        assert!(arg0.total_deposited > 0, 1);
        arg0.total_deposited = arg0.total_deposited - 1;
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x2::table_vec::pop_back<0x2::object::ID>(&mut arg0.nfts))
    }

    public(friend) fun redeem_nft_at_index<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: u64) : T0 {
        assert!(arg0.total_deposited > 0, 1);
        assert!(arg1 < arg0.total_deposited, 2);
        arg0.total_deposited = arg0.total_deposited - 1;
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x2::table_vec::swap_remove<0x2::object::ID>(&mut arg0.nfts, arg1))
    }

    public(friend) fun redeem_nft_with_id<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: 0x2::object::ID) : T0 {
        let v0 = idx_with_id<T0>(arg0, &arg1);
        redeem_nft_at_index<T0>(arg0, v0)
    }

    public(friend) fun redeem_pseudorandom_nft<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = arg0.total_deposited;
        assert!(v0 > 0, 1);
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = &mut v1;
        redeem_nft_at_index<T0>(arg0, select(v0, v2))
    }

    fun select(arg0: u64, arg1: &mut 0x2::random::RandomGenerator) : u64 {
        ((0x2::random::generate_u256(arg1) % (arg0 as u256)) as u64)
    }

    public fun supply<T0: store + key>(arg0: &Warehouse<T0>) : u64 {
        arg0.total_deposited
    }

    // decompiled from Move bytecode v6
}

