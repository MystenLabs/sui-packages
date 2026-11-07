module 0x52a1234d3b5e741410a413476dedfc4a51b501074f2534466953554ffc82ceff::shield {
    struct Shield<phantom T0> has key {
        id: 0x2::object::UID,
        reserve: 0x2::balance::Balance<T0>,
        filled: vector<u256>,
        zeros: vector<u256>,
        tree: u64,
        next_index: u64,
        current_root: u256,
        root_at: 0x2::table::Table<u64, u256>,
        root_count: 0x2::table::Table<u256, u64>,
        calls: u64,
        nin: u64,
        deposits_open: bool,
        relay_fees_paid: u128,
        closed_roots: 0x2::table::Table<u256, bool>,
        min_shield: u64,
        nullifiers: 0x2::table::Table<u256, bool>,
        vk_shield: 0x2::groth16::PreparedVerifyingKey,
        vk_spend: 0x2::groth16::PreparedVerifyingKey,
        cap: u64,
        shielded_total: u64,
        admin: address,
        fee_in_bps: u64,
        treasury: address,
        fees_collected: u128,
        spends: u64,
    }

    struct ShieldAdmin has store, key {
        id: 0x2::object::UID,
        shield: 0x2::object::ID,
    }

    struct Note<phantom T0> has copy, drop {
        shield: 0x2::object::ID,
        tree: u64,
        index: u64,
        commitment: u256,
        ephemeral: vector<u8>,
        view_tag: u8,
        cipher: vector<u8>,
    }

    struct Spent<phantom T0> has copy, drop {
        shield: 0x2::object::ID,
        nullifier: u256,
    }

    struct Relayed<phantom T0> has copy, drop {
        shield: 0x2::object::ID,
        fee: u64,
        relayer: address,
    }

    struct Exited<phantom T0> has copy, drop {
        shield: 0x2::object::ID,
        value: u64,
        to: address,
    }

    struct Shielded<phantom T0> has copy, drop {
        shield: 0x2::object::ID,
        value: u64,
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

    public fun shield<T0>(arg0: &mut Shield<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg3) <= 256, 5);
        assert!(0x1::vector::length<u8>(&arg4) == 33, 3);
        assert!(arg0.deposits_open, 15);
        let v0 = fee_in<T0>(arg0, 0x2::coin::value<T0>(&arg1));
        assert!(0x2::coin::value<T0>(&arg1) > v0, 7);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0, arg7), arg0.treasury);
            arg0.fees_collected = arg0.fees_collected + (v0 as u128);
        };
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= arg0.min_shield, 10);
        0x1::vector::append<u8>(&mut arg2, scalar_from_u64(v1));
        let v2 = 0x2::groth16::bn254();
        let v3 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        let v4 = 0x2::groth16::proof_points_from_bytes(arg6);
        assert!(0x2::groth16::verify_groth16_proof(&v2, &arg0.vk_shield, &v3, &v4), 0);
        if (arg0.cap > 0) {
            assert!(arg0.shielded_total + v1 <= arg0.cap, 2);
        };
        arg0.shielded_total = arg0.shielded_total + v1;
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg1));
        let v5 = Shielded<T0>{
            shield : 0x2::object::id<Shield<T0>>(arg0),
            value  : v1,
        };
        0x2::event::emit<Shielded<T0>>(v5);
        make_room<T0>(arg0, 1);
        insert_leaf<T0>(arg0, canonical(to_u256(&arg2)), arg4, arg5, arg3);
        push_root<T0>(arg0);
    }

    public fun aux_of(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: address, arg4: u64, arg5: &vector<vector<u8>>, arg6: &vector<vector<u8>>, arg7: &vector<vector<u8>>, arg8: &vector<u8>) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, (arg2 as u256));
        0x1::vector::push_back<u256>(v1, (arg4 as u256));
        0x1::vector::push_back<u256>(v1, aux_raw(arg0, arg1, arg3, arg5, arg6, arg7, arg8));
        0x2::poseidon::poseidon_bn254(&v0)
    }

    public fun aux_raw(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: &vector<vector<u8>>, arg4: &vector<vector<u8>>, arg5: &vector<vector<u8>>, arg6: &vector<u8>) : u256 {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg3)) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(arg3, v1));
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(arg5, v1));
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg6, v1));
            0x1::vector::append<u8>(&mut v0, le8(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg4, v1))));
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(arg4, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::hash::blake2b256(&v0);
        to_u256(&v2) % 21888242871839275222246405745257275088548364400416034343698204186575808495617
    }

    public fun calls<T0>(arg0: &Shield<T0>) : u64 {
        arg0.calls
    }

    fun canonical(arg0: u256) : u256 {
        assert!(arg0 < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 13);
        arg0
    }

    public fun cap<T0>(arg0: &Shield<T0>) : u64 {
        arg0.cap
    }

    entry fun create_shield<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = new_shield<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::transfer<ShieldAdmin>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun deposits_open<T0>(arg0: &Shield<T0>) : bool {
        arg0.deposits_open
    }

    fun fee_at(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        ((((arg1 as u128) * (arg0 as u128) + 9999) / 10000) as u64)
    }

    public fun fee_in<T0>(arg0: &Shield<T0>, arg1: u64) : u64 {
        fee_at(arg0.fee_in_bps, arg1)
    }

    public fun fee_in_bps<T0>(arg0: &Shield<T0>) : u64 {
        arg0.fee_in_bps
    }

    public fun fee_out<T0>(arg0: &Shield<T0>, arg1: u64) : u64 {
        0
    }

    public fun fee_out_bps<T0>(arg0: &Shield<T0>) : u64 {
        0
    }

    public fun fees_collected<T0>(arg0: &Shield<T0>) : u128 {
        arg0.fees_collected
    }

    fun hash2(arg0: u256, arg1: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, arg0);
        0x1::vector::push_back<u256>(v1, arg1);
        0x2::poseidon::poseidon_bn254(&v0)
    }

    fun insert_leaf<T0>(arg0: &mut Shield<T0>, arg1: u256, arg2: vector<u8>, arg3: u8, arg4: vector<u8>) {
        let v0 = arg0.next_index;
        let v1 = arg1;
        let v2 = 0;
        while (v2 < 20) {
            if (v0 % 2 == 0) {
                *0x1::vector::borrow_mut<u256>(&mut arg0.filled, v2) = v1;
                v1 = hash2(v1, *0x1::vector::borrow<u256>(&arg0.zeros, v2));
            } else {
                v1 = hash2(*0x1::vector::borrow<u256>(&arg0.filled, v2), v1);
            };
            v0 = v0 / 2;
            v2 = v2 + 1;
        };
        arg0.next_index = v0 + 1;
        arg0.current_root = v1;
        let v3 = Note<T0>{
            shield     : 0x2::object::id<Shield<T0>>(arg0),
            tree       : arg0.tree,
            index      : v0,
            commitment : arg1,
            ephemeral  : arg2,
            view_tag   : arg3,
            cipher     : arg4,
        };
        0x2::event::emit<Note<T0>>(v3);
    }

    public fun is_known_root<T0>(arg0: &Shield<T0>, arg1: u256) : bool {
        if (arg1 == *0x1::vector::borrow<u256>(&arg0.zeros, 20)) {
            return false
        };
        if (0x2::table::contains<u256, bool>(&arg0.closed_roots, arg1)) {
            return true
        };
        0x2::table::contains<u256, u64>(&arg0.root_count, arg1)
    }

    public fun is_spent<T0>(arg0: &Shield<T0>, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.nullifiers, arg1)
    }

    fun le8(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    fun make_room<T0>(arg0: &mut Shield<T0>, arg1: u64) {
        if (arg0.next_index + arg1 <= 1 << (20 as u8)) {
            return
        };
        let v0 = arg0.current_root;
        if (!0x2::table::contains<u256, bool>(&arg0.closed_roots, v0)) {
            0x2::table::add<u256, bool>(&mut arg0.closed_roots, v0, true);
        };
        arg0.current_root = *0x1::vector::borrow<u256>(&arg0.zeros, 20);
        let v1 = 0;
        while (v1 < 20) {
            *0x1::vector::borrow_mut<u256>(&mut arg0.filled, v1) = *0x1::vector::borrow<u256>(&arg0.zeros, v1);
            v1 = v1 + 1;
        };
        arg0.tree = arg0.tree + 1;
        arg0.next_index = 0;
    }

    public fun min_shield<T0>(arg0: &Shield<T0>) : u64 {
        arg0.min_shield
    }

    public fun new_shield<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : ShieldAdmin {
        assert!(arg2 == 2 || arg2 == 4, 11);
        assert!(0x1::vector::length<u8>(&arg0) == 328, 18);
        assert!(0x1::vector::length<u8>(&arg1) == 232 + 32 * (arg2 + 4), 18);
        let v0 = vector[0];
        let v1 = 1;
        while (v1 <= 20) {
            let v2 = *0x1::vector::borrow<u256>(&v0, v1 - 1);
            0x1::vector::push_back<u256>(&mut v0, hash2(v2, v2));
            v1 = v1 + 1;
        };
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 20) {
            0x1::vector::push_back<u256>(&mut v3, *0x1::vector::borrow<u256>(&v0, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x2::groth16::bn254();
        let v6 = 0x2::groth16::bn254();
        let v7 = Shield<T0>{
            id              : 0x2::object::new(arg5),
            reserve         : 0x2::balance::zero<T0>(),
            filled          : v3,
            zeros           : v0,
            tree            : 0,
            next_index      : 0,
            current_root    : *0x1::vector::borrow<u256>(&v0, 20),
            root_at         : 0x2::table::new<u64, u256>(arg5),
            root_count      : 0x2::table::new<u256, u64>(arg5),
            calls           : 0,
            nin             : arg2,
            deposits_open   : true,
            relay_fees_paid : 0,
            closed_roots    : 0x2::table::new<u256, bool>(arg5),
            min_shield      : arg4,
            nullifiers      : 0x2::table::new<u256, bool>(arg5),
            vk_shield       : 0x2::groth16::prepare_verifying_key(&v5, &arg0),
            vk_spend        : 0x2::groth16::prepare_verifying_key(&v6, &arg1),
            cap             : arg3,
            shielded_total  : 0,
            admin           : 0x2::tx_context::sender(arg5),
            fee_in_bps      : 25,
            treasury        : 0x2::tx_context::sender(arg5),
            fees_collected  : 0,
            spends          : 0,
        };
        let v8 = ShieldAdmin{
            id     : 0x2::object::new(arg5),
            shield : 0x2::object::id<Shield<T0>>(&v7),
        };
        0x2::transfer::share_object<Shield<T0>>(v7);
        v8
    }

    public fun next_index<T0>(arg0: &Shield<T0>) : u64 {
        arg0.next_index
    }

    public fun nin<T0>(arg0: &Shield<T0>) : u64 {
        arg0.nin
    }

    fun push_root<T0>(arg0: &mut Shield<T0>) {
        let v0 = arg0.current_root;
        record_root<T0>(arg0, v0);
    }

    fun record_root<T0>(arg0: &mut Shield<T0>, arg1: u256) {
        let v0 = arg0.calls;
        if (v0 >= 4096) {
            let v1 = 0x2::table::remove<u64, u256>(&mut arg0.root_at, v0 - 4096);
            let v2 = 0x2::table::remove<u256, u64>(&mut arg0.root_count, v1);
            if (v2 > 1) {
                0x2::table::add<u256, u64>(&mut arg0.root_count, v1, v2 - 1);
            };
        };
        0x2::table::add<u64, u256>(&mut arg0.root_at, v0, arg1);
        if (0x2::table::contains<u256, u64>(&arg0.root_count, arg1)) {
            0x2::table::add<u256, u64>(&mut arg0.root_count, arg1, 0x2::table::remove<u256, u64>(&mut arg0.root_count, arg1) + 1);
        } else {
            0x2::table::add<u256, u64>(&mut arg0.root_count, arg1, 1);
        };
        arg0.calls = v0 + 1;
    }

    public fun relay_fees_paid<T0>(arg0: &Shield<T0>) : u128 {
        arg0.relay_fees_paid
    }

    public fun reserve<T0>(arg0: &Shield<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve)
    }

    public fun root<T0>(arg0: &Shield<T0>) : u256 {
        arg0.current_root
    }

    fun scalar_from_u64(arg0: u64) : vector<u8> {
        to_bytes((arg0 as u256))
    }

    public fun set_cap<T0>(arg0: &mut Shield<T0>, arg1: &ShieldAdmin, arg2: u64) {
        assert!(arg1.shield == 0x2::object::id<Shield<T0>>(arg0), 4);
        arg0.cap = arg2;
    }

    public fun set_deposits_open<T0>(arg0: &mut Shield<T0>, arg1: &ShieldAdmin, arg2: bool) {
        assert!(arg1.shield == 0x2::object::id<Shield<T0>>(arg0), 4);
        arg0.deposits_open = arg2;
    }

    public fun set_fee<T0>(arg0: &mut Shield<T0>, arg1: &ShieldAdmin, arg2: u64, arg3: address) {
        assert!(arg1.shield == 0x2::object::id<Shield<T0>>(arg0), 4);
        assert!(arg2 <= 500, 6);
        arg0.fee_in_bps = arg2;
        arg0.treasury = arg3;
    }

    public fun set_min_shield<T0>(arg0: &mut Shield<T0>, arg1: &ShieldAdmin, arg2: u64) {
        assert!(arg1.shield == 0x2::object::id<Shield<T0>>(arg0), 4);
        arg0.min_shield = arg2;
    }

    public fun shielded_total<T0>(arg0: &Shield<T0>) : u64 {
        arg0.shielded_total
    }

    public fun spend<T0>(arg0: &mut Shield<T0>, arg1: u256, arg2: vector<u256>, arg3: u64, arg4: address, arg5: u64, arg6: address, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: vector<u8>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.nin;
        assert!(0x1::vector::length<u256>(&arg2) == v0, 11);
        assert!(arg3 == 0 || arg4 != @0x0, 14);
        assert!(arg5 == 0 || arg6 != @0x0, 16);
        let v1 = if (0x1::vector::length<vector<u8>>(&arg7) == 4) {
            if (0x1::vector::length<vector<u8>>(&arg8) == 4) {
                if (0x1::vector::length<vector<u8>>(&arg9) == 4) {
                    0x1::vector::length<u8>(&arg10) == 4
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 11);
        assert!(is_known_root<T0>(arg0, canonical(arg1)), 8);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = canonical(*0x1::vector::borrow<u256>(&arg2, v2));
            assert!(!0x2::table::contains<u256, bool>(&arg0.nullifiers, v3), 9);
            let v4 = v2 + 1;
            while (v4 < v0) {
                assert!(*0x1::vector::borrow<u256>(&arg2, v4) != v3, 17);
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 4) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg7, v6)) == 32, 1);
            0x1::vector::push_back<u256>(&mut v5, canonical(to_u256(0x1::vector::borrow<vector<u8>>(&arg7, v6))));
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg8, v6)) <= 256, 5);
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg9, v6)) == 33, 3);
            v6 = v6 + 1;
        };
        let v7 = to_bytes(arg1);
        let v8 = 0;
        while (v8 < v0) {
            0x1::vector::append<u8>(&mut v7, to_bytes(*0x1::vector::borrow<u256>(&arg2, v8)));
            v8 = v8 + 1;
        };
        0x1::vector::append<u8>(&mut v7, to_bytes(aux_of(0x2::object::id<Shield<T0>>(arg0), arg4, arg3, arg6, arg5, &arg7, &arg8, &arg9, &arg10)));
        0x1::vector::append<u8>(&mut v7, to_bytes(0x2::poseidon::poseidon_bn254(&v5)));
        let v9 = 0x2::groth16::bn254();
        let v10 = 0x2::groth16::public_proof_inputs_from_bytes(v7);
        let v11 = 0x2::groth16::proof_points_from_bytes(arg11);
        assert!(0x2::groth16::verify_groth16_proof(&v9, &arg0.vk_spend, &v10, &v11), 0);
        let v12 = 0x2::object::id<Shield<T0>>(arg0);
        let v13 = 0;
        while (v13 < v0) {
            0x2::table::add<u256, bool>(&mut arg0.nullifiers, *0x1::vector::borrow<u256>(&arg2, v13), true);
            let v14 = Spent<T0>{
                shield    : v12,
                nullifier : *0x1::vector::borrow<u256>(&arg2, v13),
            };
            0x2::event::emit<Spent<T0>>(v14);
            v13 = v13 + 1;
        };
        make_room<T0>(arg0, 4);
        let v15 = 0;
        while (v15 < 4) {
            insert_leaf<T0>(arg0, *0x1::vector::borrow<u256>(&v5, v15), *0x1::vector::borrow<vector<u8>>(&arg9, v15), *0x1::vector::borrow<u8>(&arg10, v15), *0x1::vector::borrow<vector<u8>>(&arg8, v15));
            v15 = v15 + 1;
        };
        push_root<T0>(arg0);
        arg0.spends = arg0.spends + 1;
        let v16 = (arg3 as u128) + (arg5 as u128);
        if (v16 > 0) {
            assert!((0x2::balance::value<T0>(&arg0.reserve) as u128) >= v16, 12);
            arg0.shielded_total = arg0.shielded_total - (v16 as u64);
        };
        if (arg5 > 0) {
            arg0.relay_fees_paid = arg0.relay_fees_paid + (arg5 as u128);
            let v17 = Relayed<T0>{
                shield  : v12,
                fee     : arg5,
                relayer : arg6,
            };
            0x2::event::emit<Relayed<T0>>(v17);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, arg5), arg12), arg6);
        };
        if (arg3 > 0) {
            let v18 = Exited<T0>{
                shield : v12,
                value  : arg3,
                to     : arg4,
            };
            0x2::event::emit<Exited<T0>>(v18);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, arg3), arg12), arg4);
        };
    }

    public fun spends<T0>(arg0: &Shield<T0>) : u64 {
        arg0.spends
    }

    fun to_u256(arg0: &vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(arg0) == 32, 1);
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

    public fun tree<T0>(arg0: &Shield<T0>) : u64 {
        arg0.tree
    }

    public fun zero_at<T0>(arg0: &Shield<T0>, arg1: u64) : u256 {
        *0x1::vector::borrow<u256>(&arg0.zeros, arg1)
    }

    // decompiled from Move bytecode v7
}

