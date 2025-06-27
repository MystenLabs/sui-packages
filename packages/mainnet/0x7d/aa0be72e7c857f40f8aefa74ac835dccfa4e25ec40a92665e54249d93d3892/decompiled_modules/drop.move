module 0x4e76606185130cd30293f43f638d353d8b7bb5848d1f6ca5b47f45b5c71c0465::drop {
    struct Drop<phantom T0> has store, key {
        id: 0x2::object::UID,
        root: vector<u8>,
        wallet_count: u32,
        airdrop_total: u64,
        vault: 0x2::balance::Balance<T0>,
        allocations: address,
        merkle_tree: address,
        registry: 0x2::table::Table<address, bool>,
    }

    struct DeleteCap has store, key {
        id: 0x2::object::UID,
        object_id: 0x2::object::ID,
    }

    public fun claim<T0>(arg0: vector<vector<u8>>, arg1: u64, arg2: u64, arg3: &mut Drop<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 < (arg3.wallet_count as u64), 13906834543710568447);
        assert!(0x1::vector::length<vector<u8>>(&arg0) == proof_length((arg3.wallet_count as u64)), 13906834548005535743);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(verify_sender_proof(arg3.root, &arg0, &v0, arg2, arg1), 13906834565185404927);
        0x2::table::add<address, bool>(&mut arg3.registry, 0x2::tx_context::sender(arg4), true);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.vault, arg2), arg4)
    }

    public fun claims_count<T0>(arg0: &Drop<T0>) : u64 {
        0x2::table::length<address, bool>(&arg0.registry)
    }

    fun compute_proof(arg0: vector<u8>, arg1: &vector<vector<u8>>, arg2: u64) : vector<u8> {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg1)) {
            if (arg2 % 2 == 0) {
                v0 = hash_slices(v0, *0x1::vector::borrow<vector<u8>>(arg1, v1));
            } else {
                v0 = hash_slices(*0x1::vector::borrow<vector<u8>>(arg1, v1), v0);
            };
            arg2 = arg2 / 2;
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_drop<T0>(arg0: vector<u8>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: address, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : DeleteCap {
        assert!(arg4 >= 2, 13906834316077301759);
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906834320372269055);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 13906834324667236351);
        let v0 = 0x2::object::new(arg5);
        let v1 = DeleteCap{
            id        : 0x2::object::new(arg5),
            object_id : 0x2::object::uid_to_inner(&v0),
        };
        let v2 = Drop<T0>{
            id            : v0,
            root          : arg0,
            wallet_count  : arg4,
            airdrop_total : 0x2::coin::value<T0>(&arg1),
            vault         : 0x2::coin::into_balance<T0>(arg1),
            allocations   : arg2,
            merkle_tree   : arg3,
            registry      : 0x2::table::new<address, bool>(arg5),
        };
        0x2::transfer::public_share_object<Drop<T0>>(v2);
        v1
    }

    public fun destroy_drop<T0>(arg0: DeleteCap, arg1: Drop<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.object_id, 13906834436336386047);
        let DeleteCap {
            id        : v0,
            object_id : _,
        } = arg0;
        0x2::object::delete(v0);
        let Drop {
            id            : v2,
            root          : _,
            wallet_count  : _,
            airdrop_total : _,
            vault         : v6,
            allocations   : _,
            merkle_tree   : _,
            registry      : v9,
        } = arg1;
        0x2::table::drop<address, bool>(v9);
        0x2::object::delete(v2);
        0x2::coin::from_balance<T0>(v6, arg2)
    }

    public fun has_claimed<T0>(arg0: address, arg1: &Drop<T0>) : bool {
        0x2::table::contains<address, bool>(&arg1.registry, arg0)
    }

    fun hash_address_w_allocation(arg0: &address, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x2::hash::blake2b256(&v0)
    }

    fun hash_slices(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x2::hash::blake2b256(&arg0)
    }

    fun proof_length(arg0: u64) : u64 {
        let v0 = arg0 - 1;
        let v1 = 0;
        while (v0 > 0) {
            v0 = v0 >> 1;
            v1 = v1 + 1;
        };
        v1
    }

    fun verify_proof(arg0: &vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : bool {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906834719804227583);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906834724099194879);
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            if (!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg0, v0)) == 32)) {
                v1 = false;
                /* label 10 */
                assert!(v1, 13906834728394162175);
                let v2 = 0x2::vec_set::from_keys<vector<u8>>(*arg0);
                assert!(0x2::vec_set::size<vector<u8>>(&v2) == 0x1::vector::length<vector<u8>>(arg0), 13906834741279064063);
                return compute_proof(arg2, arg0, arg3) == arg1
            };
            v0 = v0 + 1;
        };
        v1 = true;
        /* goto 10 */
    }

    public(friend) fun verify_sender_proof(arg0: vector<u8>, arg1: &vector<vector<u8>>, arg2: &address, arg3: u64, arg4: u64) : bool {
        verify_proof(arg1, arg0, hash_address_w_allocation(arg2, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

