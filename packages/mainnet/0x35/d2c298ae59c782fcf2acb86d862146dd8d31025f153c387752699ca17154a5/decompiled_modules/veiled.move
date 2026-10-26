module 0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::veiled {
    struct Veiled<phantom T0> has store, key {
        id: 0x2::object::UID,
        commitment: vector<u8>,
        cipher: vector<u8>,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        reserve: 0x2::balance::Balance<T0>,
        vk_commit: 0x2::groth16::PreparedVerifyingKey,
        vk_split: 0x2::groth16::PreparedVerifyingKey,
        vk_merge: 0x2::groth16::PreparedVerifyingKey,
        cap: u64,
        veiled_total: u64,
        admin: address,
        fee_in_bps: u64,
        fee_out_bps: u64,
        treasury: address,
        fees_collected: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct Announcement has copy, drop {
        object: 0x2::object::ID,
        ephemeral: vector<u8>,
        view_tag: u8,
    }

    struct Veiled_<phantom T0> has copy, drop {
        object: 0x2::object::ID,
        vault: 0x2::object::ID,
    }

    struct Unveiled<phantom T0> has copy, drop {
        object: 0x2::object::ID,
        vault: 0x2::object::ID,
        value: u64,
    }

    public fun split<T0>(arg0: &Vault<T0>, arg1: Veiled<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : (Veiled<T0>, Veiled<T0>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32 && 0x1::vector::length<u8>(&arg4) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg3) <= 256 && 0x1::vector::length<u8>(&arg5) <= 256, 5);
        let Veiled {
            id         : v0,
            commitment : v1,
            cipher     : _,
        } = arg1;
        let v3 = v1;
        0x1::vector::append<u8>(&mut v3, arg2);
        0x1::vector::append<u8>(&mut v3, arg4);
        let v4 = 0x2::groth16::bn254();
        let v5 = 0x2::groth16::public_proof_inputs_from_bytes(v3);
        let v6 = 0x2::groth16::proof_points_from_bytes(arg6);
        assert!(0x2::groth16::verify_groth16_proof(&v4, &arg0.vk_split, &v5, &v6), 0);
        0x2::object::delete(v0);
        let v7 = Veiled<T0>{
            id         : 0x2::object::new(arg7),
            commitment : arg2,
            cipher     : arg3,
        };
        let v8 = Veiled<T0>{
            id         : 0x2::object::new(arg7),
            commitment : arg4,
            cipher     : arg5,
        };
        (v7, v8)
    }

    public(friend) fun burn_for_pool<T0>(arg0: Veiled<T0>) : vector<u8> {
        let Veiled {
            id         : v0,
            commitment : v1,
            cipher     : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun cap<T0>(arg0: &Vault<T0>) : u64 {
        arg0.cap
    }

    public fun cipher<T0>(arg0: &Veiled<T0>) : &vector<u8> {
        &arg0.cipher
    }

    public fun commitment<T0>(arg0: &Veiled<T0>) : &vector<u8> {
        &arg0.commitment
    }

    entry fun create_vault<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = new_vault<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg4));
    }

    fun fee_at(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        ((((arg1 as u128) * (arg0 as u128) + 9999) / 10000) as u64)
    }

    public fun fee_in<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        fee_at(arg0.fee_in_bps, arg1)
    }

    public fun fee_in_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.fee_in_bps
    }

    public fun fee_out<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        fee_at(arg0.fee_out_bps, arg1)
    }

    public fun fee_out_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.fee_out_bps
    }

    public fun fees_collected<T0>(arg0: &Vault<T0>) : u64 {
        arg0.fees_collected
    }

    public fun merge<T0>(arg0: &Vault<T0>, arg1: Veiled<T0>, arg2: Veiled<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : Veiled<T0> {
        assert!(0x1::vector::length<u8>(&arg3) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg4) <= 256, 5);
        let Veiled {
            id         : v0,
            commitment : v1,
            cipher     : _,
        } = arg1;
        let Veiled {
            id         : v3,
            commitment : v4,
            cipher     : _,
        } = arg2;
        let v6 = v1;
        0x1::vector::append<u8>(&mut v6, v4);
        0x1::vector::append<u8>(&mut v6, arg3);
        let v7 = 0x2::groth16::bn254();
        let v8 = 0x2::groth16::public_proof_inputs_from_bytes(v6);
        let v9 = 0x2::groth16::proof_points_from_bytes(arg5);
        assert!(0x2::groth16::verify_groth16_proof(&v7, &arg0.vk_merge, &v8, &v9), 0);
        0x2::object::delete(v0);
        0x2::object::delete(v3);
        Veiled<T0>{
            id         : 0x2::object::new(arg6),
            commitment : arg3,
            cipher     : arg4,
        }
    }

    public(friend) fun mint_for_pool<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : Veiled<T0> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 5);
        Veiled<T0>{
            id         : 0x2::object::new(arg2),
            commitment : arg0,
            cipher     : arg1,
        }
    }

    public fun new_vault<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::groth16::bn254();
        let v1 = 0x2::groth16::bn254();
        let v2 = 0x2::groth16::bn254();
        let v3 = Vault<T0>{
            id             : 0x2::object::new(arg4),
            reserve        : 0x2::balance::zero<T0>(),
            vk_commit      : 0x2::groth16::prepare_verifying_key(&v0, &arg0),
            vk_split       : 0x2::groth16::prepare_verifying_key(&v1, &arg1),
            vk_merge       : 0x2::groth16::prepare_verifying_key(&v2, &arg2),
            cap            : arg3,
            veiled_total   : 0,
            admin          : 0x2::tx_context::sender(arg4),
            fee_in_bps     : 25,
            fee_out_bps    : 0,
            treasury       : 0x2::tx_context::sender(arg4),
            fees_collected : 0,
        };
        let v4 = AdminCap{
            id    : 0x2::object::new(arg4),
            vault : 0x2::object::id<Vault<T0>>(&v3),
        };
        0x2::transfer::share_object<Vault<T0>>(v3);
        v4
    }

    public fun reserve<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve)
    }

    fun scalar_from_u64(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            if (v1 < 8) {
                0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
                arg0 = arg0 >> 8;
            } else {
                0x1::vector::push_back<u8>(&mut v0, 0);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun send<T0>(arg0: Veiled<T0>, arg1: address, arg2: vector<u8>, arg3: u8) {
        assert!(0x1::vector::length<u8>(&arg2) == 33, 3);
        let v0 = Announcement{
            object    : 0x2::object::id<Veiled<T0>>(&arg0),
            ephemeral : arg2,
            view_tag  : arg3,
        };
        0x2::event::emit<Announcement>(v0);
        0x2::transfer::public_transfer<Veiled<T0>>(arg0, arg1);
    }

    public fun set_cap<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64) {
        assert!(arg1.vault == 0x2::object::id<Vault<T0>>(arg0), 4);
        arg0.cap = arg2;
    }

    public fun set_fee<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: address) {
        assert!(arg1.vault == 0x2::object::id<Vault<T0>>(arg0), 4);
        assert!(arg2 <= 500 && arg3 <= 500, 6);
        arg0.fee_in_bps = arg2;
        arg0.fee_out_bps = arg3;
        arg0.treasury = arg4;
    }

    public fun unveil<T0>(arg0: &mut Vault<T0>, arg1: Veiled<T0>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Veiled {
            id         : v0,
            commitment : v1,
            cipher     : _,
        } = arg1;
        let v3 = v1;
        let v4 = v0;
        verify_commit(&arg0.vk_commit, arg2, &v3, &arg3);
        0x2::object::delete(v4);
        arg0.veiled_total = arg0.veiled_total - arg2;
        let v5 = Unveiled<T0>{
            object : 0x2::object::uid_to_inner(&v4),
            vault  : 0x2::object::id<Vault<T0>>(arg0),
            value  : arg2,
        };
        0x2::event::emit<Unveiled<T0>>(v5);
        let v6 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, arg2), arg4);
        let v7 = fee_out<T0>(arg0, arg2);
        if (v7 > 0 && v7 < arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, v7, arg4), arg0.treasury);
            arg0.fees_collected = arg0.fees_collected + v7;
        };
        v6
    }

    public fun veil<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : Veiled<T0> {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg3) <= 256, 5);
        let v0 = fee_in<T0>(arg0, 0x2::coin::value<T0>(&arg1));
        assert!(0x2::coin::value<T0>(&arg1) > v0, 7);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0, arg5), arg0.treasury);
            arg0.fees_collected = arg0.fees_collected + v0;
        };
        let v1 = 0x2::coin::value<T0>(&arg1);
        verify_commit(&arg0.vk_commit, v1, &arg2, &arg4);
        if (arg0.cap > 0) {
            assert!(arg0.veiled_total + v1 <= arg0.cap, 2);
        };
        arg0.veiled_total = arg0.veiled_total + v1;
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg1));
        let v2 = Veiled<T0>{
            id         : 0x2::object::new(arg5),
            commitment : arg2,
            cipher     : arg3,
        };
        let v3 = Veiled_<T0>{
            object : 0x2::object::id<Veiled<T0>>(&v2),
            vault  : 0x2::object::id<Vault<T0>>(arg0),
        };
        0x2::event::emit<Veiled_<T0>>(v3);
        v2
    }

    public fun veiled_total<T0>(arg0: &Vault<T0>) : u64 {
        arg0.veiled_total
    }

    fun verify_commit(arg0: &0x2::groth16::PreparedVerifyingKey, arg1: u64, arg2: &vector<u8>, arg3: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg2) == 32, 1);
        let v0 = *arg2;
        0x1::vector::append<u8>(&mut v0, scalar_from_u64(arg1));
        let v1 = 0x2::groth16::bn254();
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(v0);
        let v3 = 0x2::groth16::proof_points_from_bytes(*arg3);
        assert!(0x2::groth16::verify_groth16_proof(&v1, arg0, &v2, &v3), 0);
    }

    // decompiled from Move bytecode v7
}

