module 0x1b88fabd26b4197529cd06736f1be8c34db51960bd247e1e8f5afcd12bcb3420::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
        vk: 0x2::groth16::PreparedVerifyingKey,
        zeros: vector<u256>,
        filled: vector<u256>,
        roots: vector<u256>,
        root_index: u64,
        next_index: u64,
        nullifiers: 0x2::table::Table<u256, bool>,
        unit: u64,
        max_tx: u64,
        max_tvl: u64,
        max_relayer_fee: u64,
    }

    struct ExtData has drop {
        pool: 0x2::object::ID,
        recipient: address,
        withdraw: u64,
        relayer: address,
        relayer_fee: u64,
        enc_outputs: vector<vector<u8>>,
    }

    struct NewCommitment has copy, drop {
        pool: 0x2::object::ID,
        commitment: u256,
        index: u64,
        encrypted: vector<u8>,
    }

    struct NewNullifier has copy, drop {
        pool: 0x2::object::ID,
        nullifier: u256,
    }

    fun new<T0>(arg0: 0x2::groth16::PreparedVerifyingKey, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        let v0 = vector[0];
        let v1 = 0;
        while (v1 < 32) {
            let v2 = *0x1::vector::borrow<u256>(&v0, v1);
            0x1::vector::push_back<u256>(&mut v0, h2(v2, v2));
            v1 = v1 + 1;
        };
        let v3 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v3, *0x1::vector::borrow<u256>(&v0, 32));
        Pool<T0>{
            id              : 0x2::object::new(arg5),
            version         : 1,
            balance         : 0x2::balance::zero<T0>(),
            fees            : 0x2::balance::zero<T0>(),
            vk              : arg0,
            zeros           : v0,
            filled          : v0,
            roots           : v3,
            root_index      : 0,
            next_index      : 0,
            nullifiers      : 0x2::table::new<u256, bool>(arg5),
            unit            : arg1,
            max_tx          : arg2,
            max_tvl         : arg3,
            max_relayer_fee : arg4,
        }
    }

    public fun create<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::groth16::bn254();
        0x2::transfer::share_object<Pool<T0>>(new<T0>(0x2::groth16::prepare_verifying_key(&v0, &arg1), arg2, arg3, arg4, arg5, arg6));
    }

    fun h2(arg0: u256, arg1: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, arg0);
        0x1::vector::push_back<u256>(v1, arg1);
        0x2::poseidon::poseidon_bn254(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun insert<T0>(arg0: &mut Pool<T0>, arg1: u256) : (u64, u256) {
        let v0 = arg0.next_index;
        assert!(v0 < 1 << (32 as u8), 7);
        let v1 = arg1;
        let v2 = 0;
        while (v2 < 32) {
            if (v0 % 2 == 0) {
                *0x1::vector::borrow_mut<u256>(&mut arg0.filled, v2) = v1;
                v1 = h2(v1, *0x1::vector::borrow<u256>(&arg0.zeros, v2));
            } else {
                v1 = h2(*0x1::vector::borrow<u256>(&arg0.filled, v2), v1);
            };
            v0 = v0 / 2;
            v2 = v2 + 1;
        };
        arg0.next_index = v0 + 1;
        (v0, v1)
    }

    public fun is_known_root<T0>(arg0: &Pool<T0>, arg1: u256) : bool {
        0x1::vector::contains<u256>(&arg0.roots, &arg1)
    }

    public fun last_root<T0>(arg0: &Pool<T0>) : u256 {
        *0x1::vector::borrow<u256>(&arg0.roots, arg0.root_index)
    }

    public fun migrate<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>) {
        assert!(arg1.version < 1, 9);
        arg1.version = 1;
    }

    fun push_root<T0>(arg0: &mut Pool<T0>, arg1: u256) {
        arg0.root_index = (arg0.root_index + 1) % 500;
        if (0x1::vector::length<u256>(&arg0.roots) < 500) {
            0x1::vector::push_back<u256>(&mut arg0.roots, arg1);
        } else {
            *0x1::vector::borrow_mut<u256>(&mut arg0.roots, arg0.root_index) = arg1;
        };
    }

    public fun set_limits<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg1.version == 1, 9);
        arg1.unit = arg2;
        arg1.max_tx = arg3;
        arg1.max_tvl = arg4;
        arg1.max_relayer_fee = arg5;
    }

    public fun set_vk<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: vector<u8>) {
        assert!(arg1.version == 1, 9);
        let v0 = 0x2::groth16::bn254();
        arg1.vk = 0x2::groth16::prepare_verifying_key(&v0, &arg2);
    }

    public fun transact<T0>(arg0: &mut Pool<T0>, arg1: vector<u8>, arg2: u256, arg3: vector<u256>, arg4: vector<u256>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: address, arg8: address, arg9: u64, arg10: vector<vector<u8>>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 9);
        assert!(0x1::vector::length<u256>(&arg3) == 2 && 0x1::vector::length<u256>(&arg4) == 2, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg10) == 2, 3);
        assert!(is_known_root<T0>(arg0, arg2), 0);
        let v0 = &arg3;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(v0)) {
            assert!(!0x2::table::contains<u256, bool>(&arg0.nullifiers, *0x1::vector::borrow<u256>(v0, v1)), 1);
            v1 = v1 + 1;
        };
        let v2 = 0x2::coin::value<T0>(&arg5);
        assert!(v2 > 0 || arg6 > 0, 10);
        assert!(arg9 <= arg6 && arg9 <= arg0.max_relayer_fee, 8);
        assert!(v2 % arg0.unit == 0 && (arg6 - arg9) % arg0.unit == 0, 4);
        assert!(v2 <= arg0.max_tx && arg6 <= arg0.max_tx, 5);
        assert!(0x2::balance::value<T0>(&arg0.balance) + v2 <= arg0.max_tvl, 6);
        let v3 = if (v2 >= arg6) {
            ((v2 - arg6) as u256)
        } else {
            21888242871839275222246405745257275088548364400416034343698204186575808495617 - ((arg6 - v2) as u256)
        };
        let v4 = v3;
        let v5 = ExtData{
            pool        : 0x2::object::id<Pool<T0>>(arg0),
            recipient   : arg7,
            withdraw    : arg6,
            relayer     : arg8,
            relayer_fee : arg9,
            enc_outputs : arg10,
        };
        let v6 = 0x2::bcs::to_bytes<ExtData>(&v5);
        let v7 = 0x2::bcs::new(0x2::hash::blake2b256(&v6));
        let v8 = 0x2::bcs::peel_u256(&mut v7) % 21888242871839275222246405745257275088548364400416034343698204186575808495617;
        let v9 = b"";
        0x1::vector::append<u8>(&mut v9, 0x2::bcs::to_bytes<u256>(&arg2));
        0x1::vector::append<u8>(&mut v9, 0x2::bcs::to_bytes<u256>(&v4));
        0x1::vector::append<u8>(&mut v9, 0x2::bcs::to_bytes<u256>(&v8));
        let v10 = &arg3;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u256>(v10)) {
            0x1::vector::append<u8>(&mut v9, 0x2::bcs::to_bytes<u256>(0x1::vector::borrow<u256>(v10, v11)));
            v11 = v11 + 1;
        };
        let v12 = &arg4;
        let v13 = 0;
        while (v13 < 0x1::vector::length<u256>(v12)) {
            0x1::vector::append<u8>(&mut v9, 0x2::bcs::to_bytes<u256>(0x1::vector::borrow<u256>(v12, v13)));
            v13 = v13 + 1;
        };
        let v14 = 0x2::groth16::bn254();
        let v15 = 0x2::groth16::public_proof_inputs_from_bytes(v9);
        let v16 = 0x2::groth16::proof_points_from_bytes(arg1);
        assert!(0x2::groth16::verify_groth16_proof(&v14, &arg0.vk, &v15, &v16), 2);
        let v17 = 0x2::object::id<Pool<T0>>(arg0);
        0x1::vector::reverse<u256>(&mut arg3);
        let v18 = 0;
        while (v18 < 0x1::vector::length<u256>(&arg3)) {
            let v19 = 0x1::vector::pop_back<u256>(&mut arg3);
            0x2::table::add<u256, bool>(&mut arg0.nullifiers, v19, true);
            let v20 = NewNullifier{
                pool      : v17,
                nullifier : v19,
            };
            0x2::event::emit<NewNullifier>(v20);
            v18 = v18 + 1;
        };
        0x1::vector::destroy_empty<u256>(arg3);
        let ExtData {
            pool        : _,
            recipient   : _,
            withdraw    : _,
            relayer     : _,
            relayer_fee : _,
            enc_outputs : v26,
        } = v5;
        let v27 = v26;
        let v28 = 0;
        let v29 = 0;
        while (v28 < 2) {
            let (v30, v31) = insert<T0>(arg0, *0x1::vector::borrow<u256>(&arg4, v28));
            v29 = v31;
            let v32 = NewCommitment{
                pool       : v17,
                commitment : *0x1::vector::borrow<u256>(&arg4, v28),
                index      : v30,
                encrypted  : *0x1::vector::borrow<vector<u8>>(&v27, v28),
            };
            0x2::event::emit<NewCommitment>(v32);
            v28 = v28 + 1;
        };
        push_root<T0>(arg0, v29);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg5));
        if (arg6 > 0) {
            let v33 = 0x2::balance::split<T0>(&mut arg0.balance, arg6);
            if (arg9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v33, arg9), arg11), arg8);
            };
            0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v33, (arg6 - arg9) * 50 / 10000));
            if (0x2::balance::value<T0>(&v33) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v33, arg11), arg7);
            } else {
                0x2::balance::destroy_zero<T0>(v33);
            };
        };
    }

    public fun version<T0>(arg0: &Pool<T0>) : u64 {
        arg0.version
    }

    public fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 9);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.fees), arg2)
    }

    // decompiled from Move bytecode v7
}

