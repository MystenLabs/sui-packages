module 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::warehouse {
    struct RedeemCommitment has key {
        id: 0x2::object::UID,
        hashed_sender_commitment: vector<u8>,
        contract_commitment: vector<u8>,
    }

    struct Warehouse<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        nfts: vector<0x2::object::ID>,
        total_deposited: u64,
        max_deposited: u64,
    }

    public fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : Warehouse<T0> {
        Warehouse<T0>{
            id              : 0x2::object::new(arg0),
            nfts            : 0x1::vector::empty<0x2::object::ID>(),
            total_deposited : 0,
            max_deposited   : 0,
        }
    }

    public fun assert_is_empty<T0: store + key>(arg0: &Warehouse<T0>) {
        assert!(is_empty<T0>(arg0), 2);
    }

    public fun borrow_chunk<T0: store + key>(arg0: &Warehouse<T0>, arg1: u64) : &vector<0x2::object::ID> {
        if (arg1 == 0) {
            &arg0.nfts
        } else {
            0x2::dynamic_field::borrow<u64, vector<0x2::object::ID>>(&arg0.id, arg1)
        }
    }

    fun borrow_chunk_mut<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: u64) : &mut vector<0x2::object::ID> {
        if (arg1 == 0) {
            &mut arg0.nfts
        } else {
            0x2::dynamic_field::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.id, arg1)
        }
    }

    fun chunk_index(arg0: u64) : (u64, u64) {
        (arg0 / 7998, arg0 % 7998)
    }

    public entry fun deposit_nft<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let (v1, _) = chunk_index(arg0.total_deposited);
        if (has_chunk<T0>(arg0, v1)) {
            let v3 = borrow_chunk_mut<T0>(arg0, v1);
            0x1::vector::push_back<0x2::object::ID>(v3, v0);
        } else {
            insert_chunk<T0>(arg0, v1, v0);
        };
        arg0.total_deposited = arg0.total_deposited + 1;
        arg0.max_deposited = arg0.max_deposited + 1;
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
    }

    public entry fun destroy<T0: store + key>(arg0: Warehouse<T0>) {
        assert_is_empty<T0>(&arg0);
        let Warehouse {
            id              : v0,
            nfts            : _,
            total_deposited : _,
            max_deposited   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun destroy_commitment(arg0: RedeemCommitment) {
        let RedeemCommitment {
            id                       : v0,
            hashed_sender_commitment : _,
            contract_commitment      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun has_chunk<T0: store + key>(arg0: &Warehouse<T0>, arg1: u64) : bool {
        arg1 == 0 || 0x2::dynamic_field::exists_<u64>(&arg0.id, arg1)
    }

    public fun idx_with_id<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: &0x2::object::ID) : u64 {
        let v0 = arg0.total_deposited;
        assert!(v0 > 0, 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0;
            let (v3, _) = chunk_index(v1);
            let v5 = borrow_chunk<T0>(arg0, v3);
            while (v2 < 0x1::vector::length<0x2::object::ID>(v5)) {
                if (0x1::vector::borrow<0x2::object::ID>(v5, v2) == arg1) {
                    return v1
                };
                v1 = v1 + 1;
                v2 = v2 + 1;
            };
        };
        abort 4
    }

    public entry fun init_redeem_commitment(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_redeem_commitment(arg0, arg1);
        0x2::transfer::transfer<RedeemCommitment>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_warehouse<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(arg0);
        0x2::transfer::public_transfer<Warehouse<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    fun insert_chunk<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: u64, arg2: 0x2::object::ID) {
        0x2::dynamic_field::add<u64, vector<0x2::object::ID>>(&mut arg0.id, arg1, 0x1::vector::singleton<0x2::object::ID>(arg2));
    }

    public fun is_empty<T0: store + key>(arg0: &Warehouse<T0>) : bool {
        arg0.total_deposited == 0
    }

    public fun new_redeem_commitment(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : RedeemCommitment {
        assert!(0x1::vector::length<u8>(&arg0) != 32, 5);
        RedeemCommitment{
            id                       : 0x2::object::new(arg1),
            hashed_sender_commitment : arg0,
            contract_commitment      : 0x9e5962d5183664be8a7762fbe94eee6e3457c0cc701750c94c17f7f8ac5a32fb::pseudorandom::rand_with_ctx(arg1),
        }
    }

    public fun nfts<T0: store + key>(arg0: &Warehouse<T0>) : &vector<0x2::object::ID> {
        &arg0.nfts
    }

    public fun redeem_nft<T0: store + key>(arg0: &mut Warehouse<T0>) : T0 {
        assert!(arg0.total_deposited > 0, 1);
        let (v0, v1) = chunk_index(arg0.total_deposited - 1);
        let v2 = if (v1 > 0) {
            let v3 = borrow_chunk_mut<T0>(arg0, v0);
            0x1::vector::pop_back<0x2::object::ID>(v3)
        } else {
            remove_chunk<T0>(arg0, v0)
        };
        arg0.total_deposited = arg0.total_deposited - 1;
        0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, v2)
    }

    public entry fun redeem_nft_and_transfer<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(redeem_nft<T0>(arg0), 0x2::tx_context::sender(arg1));
    }

    public fun redeem_nft_at_index<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: u64) : T0 {
        assert!(arg0.total_deposited > 0, 1);
        assert!(arg1 < arg0.total_deposited, 3);
        let (v0, v1) = chunk_index(arg1);
        let (v2, v3) = chunk_index(arg0.total_deposited - 1);
        let v4 = borrow_chunk_mut<T0>(arg0, v2);
        let v5 = if (v0 == v2) {
            if (v3 > 0) {
                0x1::vector::swap_remove<0x2::object::ID>(v4, v1)
            } else {
                remove_chunk<T0>(arg0, v2)
            }
        } else {
            let v6 = if (v3 > 0) {
                0x1::vector::pop_back<0x2::object::ID>(v4)
            } else {
                remove_chunk<T0>(arg0, v2)
            };
            let v7 = borrow_chunk_mut<T0>(arg0, v0);
            0x1::vector::push_back<0x2::object::ID>(v7, v6);
            0x1::vector::swap_remove<0x2::object::ID>(v7, v1)
        };
        arg0.total_deposited = arg0.total_deposited - 1;
        0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, v5)
    }

    public entry fun redeem_nft_at_index_and_transfer<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(redeem_nft_at_index<T0>(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun redeem_nft_with_id<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: 0x2::object::ID) : T0 {
        let v0 = idx_with_id<T0>(arg0, &arg1);
        redeem_nft_at_index<T0>(arg0, v0)
    }

    public entry fun redeem_nft_with_id_and_transfer<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(redeem_nft_with_id<T0>(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun redeem_pseudorandom_nft<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = supply<T0>(arg0);
        assert!(v0 != 0, 1);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v0));
        let v2 = 0x9e5962d5183664be8a7762fbe94eee6e3457c0cc701750c94c17f7f8ac5a32fb::pseudorandom::rand_no_counter(v1, arg1);
        redeem_nft_at_index<T0>(arg0, select(v0, &v2))
    }

    public entry fun redeem_pseudorandom_nft_and_transfer<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_pseudorandom_nft<T0>(arg0, arg1);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun redeem_random_nft<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: RedeemCommitment, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = supply<T0>(arg0);
        assert!(v0 != 0, 1);
        let RedeemCommitment {
            id                       : v1,
            hashed_sender_commitment : v2,
            contract_commitment      : v3,
        } = arg1;
        0x2::object::delete(v1);
        let v4 = 0x1::hash::sha3_256(arg2);
        assert!(v4 == v2, 6);
        0x1::vector::append<u8>(&mut v4, v3);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&v0));
        let v5 = 0x9e5962d5183664be8a7762fbe94eee6e3457c0cc701750c94c17f7f8ac5a32fb::pseudorandom::rand_no_counter(v4, arg3);
        redeem_nft_at_index<T0>(arg0, select(v0, &v5))
    }

    public entry fun redeem_random_nft_and_transfer<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: RedeemCommitment, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_random_nft<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
    }

    fun remove_chunk<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: u64) : 0x2::object::ID {
        if (arg1 == 0) {
            0x1::vector::pop_back<0x2::object::ID>(&mut arg0.nfts)
        } else {
            let v1 = 0x2::dynamic_field::remove<u64, vector<0x2::object::ID>>(&mut arg0.id, arg1);
            0x1::vector::destroy_empty<0x2::object::ID>(v1);
            0x1::vector::pop_back<0x2::object::ID>(&mut v1)
        }
    }

    fun select(arg0: u64, arg1: &vector<u8>) : u64 {
        ((0x9e5962d5183664be8a7762fbe94eee6e3457c0cc701750c94c17f7f8ac5a32fb::pseudorandom::u256_from_bytes(arg1) % (arg0 as u256)) as u64)
    }

    public fun supply<T0: store + key>(arg0: &Warehouse<T0>) : u64 {
        arg0.total_deposited
    }

    public fun total_deposited<T0: store + key>(arg0: &Warehouse<T0>) : u64 {
        arg0.total_deposited
    }

    public fun total_redeemed<T0: store + key>(arg0: &Warehouse<T0>) : u64 {
        arg0.total_deposited - supply<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

