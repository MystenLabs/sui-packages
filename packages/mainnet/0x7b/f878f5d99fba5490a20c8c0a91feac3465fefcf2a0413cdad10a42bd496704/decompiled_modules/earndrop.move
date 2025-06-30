module 0x7bf878f5d99fba5490a20c8c0a91feac3465fefcf2a0413cdad10a42bd496704::earndrop {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Stage has copy, drop, store {
        stage_id: u256,
        start_time: u256,
        end_time: u256,
    }

    struct Earndrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        earndrop_id: u128,
        admin: address,
        balance: 0x2::balance::Balance<T0>,
        revoked: bool,
        merkle_tree_root: vector<u8>,
        total_amount: u256,
        claimed_amount: u256,
        stages: 0x2::table::Table<u256, Stage>,
        claimed: 0x2::table::Table<u256, bool>,
    }

    struct GalxeTable has key {
        id: 0x2::object::UID,
        treasurer: address,
        earndrops: 0x2::table::Table<u256, 0x2::object::ID>,
        signer_key: vector<u8>,
    }

    struct ActivateEarndropChallenge has drop {
        earndrop_id: u64,
        coin_type: 0x1::ascii::String,
        amount: u64,
        merkle_tree_root: vector<u8>,
        admin: address,
    }

    struct ClaimChallenge has drop {
        earndrop_id: u64,
        leaf_index: u64,
        claim_fee: u64,
        amount: u64,
        claim_to: address,
    }

    struct ClaimEvent has copy, drop {
        earndrop_id: u256,
        stage_id: u256,
        leaf_index: u256,
        account: address,
        amount: u64,
        claim_fee: u64,
    }

    struct ActivateEarndropEvent has copy, drop {
        earndrop_id: u256,
        earndrop_obj_id: 0x2::object::ID,
    }

    struct EarndropRevokedEvent has copy, drop {
        earndrop_id: u256,
        recipient: address,
        remaining_amount: u64,
    }

    public fun activate_earndrop<T0>(arg0: &mut GalxeTable, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u256>, arg5: vector<u256>, arg6: vector<u256>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 > 0, 13906834921667690497);
        assert!(!0x2::table::contains<u256, 0x2::object::ID>(&arg0.earndrops, (arg1 as u256)), 13906834925963182089);
        let v0 = (0x2::coin::value<T0>(&arg2) as u256);
        assert!(v0 > 0, 13906834938847690755);
        let v1 = 0x1::vector::length<u256>(&arg4);
        assert!(v1 > 0, 13906834951732723717);
        assert!(v1 == 0x1::vector::length<u256>(&arg5), 13906834956027822087);
        assert!(v1 == 0x1::vector::length<u256>(&arg6), 13906834960322789383);
        let v2 = 0x2::table::new<u256, Stage>(arg9);
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u256>(&arg4, v3);
            let v5 = *0x1::vector::borrow<u256>(&arg5, v3);
            let v6 = *0x1::vector::borrow<u256>(&arg6, v3);
            assert!(v5 <= v6 && v5 >= (0x2::clock::timestamp_ms(arg8) as u256), 13906835003272855565);
            assert!(!0x2::table::contains<u256, Stage>(&v2, v4), 13906835007567953935);
            let v7 = Stage{
                stage_id   : v4,
                start_time : v5,
                end_time   : v6,
            };
            0x2::table::add<u256, Stage>(&mut v2, v4, v7);
            v3 = v3 + 1;
        };
        let v8 = ActivateEarndropChallenge{
            earndrop_id      : arg1,
            coin_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount           : 0x2::coin::value<T0>(&arg2),
            merkle_tree_root : arg3,
            admin            : 0x2::tx_context::sender(arg9),
        };
        assert!(verify_activate_signature(arg0, &v8, &arg7), 13906835089172070411);
        let v9 = Earndrop<T0>{
            id               : 0x2::object::new(arg9),
            earndrop_id      : (arg1 as u128),
            admin            : 0x2::tx_context::sender(arg9),
            balance          : 0x2::coin::into_balance<T0>(arg2),
            revoked          : false,
            merkle_tree_root : arg3,
            total_amount     : v0,
            claimed_amount   : 0,
            stages           : v2,
            claimed          : 0x2::table::new<u256, bool>(arg9),
        };
        let v10 = 0x2::object::id<Earndrop<T0>>(&v9);
        0x2::table::add<u256, 0x2::object::ID>(&mut arg0.earndrops, (arg1 as u256), v10);
        0x2::transfer::share_object<Earndrop<T0>>(v9);
        let v11 = ActivateEarndropEvent{
            earndrop_id     : (arg1 as u256),
            earndrop_obj_id : v10,
        };
        0x2::event::emit<ActivateEarndropEvent>(v11);
        v10
    }

    public fun address_to_bytes20(arg0: address) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        if (v1 >= 20) {
            let v3 = 0x1::vector::empty<u8>();
            let v4 = v1 - 20;
            while (v4 < v1) {
                0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v0, v4));
                v4 = v4 + 1;
            };
            v3
        } else {
            let v5 = 0x1::vector::empty<u8>();
            let v6 = 0;
            while (v6 < 20 - v1) {
                0x1::vector::push_back<u8>(&mut v5, 0);
                v6 = v6 + 1;
            };
            0x1::vector::append<u8>(&mut v5, v0);
            v5
        }
    }

    fun bytes_compare(arg0: &vector<u8>, arg1: &vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 < v5) {
                return 0
            };
            if (v4 > v5) {
                return 2
            };
            v3 = v3 + 1;
        };
        if (v0 < v1) {
            0
        } else if (v0 > v1) {
            2
        } else {
            1
        }
    }

    public fun claim<T0, T1>(arg0: &GalxeTable, arg1: &mut Earndrop<T0>, arg2: u256, arg3: u256, arg4: u64, arg5: vector<vector<u8>>, arg6: 0x2::coin::Coin<T1>, arg7: address, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.revoked, 13906835260971548695);
        assert!(!is_claimed<T0>(arg1, arg3), 13906835269561614361);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = 0x2::table::borrow<u256, Stage>(&arg1.stages, arg2);
        assert!((v0 as u256) >= v1.start_time && (v0 as u256) <= v1.end_time, 13906835286741090323);
        let v2 = ClaimChallenge{
            earndrop_id : (arg1.earndrop_id as u64),
            leaf_index  : (arg3 as u64),
            claim_fee   : 0x2::coin::value<T1>(&arg6),
            amount      : arg4,
            claim_to    : arg7,
        };
        assert!(verify_claim_signature(arg0, &v2, &arg8), 13906835333985206283);
        assert!(verify_merkle_proof(arg5, arg1.merkle_tree_root, arg7, arg4, (arg1.earndrop_id as u256), arg2, arg3), 13906835381230239761);
        assert!(arg1.claimed_amount + (arg4 as u256) <= arg1.total_amount, 13906835385525469205);
        arg1.claimed_amount = arg1.claimed_amount + (arg4 as u256);
        0x2::table::add<u256, bool>(&mut arg1.claimed, arg3, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg4), arg10), arg7);
        let v3 = 0x2::coin::value<T1>(&arg6);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg6, arg0.treasurer);
        } else {
            0x2::coin::destroy_zero<T1>(arg6);
        };
        let v4 = ClaimEvent{
            earndrop_id : (arg1.earndrop_id as u256),
            stage_id    : arg2,
            leaf_index  : arg3,
            account     : arg7,
            amount      : arg4,
            claim_fee   : v3,
        };
        0x2::event::emit<ClaimEvent>(v4);
    }

    public fun create_leaf_hash(arg0: u256, arg1: u256, arg2: u256, arg3: address, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, u256_to_bytes32_be(arg0));
        0x1::vector::append<u8>(&mut v0, u256_to_bytes32_be(arg1));
        0x1::vector::append<u8>(&mut v0, u256_to_bytes32_be(arg2));
        0x1::vector::append<u8>(&mut v0, address_to_bytes20(arg3));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes32_be(arg4));
        0x2::hash::keccak256(&v0)
    }

    fun efficient_hash(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x2::hash::keccak256(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GalxeTable{
            id         : 0x2::object::new(arg0),
            treasurer  : @0x945150d87519d70ac7392b4c04d3e8c0bdb2ebf814ba1259cf22b0d0e91bb3a5,
            earndrops  : 0x2::table::new<u256, 0x2::object::ID>(arg0),
            signer_key : x"bb3266b86640989d108bb6491f5b5de13d741419ecc39d14dfcca27f3e3abe39",
        };
        0x2::transfer::share_object<GalxeTable>(v1);
    }

    public fun is_claimed<T0>(arg0: &Earndrop<T0>, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.claimed, arg1)
    }

    public fun revoke_earndrop<T0>(arg0: &mut Earndrop<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13906835634634096669);
        revoke_earndrop_internal<T0>(arg0, arg1, arg2);
    }

    entry fun revoke_earndrop_by_admin_cap<T0>(arg0: &mut AdminCap, arg1: &mut Earndrop<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        revoke_earndrop_internal<T0>(arg1, arg2, arg3);
    }

    fun revoke_earndrop_internal<T0>(arg0: &mut Earndrop<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.revoked, 13906835681878605851);
        arg0.revoked = true;
        let v0 = arg0.total_amount - arg0.claimed_amount;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, (v0 as u64)), arg2), arg1);
        };
        let v1 = EarndropRevokedEvent{
            earndrop_id      : (arg0.earndrop_id as u256),
            recipient        : arg1,
            remaining_amount : (v0 as u64),
        };
        0x2::event::emit<EarndropRevokedEvent>(v1);
    }

    public fun u256_to_bytes32_be(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun u64_to_bytes32_be(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 24) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<u8>();
        v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v2, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        0x1::vector::reverse<u8>(&mut v2);
        0x1::vector::append<u8>(&mut v0, v2);
        v0
    }

    entry fun update_signer_key(arg0: &mut AdminCap, arg1: &mut GalxeTable, arg2: vector<u8>) {
        arg1.signer_key = arg2;
    }

    entry fun update_treasurer(arg0: &mut AdminCap, arg1: &mut GalxeTable, arg2: address) {
        arg1.treasurer = arg2;
    }

    fun verify_activate_signature(arg0: &GalxeTable, arg1: &ActivateEarndropChallenge, arg2: &vector<u8>) : bool {
        let v0 = 0x2::bcs::to_bytes<ActivateEarndropChallenge>(arg1);
        let v1 = 0x2::hash::keccak256(&v0);
        let v2 = arg0.signer_key;
        0x2::ed25519::ed25519_verify(arg2, &v2, &v1)
    }

    fun verify_claim_signature(arg0: &GalxeTable, arg1: &ClaimChallenge, arg2: &vector<u8>) : bool {
        let v0 = 0x2::bcs::to_bytes<ClaimChallenge>(arg1);
        let v1 = 0x2::hash::keccak256(&v0);
        let v2 = arg0.signer_key;
        0x2::ed25519::ed25519_verify(arg2, &v2, &v1)
    }

    public fun verify_merkle_proof(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u256, arg5: u256, arg6: u256) : bool {
        verify_merkle_proof_openzeppelin(arg0, arg1, create_leaf_hash(arg4, arg5, arg6, arg2, arg3))
    }

    public fun verify_merkle_proof_openzeppelin(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        if (0x1::vector::is_empty<vector<u8>>(&arg0)) {
            return arg2 == arg1
        };
        let v0 = arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(&arg0, v1);
            let v3 = bytes_compare(&v0, &v2);
            if (v3 == 0 || v3 == 1) {
                let v4 = &v0;
                v0 = efficient_hash(v4, &v2);
            } else {
                let v5 = &v0;
                v0 = efficient_hash(&v2, v5);
            };
            v1 = v1 + 1;
        };
        v0 == arg1
    }

    // decompiled from Move bytecode v6
}

