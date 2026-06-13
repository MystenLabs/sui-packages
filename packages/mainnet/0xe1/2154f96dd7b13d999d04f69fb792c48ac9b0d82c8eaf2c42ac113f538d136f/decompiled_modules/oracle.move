module 0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::oracle {
    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MatchResult has key {
        id: 0x2::object::UID,
        match_id: vector<u8>,
        result_blob_id: vector<u8>,
        recorded_at_ms: u64,
    }

    struct ResultRecorded has copy, drop {
        match_result_id: 0x2::object::ID,
        match_id: vector<u8>,
        result_blob_id: vector<u8>,
        recorded_at_ms: u64,
    }

    struct OracleCapTransferred has copy, drop {
        to: address,
    }

    struct OracleCapMinted has copy, drop {
        to: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = OracleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OracleCap>(v1, v0);
        let v2 = OracleAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OracleAdminCap>(v2, v0);
    }

    public fun match_result_match_id(arg0: &MatchResult) : vector<u8> {
        arg0.match_id
    }

    public fun mint_oracle_cap(arg0: &OracleAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 3);
        let v0 = OracleCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<OracleCap>(v0, arg1);
        let v1 = OracleCapMinted{to: arg1};
        0x2::event::emit<OracleCapMinted>(v1);
    }

    public fun record_result(arg0: &OracleCap, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = MatchResult{
            id             : 0x2::object::new(arg4),
            match_id       : arg1,
            result_blob_id : arg2,
            recorded_at_ms : v0,
        };
        let v2 = ResultRecorded{
            match_result_id : 0x2::object::id<MatchResult>(&v1),
            match_id        : v1.match_id,
            result_blob_id  : v1.result_blob_id,
            recorded_at_ms  : v0,
        };
        0x2::event::emit<ResultRecorded>(v2);
        0x2::transfer::share_object<MatchResult>(v1);
    }

    public fun recorded_at_ms(arg0: &MatchResult) : u64 {
        arg0.recorded_at_ms
    }

    public fun resolve_prediction(arg0: &OracleCap, arg1: &mut 0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::profile::PunditProfile, arg2: &mut 0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::receipt::PredictionReceipt, arg3: &MatchResult, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.match_id == 0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::receipt::match_id(arg2), 1);
        assert!(arg3.recorded_at_ms >= 0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::receipt::committed_at_ms(arg2), 2);
        0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::receipt::resolve_internal(arg2, arg1, arg4, 0x2::object::id<MatchResult>(arg3));
    }

    public fun result_blob_id(arg0: &MatchResult) : vector<u8> {
        arg0.result_blob_id
    }

    public fun transfer_cap(arg0: OracleCap, arg1: address) {
        assert!(arg1 != @0x0, 3);
        0x2::transfer::public_transfer<OracleCap>(arg0, arg1);
        let v0 = OracleCapTransferred{to: arg1};
        0x2::event::emit<OracleCapTransferred>(v0);
    }

    // decompiled from Move bytecode v6
}

