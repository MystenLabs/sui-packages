module 0x6079064ac33231765f37635953df3245cc80cb1e090cd5ed98f20b5a94f3ccaa::earndrop {
    struct Stage has copy, drop, store {
        stage_id: u256,
        start_time: u256,
        end_time: u256,
    }

    struct Earndrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        earndrop_id: u128,
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
        signer: address,
        treasurer: address,
        earndrops: 0x2::table::Table<u256, 0x2::object::ID>,
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

    public fun activate_earndrop<T0>(arg0: &mut GalxeTable, arg1: u256, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u256>, arg5: vector<u256>, arg6: vector<u256>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 < 340282366920938463463374607431768211455, 13906834655379718145);
        assert!(arg1 > 0, 13906834659674816515);
        assert!(!0x2::table::contains<u256, 0x2::object::ID>(&arg0.earndrops, arg1), 13906834663970308107);
        let v0 = (0x2::coin::value<T0>(&arg2) as u256);
        assert!(v0 > 0, 13906834676854816773);
        let v1 = 0x1::vector::length<u256>(&arg4);
        assert!(v1 > 0, 13906834694034817031);
        assert!(v1 == 0x1::vector::length<u256>(&arg5), 13906834698329915401);
        assert!(v1 == 0x1::vector::length<u256>(&arg6), 13906834702624882697);
        let v2 = 0x2::table::new<u256, Stage>(arg9);
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u256>(&arg4, v3);
            let v5 = *0x1::vector::borrow<u256>(&arg5, v3);
            let v6 = *0x1::vector::borrow<u256>(&arg6, v3);
            assert!(v5 <= v6 && v5 >= (0x2::clock::timestamp_ms(arg8) as u256), 13906834745574948879);
            assert!(!0x2::table::contains<u256, Stage>(&v2, v4), 13906834749870047249);
            let v7 = Stage{
                stage_id   : v4,
                start_time : v5,
                end_time   : v6,
            };
            0x2::table::add<u256, Stage>(&mut v2, v4, v7);
            v3 = v3 + 1;
        };
        let v8 = Earndrop<T0>{
            id               : 0x2::object::new(arg9),
            earndrop_id      : (arg1 as u128),
            balance          : 0x2::coin::into_balance<T0>(arg2),
            revoked          : false,
            merkle_tree_root : arg3,
            total_amount     : v0,
            claimed_amount   : 0,
            stages           : v2,
            claimed          : 0x2::table::new<u256, bool>(arg9),
        };
        let v9 = 0x2::object::id<Earndrop<T0>>(&v8);
        0x2::table::add<u256, 0x2::object::ID>(&mut arg0.earndrops, arg1, v9);
        0x2::transfer::share_object<Earndrop<T0>>(v8);
        let v10 = ActivateEarndropEvent{
            earndrop_id     : (arg1 as u256),
            earndrop_obj_id : v9,
        };
        0x2::event::emit<ActivateEarndropEvent>(v10);
        v9
    }

    public fun claim<T0, T1>(arg0: &GalxeTable, arg1: &mut Earndrop<T0>, arg2: u256, arg3: u256, arg4: u64, arg5: vector<vector<u8>>, arg6: 0x2::coin::Coin<T1>, arg7: address, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.revoked, 13906834973208870937);
        assert!(!is_claimed<T0>(arg1, arg3), 13906834981799067677);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = 0x2::table::borrow<u256, Stage>(&arg1.stages, arg2);
        assert!((v0 as u256) >= v1.start_time && (v0 as u256) <= v1.end_time, 13906834998978412565);
        verify_merkle_proof(arg5, arg1.merkle_tree_root, arg7, arg4);
        assert!(arg1.claimed_amount + (arg4 as u256) <= arg1.total_amount, 13906835050518151191);
        arg1.claimed_amount = arg1.claimed_amount + (arg4 as u256);
        0x2::table::add<u256, bool>(&mut arg1.claimed, arg3, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg4), arg10), arg7);
        let v2 = 0x2::coin::value<T1>(&arg6);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg6, arg0.treasurer);
        } else {
            0x2::coin::destroy_zero<T1>(arg6);
        };
        let v3 = ClaimEvent{
            earndrop_id : (arg1.earndrop_id as u256),
            stage_id    : arg2,
            leaf_index  : arg3,
            account     : arg7,
            amount      : arg4,
            claim_fee   : v2,
        };
        0x2::event::emit<ClaimEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GalxeTable{
            id        : 0x2::object::new(arg0),
            signer    : @0xe39fbd818a1134f62627778852373f9889e0b5b29cd2eaa62a7f84ee16a40bc1,
            treasurer : @0xe39fbd818a1134f62627778852373f9889e0b5b29cd2eaa62a7f84ee16a40bc1,
            earndrops : 0x2::table::new<u256, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<GalxeTable>(v0);
    }

    public fun is_claimed<T0>(arg0: &Earndrop<T0>, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.claimed, arg1)
    }

    fun verify_merkle_proof(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: address, arg3: u64) : bool {
        true
    }

    // decompiled from Move bytecode v6
}

