module 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::shielded_pool {
    struct MerkleTreeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RelayerPolicyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RelayerPolicy has copy, drop, store {
        relayer: address,
        max_fee: u64,
    }

    struct ShieldedPool<phantom T0> has key {
        id: 0x2::object::UID,
        curve: 0x2::groth16::Curve,
        vk: 0x2::groth16::PreparedVerifyingKey,
        balance: 0x2::balance::Balance<T0>,
        nullifier_hashes: 0x2::table::Table<u256, bool>,
        paused: bool,
        max_deposit: u64,
        max_withdraw: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::ascii::String, address>,
    }

    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
        pool: address,
    }

    public fun new<T0>(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : (ShieldedPool<T0>, PoolAdminCap) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(!0x2::table::contains<0x1::ascii::String, address>(&arg0.pools, v0), 807);
        let v1 = 0x2::groth16::bn254();
        let v2 = x"0400f07bc59c5d8eea2d649783a55fcbc64dd793fa1d102e87bb7872bf7fc6853adb445f837298fe2cdc8f935f1658612acec5d538831b9a6542412bbf36321ff5acd09efdf65b13e029ed3b8b3f5a6ebe1b68c12c0c847918db75267527e5a87a0201288a0d169552021541b9ffd92e959ad3dac3e8a21608369684683ae512a1868d2f05c002d9fc6dd1d61d6741a4c262970b896abbda2ee5c8c8b28085ac7226a2ac22840639b823f79dc682d2ffbabf053562c44c018e5c3326e1ca3e04703e766fdc2aeaade5b3d890979bb2b27e9fed88542f9e0e12597e697624309d09000000000000008ff673d2e70b20cf402f0eb3ac0c2c5b29acacacde983fdf16ae05d0e390b512de33cdb8f0886968fd89b590b0674679306803af6e8ee1a6ea595da51918122c81b949bd05f397ccec60a1a10c3fb7c7e9fb26c654654b7595b157249bd4439729479f9487d16c5590dbd6c9d5e6f25ec46ceabc3ae9af3b4101b7f132c40f233dd7031fdb1257e7a66b7bd72d7982913efc556c0782faf2a026b9855591f383e223ccce2f9cc47c2e85ba4c0223d3442cfea04104d3b48014da37aa19b57306cd18602b8c1955902007e772e70eac9fd19b9e520b3e54bb37015f8309d0e922883762fc1fc4aa8956e1c5f7b352db26b5f46996df5baf69100adaad7e9d7118cb4ae1fbbed3ea13f96779f1be6fb248ba5622afb4ebc92bcdf93f62c72a4b14";
        let v3 = ShieldedPool<T0>{
            id               : 0x2::object::new(arg1),
            curve            : v1,
            vk               : 0x2::groth16::prepare_verifying_key(&v1, &v2),
            balance          : 0x2::balance::zero<T0>(),
            nullifier_hashes : 0x2::table::new<u256, bool>(arg1),
            paused           : false,
            max_deposit      : 0,
            max_withdraw     : 0,
        };
        let v4 = 0x2::object::uid_to_address(&v3.id);
        0x2::table::add<0x1::ascii::String, address>(&mut arg0.pools, v0, v4);
        let v5 = MerkleTreeKey{dummy_field: false};
        0x2::dynamic_object_field::add<MerkleTreeKey, 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::MerkleTree>(&mut v3.id, v5, 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::new(arg1));
        let v6 = RelayerPolicyKey{dummy_field: false};
        let v7 = RelayerPolicy{
            relayer : @0x0,
            max_fee : 0,
        };
        0x2::dynamic_field::add<RelayerPolicyKey, RelayerPolicy>(&mut v3.id, v6, v7);
        0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::events::new_pool<T0>(v4);
        let v8 = PoolAdminCap{
            id   : 0x2::object::new(arg1),
            pool : v4,
        };
        (v3, v8)
    }

    public fun is_known_root<T0>(arg0: &ShieldedPool<T0>, arg1: u256) : bool {
        0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::is_known_root(merkle_tree<T0>(arg0), arg1)
    }

    public fun next_index<T0>(arg0: &ShieldedPool<T0>) : u64 {
        0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::next_index(merkle_tree<T0>(arg0))
    }

    public fun root<T0>(arg0: &ShieldedPool<T0>) : u256 {
        0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::root(merkle_tree<T0>(arg0))
    }

    fun assert_cap<T0>(arg0: &ShieldedPool<T0>, arg1: &PoolAdminCap) {
        assert!(arg1.pool == 0x2::object::uid_to_address(&arg0.id), 802);
    }

    fun assert_compliant<T0>(arg0: &ShieldedPool<T0>, arg1: 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::ExtData) {
        assert!(!arg0.paused, 810);
        let v0 = 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::value(arg1);
        if (v0 == 0) {
            return
        };
        if (0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::value_sign(arg1)) {
            if (arg0.max_deposit > 0) {
                assert!(v0 <= arg0.max_deposit, 810);
            };
        } else if (arg0.max_withdraw > 0) {
            assert!(v0 <= arg0.max_withdraw, 810);
        };
    }

    fun assert_pool<T0>(arg0: &ShieldedPool<T0>, arg1: address) {
        assert!(arg1 == 0x2::object::uid_to_address(&arg0.id), 802);
    }

    fun assert_public_value<T0>(arg0: 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::Proof<T0>, arg1: 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::ExtData) {
        assert!(0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::public_value<T0>(arg0) == 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::public_value(arg1), 804);
    }

    fun assert_relayer_fee<T0>(arg0: &ShieldedPool<T0>, arg1: 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::ExtData) {
        let v0 = 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::relayer_fee(arg1);
        if (v0 == 0) {
            return
        };
        let v1 = 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::value(arg1);
        assert!(v1 > 0, 811);
        assert!(v0 <= v1, 811);
        assert!((v0 as u128) * (10000 as u128) <= (v1 as u128) * (500 as u128), 811);
        let v2 = relayer_policy_or_closed<T0>(arg0);
        assert!(v2.relayer != @0x0, 811);
        assert!(0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::relayer(arg1) == v2.relayer, 811);
        assert!(v0 <= v2.max_fee, 811);
    }

    fun assert_root_is_known<T0>(arg0: &ShieldedPool<T0>, arg1: u256) {
        assert!(0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::is_known_root(merkle_tree<T0>(arg0), arg1), 800);
    }

    fun assert_value_conserved(arg0: u64, arg1: u64, arg2: 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::ExtData) {
        if (0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::value_sign(arg2)) {
            assert!(arg1 == arg0 + 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::value(arg2) - 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::relayer_fee(arg2), 812);
        } else {
            assert!(arg1 + 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::value(arg2) == arg0, 812);
        };
    }

    public fun balance_value<T0>(arg0: &ShieldedPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<0x1::ascii::String, address>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_nullifier_spent<T0>(arg0: &ShieldedPool<T0>, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.nullifier_hashes, arg1)
    }

    public fun is_paused<T0>(arg0: &ShieldedPool<T0>) : bool {
        arg0.paused
    }

    public fun max_relayer_fee_bps() : u64 {
        500
    }

    fun merkle_tree<T0>(arg0: &ShieldedPool<T0>) : &0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::MerkleTree {
        let v0 = MerkleTreeKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<MerkleTreeKey, 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::MerkleTree>(&arg0.id, v0)
    }

    fun merkle_tree_mut<T0>(arg0: &mut ShieldedPool<T0>) : &mut 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::MerkleTree {
        let v0 = MerkleTreeKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<MerkleTreeKey, 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::MerkleTree>(&mut arg0.id, v0)
    }

    public fun pool_address<T0>(arg0: &Registry) : 0x1::option::Option<address> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (0x2::table::contains<0x1::ascii::String, address>(&arg0.pools, v0)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::ascii::String, address>(&arg0.pools, v0))
        } else {
            0x1::option::none<address>()
        }
    }

    fun process_transaction<T0>(arg0: &mut ShieldedPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::groth16::PublicProofInputs, arg3: 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::Proof<T0>, arg4: 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::ExtData, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_pool<T0>(arg0, 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::pool<T0>(arg3));
        assert_root_is_known<T0>(arg0, 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::root<T0>(arg3));
        0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::assert_relayer(arg4, arg5);
        assert_relayer_fee<T0>(arg0, arg4);
        assert_public_value<T0>(arg3, arg4);
        let v0 = 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::input_nullifiers<T0>(arg3);
        0x1::vector::reverse<u256>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&v0)) {
            assert!(!is_nullifier_spent<T0>(arg0, 0x1::vector::pop_back<u256>(&mut v0)), 803);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u256>(v0);
        let v2 = 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::points<T0>(arg3);
        assert!(0x2::groth16::verify_groth16_proof(&arg0.curve, &arg0.vk, &arg2, &v2), 801);
        assert_compliant<T0>(arg0, arg4);
        let v3 = 0x2::balance::value<T0>(&arg0.balance);
        let v4 = 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::value(arg4);
        if (0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::value_sign(arg4) && v4 > 0) {
            assert!(0x2::coin::value<T0>(&arg1) == v4, 805);
        };
        let v5 = if (!0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::value_sign(arg4) && v4 > 0) {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v4 - 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::relayer_fee(arg4)), arg5)
        } else {
            0x2::coin::zero<T0>(arg5)
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v6 = 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::input_nullifiers<T0>(arg3);
        0x1::vector::reverse<u256>(&mut v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u256>(&v6)) {
            let v8 = 0x1::vector::pop_back<u256>(&mut v6);
            0x2::table::add<u256, bool>(&mut arg0.nullifier_hashes, v8, true);
            0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::events::nullifier_spent<T0>(v8);
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<u256>(v6);
        let v9 = 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::output_commitments<T0>(arg3);
        let v10 = merkle_tree_mut<T0>(arg0);
        let v11 = 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::next_index(v10);
        0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::merkle::append_pair(v10, *0x1::vector::borrow<u256>(&v9, 0), *0x1::vector::borrow<u256>(&v9, 1));
        0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::events::new_commitment<T0>(v11, *0x1::vector::borrow<u256>(&v9, 0), 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::encrypted_output0(arg4));
        0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::events::new_commitment<T0>(v11 + 1, *0x1::vector::borrow<u256>(&v9, 1), 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::encrypted_output1(arg4));
        if (0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::relayer_fee(arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::relayer_fee(arg4)), arg5), 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::relayer(arg4));
        };
        assert_value_conserved(v3, 0x2::balance::value<T0>(&arg0.balance), arg4);
        v5
    }

    public fun relayer_policy<T0>(arg0: &ShieldedPool<T0>) : (address, u64) {
        let v0 = relayer_policy_or_closed<T0>(arg0);
        (v0.relayer, v0.max_fee)
    }

    fun relayer_policy_or_closed<T0>(arg0: &ShieldedPool<T0>) : RelayerPolicy {
        let v0 = RelayerPolicyKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<RelayerPolicyKey, RelayerPolicy>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<RelayerPolicyKey, RelayerPolicy>(&arg0.id, v0)
        } else {
            RelayerPolicy{relayer: @0x0, max_fee: 0}
        }
    }

    public fun set_caps<T0>(arg0: &mut ShieldedPool<T0>, arg1: &PoolAdminCap, arg2: u64, arg3: u64) {
        assert_cap<T0>(arg0, arg1);
        arg0.max_deposit = arg2;
        arg0.max_withdraw = arg3;
    }

    public fun set_paused<T0>(arg0: &mut ShieldedPool<T0>, arg1: &PoolAdminCap, arg2: bool) {
        assert_cap<T0>(arg0, arg1);
        arg0.paused = arg2;
    }

    public fun set_relayer_policy<T0>(arg0: &mut ShieldedPool<T0>, arg1: &PoolAdminCap, arg2: address, arg3: u64) {
        assert_cap<T0>(arg0, arg1);
        let v0 = RelayerPolicyKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<RelayerPolicyKey, RelayerPolicy>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<RelayerPolicyKey, RelayerPolicy>(&mut arg0.id, v0);
            v1.relayer = arg2;
            v1.max_fee = arg3;
        } else {
            let v2 = RelayerPolicy{
                relayer : arg2,
                max_fee : arg3,
            };
            0x2::dynamic_field::add<RelayerPolicyKey, RelayerPolicy>(&mut arg0.id, v0, v2);
        };
        0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::events::relayer_policy_set<T0>(0x2::object::uid_to_address(&arg0.id), arg2, arg3);
    }

    public fun share<T0>(arg0: ShieldedPool<T0>) {
        0x2::transfer::share_object<ShieldedPool<T0>>(arg0);
    }

    public fun transact<T0>(arg0: &mut ShieldedPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::Proof<T0>, arg3: 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::ExtData, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        process_transaction<T0>(arg0, arg1, 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::public_inputs<T0>(arg2), arg2, arg3, arg4)
    }

    public fun transact_with_account<T0>(arg0: &mut ShieldedPool<T0>, arg1: &mut 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::note_account::NoteAccount, arg2: 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::Proof<T0>, arg3: 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::ext_data::ExtData, arg4: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::note_account::receive<T0>(arg1, arg4, arg5);
        process_transaction<T0>(arg0, v0, 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::proof::account_public_inputs<T0>(arg2, 0x36d80185b4ee5890f95e743142fac280952ab013310a4b609d165f20fa1f26b4::note_account::hashed_secret(arg1)), arg2, arg3, arg5)
    }

    // decompiled from Move bytecode v7
}

