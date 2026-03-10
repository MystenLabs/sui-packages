module 0xb5ae92de5c71a1d15ac6e5ed681e6e1cfb7ea82563ed753fc629efca0e73d86e::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        denomination: u64,
        balance: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
        tree: 0xb5ae92de5c71a1d15ac6e5ed681e6e1cfb7ea82563ed753fc629efca0e73d86e::merkle_tree::MerkleTreeState,
        nullifiers: 0x2::table::Table<u256, bool>,
        known_roots: 0x2::table::Table<u256, bool>,
    }

    struct DepositEvent has copy, drop {
        commitment: u256,
        leaf_index: u64,
        new_root: u256,
        timestamp: u64,
    }

    struct WithdrawalEvent has copy, drop {
        nullifier_hash: u256,
        recipient: address,
        fee: u64,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: address,
        denomination: u64,
    }

    public fun get_root<T0>(arg0: &Pool<T0>) : u256 {
        0xb5ae92de5c71a1d15ac6e5ed681e6e1cfb7ea82563ed753fc629efca0e73d86e::merkle_tree::get_root(&arg0.tree)
    }

    fun address_to_u256(arg0: address) : u256 {
        let v0 = 0x2::address::to_bytes(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            let v3 = v1 << 8;
            v1 = v3 | (*0x1::vector::borrow<u8>(&v0, v2) as u256);
            v2 = v2 + 1;
        };
        v1
    }

    fun append_u256_le(arg0: &mut vector<u8>, arg1: u256) {
        let v0 = 0;
        while (v0 < 32) {
            0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
            arg1 = arg1 >> 8;
            v0 = v0 + 1;
        };
    }

    fun compute_fee(arg0: u64) : u64 {
        let v0 = arg0 * 15 / 10000;
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    public entry fun create_pool<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb5ae92de5c71a1d15ac6e5ed681e6e1cfb7ea82563ed753fc629efca0e73d86e::merkle_tree::new();
        let v1 = 0x2::table::new<u256, bool>(arg2);
        0x2::table::add<u256, bool>(&mut v1, 0xb5ae92de5c71a1d15ac6e5ed681e6e1cfb7ea82563ed753fc629efca0e73d86e::merkle_tree::get_root(&v0), true);
        let v2 = Pool<T0>{
            id           : 0x2::object::new(arg2),
            denomination : arg1,
            balance      : 0x2::balance::zero<T0>(),
            fees         : 0x2::balance::zero<T0>(),
            tree         : v0,
            nullifiers   : 0x2::table::new<u256, bool>(arg2),
            known_roots  : v1,
        };
        let v3 = PoolCreatedEvent{
            pool_id      : 0x2::object::uid_to_address(&v2.id),
            denomination : arg1,
        };
        0x2::event::emit<PoolCreatedEvent>(v3);
        0x2::transfer::share_object<Pool<T0>>(v2);
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.denomination, 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = 0xb5ae92de5c71a1d15ac6e5ed681e6e1cfb7ea82563ed753fc629efca0e73d86e::merkle_tree::get_root(&arg0.tree);
        if (!0x2::table::contains<u256, bool>(&arg0.known_roots, v0)) {
            0x2::table::add<u256, bool>(&mut arg0.known_roots, v0, true);
        };
        let v1 = DepositEvent{
            commitment : arg2,
            leaf_index : 0xb5ae92de5c71a1d15ac6e5ed681e6e1cfb7ea82563ed753fc629efca0e73d86e::merkle_tree::insert(&mut arg0.tree, arg2),
            new_root   : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun encode_public_inputs(arg0: u256, arg1: u256, arg2: address, arg3: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        append_u256_le(v1, arg0 % 21888242871839275222246405745257275088548364400416034343698204186575808495617);
        let v2 = &mut v0;
        append_u256_le(v2, arg1 % 21888242871839275222246405745257275088548364400416034343698204186575808495617);
        let v3 = &mut v0;
        append_u256_le(v3, address_to_u256(arg2) % 21888242871839275222246405745257275088548364400416034343698204186575808495617);
        let v4 = &mut v0;
        append_u256_le(v4, (arg3 as u256) % 21888242871839275222246405745257275088548364400416034343698204186575808495617);
        v0
    }

    public fun get_balance<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_denomination<T0>(arg0: &Pool<T0>) : u64 {
        arg0.denomination
    }

    public fun get_deposit_count<T0>(arg0: &Pool<T0>) : u64 {
        0xb5ae92de5c71a1d15ac6e5ed681e6e1cfb7ea82563ed753fc629efca0e73d86e::merkle_tree::get_next_index(&arg0.tree)
    }

    fun get_vk_bytes() : vector<u8> {
        x"e2f26dbea299f5223b646cb1fb33eadb059d9407559d7441dfd902e3a79a4d2dabb73dc17fbc13021e2471e0c08bd67d8401f52b73d6d07483794cad4778180e0c06f33bbc4c79a9cadef253a68084d382f17788f885c9afd176f7cb2f036789edf692d95cbdde46ddda5ef7d422436779445c5e66006a42761e1f12efde0018c212f3aeb785e49712e7a9353349aaf1255dfb31b7bf60723a480d9293938e19edf692d95cbdde46ddda5ef7d422436779445c5e66006a42761e1f12efde0018c212f3aeb785e49712e7a9353349aaf1255dfb31b7bf60723a480d9293938e190500000000000000a6c8dc49f1abe55da75df3f9f87a7e9cef89f643f5ba8d00289698e0a3fe3b98b1670febc7f7bb3fb890bc93dcb05bb01267f7e4c94dced3ba91ea26f869b209c6a9ad196a08053727eaecdf7129b6c76c76df6f55fb34e31a1e51516896012e7fd8a973b2fc4b2fffad538d3128ae010b3849c064f1ab6de08c862fe6b39205972a163f4aeb1fb69581080e65ab3707da4259ce89e562ae9824186e0aed7584"
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_nullifier_used<T0>(arg0: &Pool<T0>, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.nullifiers, arg1)
    }

    public fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: vector<u8>, arg2: u256, arg3: u256, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u256, bool>(&arg0.known_roots, arg2), 3);
        assert!(!0x2::table::contains<u256, bool>(&arg0.nullifiers, arg3), 2);
        let v0 = 0x2::groth16::bn254();
        let v1 = get_vk_bytes();
        let v2 = 0x2::groth16::prepare_verifying_key(&v0, &v1);
        let v3 = compute_fee(arg0.denomination);
        let v4 = 0x2::groth16::public_proof_inputs_from_bytes(encode_public_inputs(arg2, arg3, arg4, v3));
        let v5 = 0x2::groth16::proof_points_from_bytes(arg1);
        assert!(0x2::groth16::verify_groth16_proof(&v0, &v2, &v4, &v5), 4);
        0x2::table::add<u256, bool>(&mut arg0.nullifiers, arg3, true);
        let v6 = arg0.denomination;
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v6, 5);
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut arg0.balance, v3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v6 - v3), arg5), arg4);
        let v7 = WithdrawalEvent{
            nullifier_hash : arg3,
            recipient      : arg4,
            fee            : v3,
        };
        0x2::event::emit<WithdrawalEvent>(v7);
    }

    public entry fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fees, 0x2::balance::value<T0>(&arg1.fees)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

