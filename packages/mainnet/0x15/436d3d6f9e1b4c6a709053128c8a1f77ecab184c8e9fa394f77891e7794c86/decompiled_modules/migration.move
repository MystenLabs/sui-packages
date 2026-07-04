module 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::migration {
    struct MigrationJob has store, key {
        id: 0x2::object::UID,
        owner: address,
        source_type: 0x1::string::String,
        source_metadata: 0x1::string::String,
        status: u8,
        file_count: u64,
        total_size_bytes: u64,
        files_processed: u64,
        bytes_processed: u64,
        walrus_epochs_requested: u64,
        encrypted: bool,
        encryption_type: 0x1::string::String,
        seal_policy_id: 0x1::option::Option<0x2::object::ID>,
        blob_ids: vector<0x1::string::String>,
        cost_usdc_equivalent: u64,
        created_epoch: u64,
        completed_epoch: 0x1::option::Option<u64>,
    }

    struct JobCreated has copy, drop {
        job_id: 0x2::object::ID,
        owner: address,
        source_type: 0x1::string::String,
        file_count: u64,
        total_size_bytes: u64,
        walrus_epochs_requested: u64,
        encrypted: bool,
        encryption_type: 0x1::string::String,
        epoch: u64,
    }

    struct JobCompleted has copy, drop {
        job_id: 0x2::object::ID,
        owner: address,
        blob_count: u64,
        verified_bytes: u64,
        expected_bytes: u64,
        verified_files: u64,
        expected_files: u64,
        cost_usdc_equivalent: u64,
        epoch: u64,
    }

    struct JobReleased has copy, drop {
        job_id: 0x2::object::ID,
        owner: address,
        released_bytes: u64,
        released_blobs: u64,
        epoch: u64,
    }

    public fun complete_job(arg0: &0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::GlobalConfig, arg1: &mut 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::UserAccount, arg2: &mut MigrationJob, arg3: vector<0x1::string::String>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::assert_not_paused(arg0);
        0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::assert_version(arg0);
        assert!(arg2.owner == 0x2::tx_context::sender(arg7), 300);
        assert!(arg2.status == 1, 310);
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg3), 313);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) <= arg2.file_count, 314);
        assert!(arg4 <= arg2.total_size_bytes, 314);
        assert!(arg5 <= arg2.file_count, 314);
        arg2.status = 2;
        arg2.blob_ids = arg3;
        arg2.cost_usdc_equivalent = arg6;
        arg2.completed_epoch = 0x1::option::some<u64>(0x2::tx_context::epoch(arg7));
        arg2.files_processed = arg5;
        arg2.bytes_processed = arg4;
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2.blob_ids);
        0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::add_storage(arg1, arg4, v0, arg2.encrypted);
        0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::increment_jobs_completed(arg1);
        0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::decrement_active_jobs(arg1);
        let v1 = JobCompleted{
            job_id               : 0x2::object::id<MigrationJob>(arg2),
            owner                : arg2.owner,
            blob_count           : v0,
            verified_bytes       : arg4,
            expected_bytes       : arg2.total_size_bytes,
            verified_files       : arg5,
            expected_files       : arg2.file_count,
            cost_usdc_equivalent : arg6,
            epoch                : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<JobCompleted>(v1);
    }

    public fun create_job(arg0: &0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::GlobalConfig, arg1: &0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::PlanRegistry, arg2: &mut 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::UserAccount, arg3: &0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::Subscription, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: 0x1::string::String, arg11: 0x1::option::Option<0x2::object::ID>, arg12: &mut 0x2::tx_context::TxContext) : MigrationJob {
        0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::assert_not_paused(arg0);
        0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::is_active(arg3, 0x2::tx_context::epoch(arg12)), 302);
        let v1 = 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::sub_tier(arg3);
        let v2 = 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::get_plan(arg1, v1);
        assert!(0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::account_total_bytes(arg2) + arg7 <= 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::effective_storage_limit(arg2, arg1, v1), 303);
        let v3 = 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::plan_max_files(v2);
        if (v3 > 0) {
            assert!(arg6 <= v3, 304);
        };
        assert!(arg6 > 0, 307);
        assert!(arg7 > 0, 308);
        assert!(0x1::string::length(&arg4) > 0, 301);
        assert!(0x1::string::length(&arg5) <= 256, 311);
        if (arg9) {
            assert!(0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::plan_has_seal(v2), 305);
            assert!(0x1::option::is_some<0x2::object::ID>(&arg11), 309);
        };
        let v4 = 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::plan_max_walrus_epochs(v2);
        let v5 = 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::max_storage_epochs(arg0);
        let v6 = if (v4 > 0 && v4 < v5) {
            v4
        } else {
            v5
        };
        assert!(arg8 > 0 && arg8 <= v6, 306);
        let v7 = 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::plan_max_concurrent_jobs(v2);
        if (v7 > 0) {
            assert!(0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::account_active_jobs(arg2) < v7, 312);
        };
        0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::increment_active_jobs(arg2);
        let v8 = MigrationJob{
            id                      : 0x2::object::new(arg12),
            owner                   : v0,
            source_type             : arg4,
            source_metadata         : arg5,
            status                  : 1,
            file_count              : arg6,
            total_size_bytes        : arg7,
            files_processed         : 0,
            bytes_processed         : 0,
            walrus_epochs_requested : arg8,
            encrypted               : arg9,
            encryption_type         : arg10,
            seal_policy_id          : arg11,
            blob_ids                : 0x1::vector::empty<0x1::string::String>(),
            cost_usdc_equivalent    : 0,
            created_epoch           : 0x2::tx_context::epoch(arg12),
            completed_epoch         : 0x1::option::none<u64>(),
        };
        let v9 = JobCreated{
            job_id                  : 0x2::object::id<MigrationJob>(&v8),
            owner                   : v0,
            source_type             : v8.source_type,
            file_count              : arg6,
            total_size_bytes        : arg7,
            walrus_epochs_requested : arg8,
            encrypted               : arg9,
            encryption_type         : v8.encryption_type,
            epoch                   : 0x2::tx_context::epoch(arg12),
        };
        0x2::event::emit<JobCreated>(v9);
        v8
    }

    public fun is_terminal(arg0: &MigrationJob) : bool {
        arg0.status == 2
    }

    public fun job_blob_ids(arg0: &MigrationJob) : &vector<0x1::string::String> {
        &arg0.blob_ids
    }

    public fun job_owner(arg0: &MigrationJob) : address {
        arg0.owner
    }

    public fun job_status(arg0: &MigrationJob) : u8 {
        arg0.status
    }

    public fun release_job(arg0: &mut 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::UserAccount, arg1: MigrationJob, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 300);
        assert!(arg1.status == 1 || arg1.status == 2, 320);
        let MigrationJob {
            id                      : v0,
            owner                   : v1,
            source_type             : _,
            source_metadata         : _,
            status                  : v4,
            file_count              : _,
            total_size_bytes        : _,
            files_processed         : _,
            bytes_processed         : v8,
            walrus_epochs_requested : _,
            encrypted               : v10,
            encryption_type         : _,
            seal_policy_id          : _,
            blob_ids                : v13,
            cost_usdc_equivalent    : _,
            created_epoch           : _,
            completed_epoch         : _,
        } = arg1;
        let v17 = v13;
        let v18 = v0;
        let v19 = if (v4 == 2) {
            v8
        } else {
            0
        };
        let v20 = if (v4 == 2) {
            0x1::vector::length<0x1::string::String>(&v17)
        } else {
            0
        };
        if (v4 == 1) {
            0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::decrement_active_jobs(arg0);
        };
        if (v19 > 0 || v20 > 0) {
            0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::release_storage(arg0, v19, v20, v10);
        };
        0x2::object::delete(v18);
        let v21 = JobReleased{
            job_id         : 0x2::object::uid_to_inner(&v18),
            owner          : v1,
            released_bytes : v19,
            released_blobs : v20,
            epoch          : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<JobReleased>(v21);
    }

    // decompiled from Move bytecode v7
}

