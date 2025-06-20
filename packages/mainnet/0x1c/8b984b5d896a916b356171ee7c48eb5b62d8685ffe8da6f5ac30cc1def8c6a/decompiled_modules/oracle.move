module 0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::oracle {
    struct SmgInfoAdded has copy, drop {
        smg_id: vector<u8>,
        gpk: vector<u8>,
        status: u8,
        start_time: u64,
        end_time: u64,
        hash_type: u8,
        added_time: u64,
    }

    struct SmgStatusChanged has copy, drop {
        smg_id: vector<u8>,
        old_status: u8,
        new_status: u8,
    }

    struct SmgRemoved has copy, drop {
        smg_id: vector<u8>,
    }

    struct SmgInfo has drop, store {
        gpk: vector<u8>,
        status: u8,
        start_time: u64,
        end_time: u64,
        hash_type: u8,
        added_time: u64,
        active: bool,
    }

    struct OracleStorage has key {
        id: 0x2::object::UID,
        smgs: 0x2::table::Table<vector<u8>, SmgInfo>,
    }

    struct ORACLE has drop {
        dummy_field: bool,
    }

    public entry fun activate_smg(arg0: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::Admin, arg1: &mut OracleStorage, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::assert_oracle(arg0, arg4);
        assert!(0x2::table::contains<vector<u8>, SmgInfo>(&arg1.smgs, arg3), 1);
        let v0 = 0x2::table::borrow_mut<vector<u8>, SmgInfo>(&mut arg1.smgs, arg3);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= v0.added_time + 86400, 9);
        v0.active = true;
    }

    public entry fun add_smg_info(arg0: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::Admin, arg1: &mut OracleStorage, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::assert_oracle(arg0, arg9);
        assert!(arg6 < arg7, 4);
        assert!(arg8 == 0 || arg8 == 1, 7);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = SmgInfo{
            gpk        : arg4,
            status     : arg5,
            start_time : arg6,
            end_time   : arg7,
            hash_type  : arg8,
            added_time : v0,
            active     : false,
        };
        if (0x2::table::contains<vector<u8>, SmgInfo>(&arg1.smgs, arg3)) {
            0x2::table::remove<vector<u8>, SmgInfo>(&mut arg1.smgs, arg3);
            0x2::table::add<vector<u8>, SmgInfo>(&mut arg1.smgs, arg3, v1);
        } else {
            0x2::table::add<vector<u8>, SmgInfo>(&mut arg1.smgs, arg3, v1);
        };
        let v2 = SmgInfoAdded{
            smg_id     : arg3,
            gpk        : arg4,
            status     : arg5,
            start_time : arg6,
            end_time   : arg7,
            hash_type  : arg8,
            added_time : v0,
        };
        0x2::event::emit<SmgInfoAdded>(v2);
    }

    public fun get_smg_info(arg0: &OracleStorage, arg1: vector<u8>) : (vector<u8>, u8, u64, u64, u8, bool) {
        assert!(0x2::table::contains<vector<u8>, SmgInfo>(&arg0.smgs, arg1), 1);
        let v0 = 0x2::table::borrow<vector<u8>, SmgInfo>(&arg0.smgs, arg1);
        (v0.gpk, v0.status, v0.start_time, v0.end_time, v0.hash_type, v0.active)
    }

    fun init(arg0: ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleStorage{
            id   : 0x2::object::new(arg1),
            smgs : 0x2::table::new<vector<u8>, SmgInfo>(arg1),
        };
        0x2::transfer::share_object<OracleStorage>(v0);
    }

    public entry fun remove_smg_info(arg0: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::Admin, arg1: &mut OracleStorage, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::assert_operator(arg0, arg3);
        assert!(0x2::table::contains<vector<u8>, SmgInfo>(&arg1.smgs, arg2), 1);
        0x2::table::remove<vector<u8>, SmgInfo>(&mut arg1.smgs, arg2);
        let v0 = SmgRemoved{smg_id: arg2};
        0x2::event::emit<SmgRemoved>(v0);
    }

    public fun smg_exists(arg0: &OracleStorage, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, SmgInfo>(&arg0.smgs, arg1)
    }

    public entry fun update_smg_status(arg0: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::Admin, arg1: &mut OracleStorage, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::assert_oracle(arg0, arg4);
        assert!(0x2::table::contains<vector<u8>, SmgInfo>(&arg1.smgs, arg2), 1);
        let v0 = 0x2::table::borrow_mut<vector<u8>, SmgInfo>(&mut arg1.smgs, arg2);
        v0.status = arg3;
        let v1 = SmgStatusChanged{
            smg_id     : arg2,
            old_status : v0.status,
            new_status : arg3,
        };
        0x2::event::emit<SmgStatusChanged>(v1);
    }

    public fun verify_signature(arg0: &OracleStorage, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, SmgInfo>(&arg0.smgs, arg2), 1);
        let v0 = 0x2::table::borrow<vector<u8>, SmgInfo>(&arg0.smgs, arg2);
        assert!(v0.status == 5, 5);
        assert!(v0.active, 5);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v1 >= v0.start_time && v1 <= v0.end_time, 6);
        let v2 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg4, &arg3, v0.hash_type);
        let v3 = 0x2::ecdsa_k1::decompress_pubkey(&v2);
        let v4 = 0x1::vector::length<u8>(&v3);
        assert!(v4 > 0, 2);
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 1;
        while (v6 < v4) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&v3, v6));
            v6 = v6 + 1;
        };
        assert!(v5 == v0.gpk, 2);
    }

    public fun verify_smg_id(arg0: &OracleStorage, arg1: &0x2::clock::Clock, arg2: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, SmgInfo>(&arg0.smgs, arg2), 1);
        let v0 = 0x2::table::borrow<vector<u8>, SmgInfo>(&arg0.smgs, arg2);
        assert!(v0.status == 5, 5);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v1 >= v0.start_time && v1 <= v0.end_time, 6);
    }

    // decompiled from Move bytecode v6
}

