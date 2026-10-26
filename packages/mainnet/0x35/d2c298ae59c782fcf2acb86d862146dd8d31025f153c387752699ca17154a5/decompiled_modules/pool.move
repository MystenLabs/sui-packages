module 0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::pool {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        filled: vector<u256>,
        zeros: vector<u256>,
        next_index: u64,
        roots: vector<u256>,
        root_pos: u64,
        nullifiers: 0x2::table::Table<u256, bool>,
        vk_withdraw: 0x2::groth16::PreparedVerifyingKey,
        deposits: u64,
        withdrawals: u64,
    }

    struct Deposited<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        leaf: u256,
        index: u64,
        root: u256,
    }

    struct Withdrawn<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        nullifier: u256,
        object: 0x2::object::ID,
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::veiled::Veiled<T0>) : u64 {
        assert!(arg0.next_index < 1 << (20 as u8), 3);
        let v0 = 0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::veiled::burn_for_pool<T0>(arg1);
        let v1 = to_u256(&v0);
        let v2 = arg0.next_index;
        let v3 = v1;
        let v4 = 0;
        while (v4 < 20) {
            if (v2 % 2 == 0) {
                *0x1::vector::borrow_mut<u256>(&mut arg0.filled, v4) = v3;
                v3 = hash2(v3, *0x1::vector::borrow<u256>(&arg0.zeros, v4));
            } else {
                v3 = hash2(*0x1::vector::borrow<u256>(&arg0.filled, v4), v3);
            };
            v2 = v2 / 2;
            v4 = v4 + 1;
        };
        arg0.next_index = v2 + 1;
        arg0.root_pos = (arg0.root_pos + 1) % 32;
        *0x1::vector::borrow_mut<u256>(&mut arg0.roots, arg0.root_pos) = v3;
        arg0.deposits = arg0.deposits + 1;
        let v5 = Deposited<T0>{
            pool  : 0x2::object::id<Pool<T0>>(arg0),
            leaf  : v1,
            index : v2,
            root  : v3,
        };
        0x2::event::emit<Deposited<T0>>(v5);
        v2
    }

    public fun deposits<T0>(arg0: &Pool<T0>) : u64 {
        arg0.deposits
    }

    fun hash2(arg0: u256, arg1: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, arg0);
        0x1::vector::push_back<u256>(v1, arg1);
        0x2::poseidon::poseidon_bn254(&v0)
    }

    public fun is_known_root<T0>(arg0: &Pool<T0>, arg1: u256) : bool {
        let v0 = 0;
        while (v0 < 32) {
            if (*0x1::vector::borrow<u256>(&arg0.roots, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_spent<T0>(arg0: &Pool<T0>, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.nullifiers, arg1)
    }

    public fun new_pool<T0>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[0];
        let v1 = 1;
        while (v1 <= 20) {
            let v2 = *0x1::vector::borrow<u256>(&v0, v1 - 1);
            0x1::vector::push_back<u256>(&mut v0, hash2(v2, v2));
            v1 = v1 + 1;
        };
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 20) {
            0x1::vector::push_back<u256>(&mut v3, *0x1::vector::borrow<u256>(&v0, v5));
            v5 = v5 + 1;
        };
        let v6 = 0;
        while (v6 < 32) {
            0x1::vector::push_back<u256>(&mut v4, *0x1::vector::borrow<u256>(&v0, 20));
            v6 = v6 + 1;
        };
        let v7 = 0x2::groth16::bn254();
        let v8 = Pool<T0>{
            id          : 0x2::object::new(arg1),
            filled      : v3,
            zeros       : v0,
            next_index  : 0,
            roots       : v4,
            root_pos    : 0,
            nullifiers  : 0x2::table::new<u256, bool>(arg1),
            vk_withdraw : 0x2::groth16::prepare_verifying_key(&v7, &arg0),
            deposits    : 0,
            withdrawals : 0,
        };
        0x2::transfer::share_object<Pool<T0>>(v8);
    }

    public fun next_index<T0>(arg0: &Pool<T0>) : u64 {
        arg0.next_index
    }

    public fun root<T0>(arg0: &Pool<T0>) : u256 {
        *0x1::vector::borrow<u256>(&arg0.roots, arg0.root_pos)
    }

    fun to_bytes(arg0: u256) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    fun to_u256(arg0: &vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(arg0) == 32, 4);
        let v0 = 0;
        let v1 = 32;
        while (v1 > 0) {
            let v2 = v1 - 1;
            v1 = v2;
            let v3 = v0 << 8;
            v0 = v3 | (*0x1::vector::borrow<u8>(arg0, v2) as u256);
        };
        v0
    }

    public fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: u256, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: vector<u8>, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg3) == 32, 4);
        assert!(is_known_root<T0>(arg0, arg1), 2);
        assert!(!0x2::table::contains<u256, bool>(&arg0.nullifiers, arg2), 1);
        let v0 = to_bytes(arg1);
        0x1::vector::append<u8>(&mut v0, to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, arg3);
        let v1 = 0x2::groth16::bn254();
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(v0);
        let v3 = 0x2::groth16::proof_points_from_bytes(arg5);
        assert!(0x2::groth16::verify_groth16_proof(&v1, &arg0.vk_withdraw, &v2, &v3), 0);
        0x2::table::add<u256, bool>(&mut arg0.nullifiers, arg2, true);
        arg0.withdrawals = arg0.withdrawals + 1;
        let v4 = 0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::veiled::mint_for_pool<T0>(arg3, arg4, arg9);
        let v5 = Withdrawn<T0>{
            pool      : 0x2::object::id<Pool<T0>>(arg0),
            nullifier : arg2,
            object    : 0x2::object::id<0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::veiled::Veiled<T0>>(&v4),
        };
        0x2::event::emit<Withdrawn<T0>>(v5);
        0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::veiled::send<T0>(v4, arg6, arg7, arg8);
    }

    public fun withdrawals<T0>(arg0: &Pool<T0>) : u64 {
        arg0.withdrawals
    }

    public fun zero_at<T0>(arg0: &Pool<T0>, arg1: u64) : u256 {
        *0x1::vector::borrow<u256>(&arg0.zeros, arg1)
    }

    // decompiled from Move bytecode v7
}

