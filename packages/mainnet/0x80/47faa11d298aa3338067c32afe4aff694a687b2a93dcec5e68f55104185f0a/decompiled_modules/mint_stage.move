module 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage {
    struct MintStage has copy, drop, store {
        name: 0x1::string::String,
        price: u64,
        start_time_ms: u64,
        end_time_ms: u64,
        per_wallet_limit: u64,
        is_allowlist: bool,
        merkle_root: 0x1::option::Option<vector<u8>>,
    }

    struct MintStageConfig has drop, store {
        stages: vector<MintStage>,
    }

    struct MintRecords has store {
        map: 0x2::table::Table<u64, 0x2::table::Table<address, u64>>,
    }

    public fun destroy_records(arg0: MintRecords) {
        let MintRecords { map: v0 } = arg0;
        0x2::table::destroy_empty<u64, 0x2::table::Table<address, u64>>(v0);
    }

    public fun e_mint_limit_exceeded() : u64 {
        103
    }

    public fun empty_config() : MintStageConfig {
        MintStageConfig{stages: 0x1::vector::empty<MintStage>()}
    }

    public fun get_active_stage(arg0: &MintStageConfig, arg1: &0x2::clock::Clock) : (MintStage, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<MintStage>(&arg0.stages)) {
            let v2 = *0x1::vector::borrow<MintStage>(&arg0.stages, v1);
            if (v0 >= v2.start_time_ms && v0 < v2.end_time_ms) {
                return (v2, v1)
            };
            v1 = v1 + 1;
        };
        abort 100
    }

    public fun get_wallet_mint_count(arg0: &MintRecords, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&arg0.map, arg2)) {
            return 0
        };
        let v0 = 0x2::table::borrow<u64, 0x2::table::Table<address, u64>>(&arg0.map, arg2);
        if (!0x2::table::contains<address, u64>(v0, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(v0, arg1)
    }

    public fun has_stages(arg0: &MintStageConfig) : bool {
        !0x1::vector::is_empty<MintStage>(&arg0.stages)
    }

    public fun increment_wallet_mints(arg0: &mut MintRecords, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&arg0.map, arg2)) {
            0x2::table::add<u64, 0x2::table::Table<address, u64>>(&mut arg0.map, arg2, 0x2::table::new<address, u64>(arg4));
        };
        let v0 = 0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg0.map, arg2);
        if (!0x2::table::contains<address, u64>(v0, arg1)) {
            0x2::table::add<address, u64>(v0, arg1, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(v0, arg1);
        if (arg3 > 0) {
            assert!(*v1 + 1 <= arg3, 103);
        };
        *v1 = *v1 + 1;
    }

    public fun new_config(arg0: vector<MintStage>) : MintStageConfig {
        assert!(!0x1::vector::is_empty<MintStage>(&arg0), 101);
        validate_sequence(&arg0);
        MintStageConfig{stages: arg0}
    }

    public fun new_records(arg0: &mut 0x2::tx_context::TxContext) : MintRecords {
        MintRecords{map: 0x2::table::new<u64, 0x2::table::Table<address, u64>>(arg0)}
    }

    public fun new_stage(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0x1::option::Option<vector<u8>>) : MintStage {
        assert!(arg3 > arg2, 102);
        assert!(arg1 <= 10000000000000, 104);
        if (arg5 && 0x1::option::is_some<vector<u8>>(&arg6)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg6)) == 32, 101);
        };
        MintStage{
            name             : arg0,
            price            : arg1,
            start_time_ms    : arg2,
            end_time_ms      : arg3,
            per_wallet_limit : arg4,
            is_allowlist     : arg5,
            merkle_root      : arg6,
        }
    }

    public fun stage_end_time(arg0: &MintStage) : u64 {
        arg0.end_time_ms
    }

    public fun stage_is_allowlist(arg0: &MintStage) : bool {
        arg0.is_allowlist
    }

    public fun stage_merkle_root(arg0: &MintStage) : 0x1::option::Option<vector<u8>> {
        arg0.merkle_root
    }

    public fun stage_name(arg0: &MintStage) : 0x1::string::String {
        arg0.name
    }

    public fun stage_price(arg0: &MintStage) : u64 {
        arg0.price
    }

    public fun stage_start_time(arg0: &MintStage) : u64 {
        arg0.start_time_ms
    }

    public fun stage_wallet_limit(arg0: &MintStage) : u64 {
        arg0.per_wallet_limit
    }

    public fun stages(arg0: &MintStageConfig) : &vector<MintStage> {
        &arg0.stages
    }

    fun validate_sequence(arg0: &vector<MintStage>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<MintStage>(arg0)) {
            let v1 = 0x1::vector::borrow<MintStage>(arg0, v0);
            assert!(v1.end_time_ms > v1.start_time_ms, 102);
            if (v0 > 0) {
                assert!(v1.start_time_ms >= 0x1::vector::borrow<MintStage>(arg0, v0 - 1).end_time_ms, 101);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

