module 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form {
    struct WAL has drop {
        dummy_field: bool,
    }

    struct Tiers has copy, drop, store {
        low: u64,
        medium: u64,
        high: u64,
        critical: u64,
    }

    struct ResponseRef has copy, drop, store {
        blob_id: vector<u8>,
        root_hash: vector<u8>,
        submitter: 0x1::option::Option<address>,
        timestamp_ms: u64,
        severity: u8,
        status: u8,
        notes_blob_id: 0x1::option::Option<vector<u8>>,
    }

    struct Form has store, key {
        id: 0x2::object::UID,
        owner: address,
        schema_blob_id: vector<u8>,
        schema_version: u64,
        response_count: u64,
        aggregate_rating_sum: u64,
        aggregate_rating_count: u64,
        responses: 0x2::table::Table<u64, ResponseRef>,
        admins: 0x2::vec_set::VecSet<address>,
        paused: bool,
        close_epoch: 0x1::option::Option<u64>,
        bounty_pool: 0x2::balance::Balance<WAL>,
        bounty_tiers: Tiers,
        created_at_ms: u64,
    }

    public fun id(arg0: &Form) : 0x2::object::ID {
        0x2::object::id<Form>(arg0)
    }

    public fun add_admin(arg0: &mut Form, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        if (!0x2::vec_set::contains<address>(&arg0.admins, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
        };
        0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::events::emit_admin_added(0x2::object::id<Form>(arg0), arg1);
    }

    public fun admin_count(arg0: &Form) : u64 {
        0x2::vec_set::length<address>(&arg0.admins)
    }

    public fun aggregate_rating(arg0: &Form, arg1: vector<u8>) : 0x1::option::Option<u64> {
        if (arg0.aggregate_rating_count == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg0.aggregate_rating_sum / arg0.aggregate_rating_count)
        }
    }

    public fun approve_response(arg0: &mut Form, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WAL> {
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::table::borrow_mut<u64, ResponseRef>(&mut arg0.responses, arg1);
        assert!(v0.status != 2, 8);
        assert!(0x1::option::is_some<address>(&v0.submitter), 7);
        let v1 = bounty_amount(&arg0.bounty_tiers, v0.severity);
        assert!(v1 > 0, 5);
        assert!(0x2::balance::value<WAL>(&arg0.bounty_pool) >= v1, 6);
        v0.status = 2;
        0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::events::emit_bounty_paid(0x2::object::id<Form>(arg0), arg1, *0x1::option::borrow<address>(&v0.submitter), v1);
        0x2::coin::from_balance<WAL>(0x2::balance::split<WAL>(&mut arg0.bounty_pool, v1), arg2)
    }

    fun assert_admin(arg0: &Form, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg1), 1);
    }

    fun assert_owner(arg0: &Form, arg1: address) {
        assert!(arg0.owner == arg1, 0);
    }

    fun assert_valid_severity(arg0: u8) {
        assert!(arg0 <= 4, 3);
    }

    fun assert_valid_status(arg0: u8) {
        assert!(arg0 <= 4, 4);
    }

    public fun bounty_amount(arg0: &Tiers, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.low
        } else if (arg1 == 2) {
            arg0.medium
        } else if (arg1 == 3) {
            arg0.high
        } else if (arg1 == 4) {
            arg0.critical
        } else {
            0
        }
    }

    public fun bounty_balance(arg0: &Form) : u64 {
        0x2::balance::value<WAL>(&arg0.bounty_pool)
    }

    public fun close_epoch(arg0: &Form) : 0x1::option::Option<u64> {
        arg0.close_epoch
    }

    public fun count_responses(arg0: &Form) : u64 {
        arg0.response_count
    }

    entry fun create_form(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::transfer<Form>(new_form(v0, arg0, arg1, 0x1::option::none<u64>(), default_tiers(), 0, arg2), v0);
    }

    public fun default_tiers() : Tiers {
        new_tiers(0, 0, 0, 0)
    }

    public fun deposit_bounty(arg0: &mut Form, arg1: 0x2::coin::Coin<WAL>) {
        0x2::balance::join<WAL>(&mut arg0.bounty_pool, 0x2::coin::into_balance<WAL>(arg1));
    }

    public fun is_admin(arg0: &Form, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_paused(arg0: &Form) : bool {
        arg0.paused
    }

    public fun new_form(arg0: address, arg1: vector<u8>, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: Tiers, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Form {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, arg0);
        let v1 = Form{
            id                     : 0x2::object::new(arg6),
            owner                  : arg0,
            schema_blob_id         : arg1,
            schema_version         : arg2,
            response_count         : 0,
            aggregate_rating_sum   : 0,
            aggregate_rating_count : 0,
            responses              : 0x2::table::new<u64, ResponseRef>(arg6),
            admins                 : v0,
            paused                 : false,
            close_epoch            : arg3,
            bounty_pool            : 0x2::balance::zero<WAL>(),
            bounty_tiers           : arg4,
            created_at_ms          : arg5,
        };
        0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::events::emit_form_created(0x2::object::id<Form>(&v1), arg0, arg2);
        v1
    }

    public fun new_tiers(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : Tiers {
        Tiers{
            low      : arg0,
            medium   : arg1,
            high     : arg2,
            critical : arg3,
        }
    }

    public fun owner(arg0: &Form) : address {
        arg0.owner
    }

    public fun pause(arg0: &mut Form, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.paused = true;
    }

    public fun response_ref(arg0: &Form, arg1: u64) : &ResponseRef {
        0x2::table::borrow<u64, ResponseRef>(&arg0.responses, arg1)
    }

    public fun response_status(arg0: &Form, arg1: u64) : u8 {
        0x2::table::borrow<u64, ResponseRef>(&arg0.responses, arg1).status
    }

    public fun response_submitter(arg0: &Form, arg1: u64) : 0x1::option::Option<address> {
        0x2::table::borrow<u64, ResponseRef>(&arg0.responses, arg1).submitter
    }

    public fun resume(arg0: &mut Form, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.paused = false;
    }

    public fun schema_blob_id(arg0: &Form) : &vector<u8> {
        &arg0.schema_blob_id
    }

    public fun schema_version(arg0: &Form) : u64 {
        arg0.schema_version
    }

    public fun set_notes_blob(arg0: &mut Form, arg1: u64, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg3));
        0x2::table::borrow_mut<u64, ResponseRef>(&mut arg0.responses, arg1).notes_blob_id = 0x1::option::some<vector<u8>>(arg2);
    }

    public fun set_status(arg0: &mut Form, arg1: u64, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg3));
        assert_valid_status(arg2);
        0x2::table::borrow_mut<u64, ResponseRef>(&mut arg0.responses, arg1).status = arg2;
    }

    public fun severity_critical() : u8 {
        4
    }

    public fun severity_high() : u8 {
        3
    }

    public fun severity_low() : u8 {
        1
    }

    public fun severity_medium() : u8 {
        2
    }

    public fun severity_none() : u8 {
        0
    }

    public fun status_approved() : u8 {
        2
    }

    public fun status_new() : u8 {
        0
    }

    public fun status_rejected() : u8 {
        4
    }

    public fun status_resolved() : u8 {
        3
    }

    public fun status_triaged() : u8 {
        1
    }

    public fun submit_response(arg0: &mut Form, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::option::Option<address>, arg4: u64, arg5: u8, arg6: 0x1::option::Option<u64>) : u64 {
        assert!(!arg0.paused, 2);
        assert_valid_severity(arg5);
        let v0 = arg0.response_count;
        if (0x1::option::is_some<u64>(&arg6)) {
            arg0.aggregate_rating_sum = arg0.aggregate_rating_sum + 0x1::option::extract<u64>(&mut arg6);
            arg0.aggregate_rating_count = arg0.aggregate_rating_count + 1;
        };
        let v1 = if (0x1::option::is_some<address>(&arg3)) {
            *0x1::option::borrow<address>(&arg3)
        } else {
            @0x0
        };
        let v2 = ResponseRef{
            blob_id       : arg1,
            root_hash     : arg2,
            submitter     : arg3,
            timestamp_ms  : arg4,
            severity      : arg5,
            status        : 0,
            notes_blob_id : 0x1::option::none<vector<u8>>(),
        };
        0x2::table::add<u64, ResponseRef>(&mut arg0.responses, v0, v2);
        arg0.response_count = arg0.response_count + 1;
        0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::events::emit_response_submitted(0x2::object::id<Form>(arg0), v0, v1, arg5);
        v0
    }

    public fun transfer_ownership(arg0: &mut Form, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.owner = arg1;
        if (!0x2::vec_set::contains<address>(&arg0.admins, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
        };
    }

    public fun verify_response(arg0: &Form, arg1: vector<u8>) : bool {
        let v0 = 0;
        while (v0 < arg0.response_count) {
            if (0x2::table::contains<u64, ResponseRef>(&arg0.responses, v0) && 0x2::table::borrow<u64, ResponseRef>(&arg0.responses, v0).blob_id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v7
}

