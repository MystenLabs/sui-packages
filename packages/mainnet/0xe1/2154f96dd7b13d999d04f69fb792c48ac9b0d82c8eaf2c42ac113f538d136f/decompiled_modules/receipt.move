module 0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::receipt {
    struct PredictionReceipt has key {
        id: 0x2::object::UID,
        owner: address,
        profile_id: 0x2::object::ID,
        match_id: vector<u8>,
        blob_id: vector<u8>,
        confidence: u8,
        committed_at_ms: u64,
        status: u8,
        resolved_with: 0x1::option::Option<0x2::object::ID>,
    }

    struct PredictionCommitted has copy, drop {
        receipt_id: 0x2::object::ID,
        owner: address,
        match_id: vector<u8>,
        blob_id: vector<u8>,
        committed_at_ms: u64,
    }

    struct PredictionResolved has copy, drop {
        receipt_id: 0x2::object::ID,
        match_id: vector<u8>,
        verdict: u8,
        match_result_id: 0x2::object::ID,
        new_respect_score: u64,
        relationship_state: u8,
    }

    public fun owner(arg0: &PredictionReceipt) : address {
        arg0.owner
    }

    public fun blob_id(arg0: &PredictionReceipt) : vector<u8> {
        arg0.blob_id
    }

    public fun commit_prediction(arg0: &mut 0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::profile::PunditProfile, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::profile::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        assert!(arg3 <= 2, 5);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 6);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 7);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::profile::record_commit(arg0);
        let v1 = PredictionReceipt{
            id              : 0x2::object::new(arg5),
            owner           : 0x2::tx_context::sender(arg5),
            profile_id      : 0x2::object::id<0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::profile::PunditProfile>(arg0),
            match_id        : arg1,
            blob_id         : arg2,
            confidence      : arg3,
            committed_at_ms : v0,
            status          : 0,
            resolved_with   : 0x1::option::none<0x2::object::ID>(),
        };
        let v2 = PredictionCommitted{
            receipt_id      : 0x2::object::id<PredictionReceipt>(&v1),
            owner           : v1.owner,
            match_id        : v1.match_id,
            blob_id         : v1.blob_id,
            committed_at_ms : v0,
        };
        0x2::event::emit<PredictionCommitted>(v2);
        0x2::transfer::share_object<PredictionReceipt>(v1);
    }

    public fun committed_at_ms(arg0: &PredictionReceipt) : u64 {
        arg0.committed_at_ms
    }

    public fun confidence(arg0: &PredictionReceipt) : u8 {
        arg0.confidence
    }

    public fun match_id(arg0: &PredictionReceipt) : vector<u8> {
        arg0.match_id
    }

    public(friend) fun resolve_internal(arg0: &mut PredictionReceipt, arg1: &mut 0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::profile::PunditProfile, arg2: u8, arg3: 0x2::object::ID) {
        assert!(arg0.status == 0, 2);
        assert!(arg0.profile_id == 0x2::object::id<0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::profile::PunditProfile>(arg1), 3);
        assert!(arg2 == 1 || arg2 == 2, 4);
        arg0.status = arg2;
        arg0.resolved_with = 0x1::option::some<0x2::object::ID>(arg3);
        0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::profile::apply_verdict(arg1, arg2 == 1);
        let v0 = PredictionResolved{
            receipt_id         : 0x2::object::id<PredictionReceipt>(arg0),
            match_id           : arg0.match_id,
            verdict            : arg2,
            match_result_id    : arg3,
            new_respect_score  : 0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::profile::respect_score(arg1),
            relationship_state : 0xe12154f96dd7b13d999d04f69fb792c48ac9b0d82c8eaf2c42ac113f538d136f::profile::relationship_state(arg1),
        };
        0x2::event::emit<PredictionResolved>(v0);
    }

    public fun resolved_with(arg0: &PredictionReceipt) : 0x1::option::Option<0x2::object::ID> {
        arg0.resolved_with
    }

    public fun status(arg0: &PredictionReceipt) : u8 {
        arg0.status
    }

    public fun status_correct() : u8 {
        1
    }

    public fun status_pending() : u8 {
        0
    }

    public fun status_wrong() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

