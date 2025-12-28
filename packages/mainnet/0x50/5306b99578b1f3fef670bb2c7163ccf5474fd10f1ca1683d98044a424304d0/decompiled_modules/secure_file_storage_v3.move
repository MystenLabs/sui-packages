module 0x505306b99578b1f3fef670bb2c7163ccf5474fd10f1ca1683d98044a424304d0::secure_file_storage_v3 {
    struct AdminConfig has store {
        admins: 0x2::vec_set::VecSet<address>,
        required_signatures: u64,
        action_proposals: 0x2::table::Table<u64, AdminProposal>,
        next_proposal_id: u64,
        last_emergency_action: u64,
        emergency_cooldown_ms: u64,
    }

    struct AdminProposal has drop, store {
        proposer: address,
        action_type: u8,
        target_address: 0x1::option::Option<address>,
        value: 0x1::option::Option<u64>,
        approvals: 0x2::vec_set::VecSet<address>,
        created_at: u64,
        expires_at: u64,
    }

    struct GasSponsor has store {
        balance: u64,
        total_consumed: u64,
        per_user_limit: u64,
        per_upload_cost: u64,
        low_balance_threshold: u64,
        enabled: bool,
    }

    struct FileMetadata has copy, drop, store {
        file_id: 0x1::string::String,
        file_name: 0x1::string::String,
        file_size: u64,
        mime_type: 0x1::string::String,
        storage_type: u8,
        encryption_method: u8,
        owner: address,
        upload_time: u64,
        last_modified: u64,
        last_accessed: u64,
        access_count: u64,
        version: u64,
        is_deleted: bool,
        tags: vector<0x1::string::String>,
        description: 0x1::string::String,
        category: 0x1::string::String,
    }

    struct InternalFileData has store {
        access_key_hash: vector<u8>,
        access_key_salt: vector<u8>,
        blob_id: 0x1::string::String,
        storage_url: 0x1::string::String,
        content_hash: vector<u8>,
        encryption_iv: 0x1::option::Option<vector<u8>>,
        shares: 0x2::table::Table<address, ShareInfo>,
        public_access: 0x1::option::Option<PublicAccessInfo>,
    }

    struct ShareInfo has drop, store {
        granted_at: u64,
        expires_at: 0x1::option::Option<u64>,
        permissions: u8,
        access_count: u64,
        last_accessed: 0x1::option::Option<u64>,
    }

    struct PublicAccessInfo has drop, store {
        enabled_at: u64,
        expires_at: 0x1::option::Option<u64>,
        access_count: u64,
        max_accesses: 0x1::option::Option<u64>,
    }

    struct UserProfile has store {
        user_address: address,
        email_hash: 0x1::option::Option<vector<u8>>,
        email_salt: 0x1::option::Option<vector<u8>>,
        storage_used: u64,
        storage_limit: u64,
        files_count: u64,
        deleted_files_count: u64,
        joined_at: u64,
        last_active: u64,
        subscription_tier: u8,
        is_active: bool,
        is_suspended: bool,
        suspension_reason: 0x1::option::Option<0x1::string::String>,
        weekly_uploads: u64,
        week_start_time: u64,
        last_upload_time: u64,
        gas_consumed: u64,
        last_gas_reset: u64,
    }

    struct RateLimitConfig has store {
        weekly_uploads: 0x2::table::Table<u8, u64>,
        min_upload_interval_ms: u64,
    }

    struct PrivexaStorage has key {
        id: 0x2::object::UID,
        admin_config: AdminConfig,
        files_metadata: 0x2::table::Table<0x1::string::String, FileMetadata>,
        files_internal: 0x2::table::Table<0x1::string::String, InternalFileData>,
        user_files: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x1::string::String>>,
        user_profiles: 0x2::table::Table<address, UserProfile>,
        deleted_files: 0x2::table::Table<0x1::string::String, DeletedFileRecord>,
        total_files: u64,
        total_deleted_files: u64,
        total_users: u64,
        total_storage_used: u64,
        rate_limits: RateLimitConfig,
        gas_sponsor: GasSponsor,
        max_file_size: u64,
        storage_limits: 0x2::table::Table<u8, u64>,
        emergency_pause: bool,
        pause_reason: 0x1::option::Option<0x1::string::String>,
        paused_at: 0x1::option::Option<u64>,
        paused_by: 0x1::option::Option<address>,
        upgrade_cap_transferred: bool,
        upgrade_cap_holder: 0x1::option::Option<address>,
    }

    struct DeletedFileRecord has drop, store {
        file_id: 0x1::string::String,
        owner: address,
        deleted_by: address,
        deleted_at: u64,
        file_size: u64,
        reason: 0x1::option::Option<0x1::string::String>,
    }

    struct FileUploadedEvent has copy, drop {
        file_id: 0x1::string::String,
        owner: address,
        file_size: u64,
        storage_type: u8,
        encryption_method: u8,
        timestamp: u64,
        version: u64,
        daily_count: u64,
        weekly_count: u64,
        gas_consumed: u64,
    }

    struct FileSharedEvent has copy, drop {
        file_id: 0x1::string::String,
        owner: address,
        shared_with: address,
        permissions: u8,
        expires_at: 0x1::option::Option<u64>,
        timestamp: u64,
    }

    struct FileDeletedEvent has copy, drop {
        file_id: 0x1::string::String,
        owner: address,
        deleted_by: address,
        timestamp: u64,
        reason: 0x1::option::Option<0x1::string::String>,
    }

    struct ShareRevokedEvent has copy, drop {
        file_id: 0x1::string::String,
        owner: address,
        revoked_from: address,
        timestamp: u64,
        reason: 0x1::option::Option<0x1::string::String>,
    }

    struct AdminActionEvent has copy, drop {
        admin: address,
        action_type: u8,
        target: 0x1::option::Option<address>,
        value: 0x1::option::Option<u64>,
        timestamp: u64,
        proposal_id: 0x1::option::Option<u64>,
    }

    struct SecurityAlertEvent has copy, drop {
        alert_type: 0x1::string::String,
        severity: u8,
        details: 0x1::string::String,
        timestamp: u64,
        affected_user: 0x1::option::Option<address>,
    }

    struct GasSponsorAlert has copy, drop {
        current_balance: u64,
        threshold: u64,
        timestamp: u64,
    }

    public entry fun approve_admin_action(arg0: &mut PrivexaStorage, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_config.admins, &v0), 1012);
        assert!(0x2::table::contains<u64, AdminProposal>(&arg0.admin_config.action_proposals, arg1), 1000);
        let v1 = 0x2::table::borrow_mut<u64, AdminProposal>(&mut arg0.admin_config.action_proposals, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) < v1.expires_at, 1000);
        if (!0x2::vec_set::contains<address>(&v1.approvals, &v0)) {
            0x2::vec_set::insert<address>(&mut v1.approvals, v0);
        };
        if (0x2::vec_set::size<address>(&v1.approvals) >= arg0.admin_config.required_signatures) {
            execute_admin_action(arg0, arg1, arg2);
        };
    }

    fun check_rate_limits_immutable(arg0: &UserProfile, arg1: u64, arg2: &RateLimitConfig, arg3: u8) {
        let v0 = if (arg1 >= safe_add(arg0.week_start_time, 604800000)) {
            0
        } else {
            arg0.weekly_uploads
        };
        assert!(v0 < *0x2::table::borrow<u8, u64>(&arg2.weekly_uploads, arg3), 1011);
        if (arg0.last_upload_time > 0) {
            assert!(arg1 >= safe_add(arg0.last_upload_time, arg2.min_upload_interval_ms), 1010);
        };
    }

    public entry fun delete_file(arg0: &mut PrivexaStorage, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_pause, 1009);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::table::contains<0x1::string::String, FileMetadata>(&arg0.files_metadata, arg1), 1001);
        let v2 = 0x2::table::borrow_mut<0x1::string::String, FileMetadata>(&mut arg0.files_metadata, arg1);
        assert!(!v2.is_deleted, 1001);
        assert!(v2.owner == v0 || 0x2::vec_set::contains<address>(&arg0.admin_config.admins, &v0), 1000);
        let v3 = v2.file_size;
        let v4 = v2.owner;
        v2.is_deleted = true;
        v2.last_modified = v1;
        let v5 = DeletedFileRecord{
            file_id    : arg1,
            owner      : v4,
            deleted_by : v0,
            deleted_at : v1,
            file_size  : v3,
            reason     : arg2,
        };
        0x2::table::add<0x1::string::String, DeletedFileRecord>(&mut arg0.deleted_files, arg1, v5);
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x1::string::String>>(&arg0.user_files, v4)) {
            0x2::vec_set::remove<0x1::string::String>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x1::string::String>>(&mut arg0.user_files, v4), &arg1);
        };
        if (0x2::table::contains<address, UserProfile>(&arg0.user_profiles, v4)) {
            let v6 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v4);
            v6.storage_used = safe_subtract(v6.storage_used, v3);
            v6.files_count = safe_subtract(v6.files_count, 1);
            v6.deleted_files_count = safe_add(v6.deleted_files_count, 1);
        };
        arg0.total_files = safe_subtract(arg0.total_files, 1);
        arg0.total_deleted_files = safe_add(arg0.total_deleted_files, 1);
        arg0.total_storage_used = safe_subtract(arg0.total_storage_used, v3);
        let v7 = FileDeletedEvent{
            file_id    : arg1,
            owner      : v4,
            deleted_by : v0,
            timestamp  : v1,
            reason     : arg2,
        };
        0x2::event::emit<FileDeletedEvent>(v7);
    }

    public entry fun emergency_pause_override(arg0: &mut PrivexaStorage, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_config.admins, &v0), 1012);
        let v1 = SecurityAlertEvent{
            alert_type    : 0x1::string::utf8(b"emergency_override"),
            severity      : 2,
            details       : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
            affected_user : 0x1::option::some<address>(v0),
        };
        0x2::event::emit<SecurityAlertEvent>(v1);
    }

    fun ensure_user_profile(arg0: &mut PrivexaStorage, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1)) {
            let v0 = UserProfile{
                user_address        : arg1,
                email_hash          : 0x1::option::none<vector<u8>>(),
                email_salt          : 0x1::option::none<vector<u8>>(),
                storage_used        : 0,
                storage_limit       : *0x2::table::borrow<u8, u64>(&arg0.storage_limits, 0),
                files_count         : 0,
                deleted_files_count : 0,
                joined_at           : arg2,
                last_active         : arg2,
                subscription_tier   : 0,
                is_active           : true,
                is_suspended        : false,
                suspension_reason   : 0x1::option::none<0x1::string::String>(),
                weekly_uploads      : 0,
                week_start_time     : arg2,
                last_upload_time    : 0,
                gas_consumed        : 0,
                last_gas_reset      : arg2,
            };
            0x2::table::add<address, UserProfile>(&mut arg0.user_profiles, arg1, v0);
            arg0.total_users = safe_add(arg0.total_users, 1);
        };
    }

    fun execute_admin_action(arg0: &mut PrivexaStorage, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::table::remove<u64, AdminProposal>(&mut arg0.admin_config.action_proposals, arg1);
        if (v1.action_type == 0) {
            assert!(v0 >= safe_add(arg0.admin_config.last_emergency_action, arg0.admin_config.emergency_cooldown_ms), 1022);
            arg0.emergency_pause = true;
            arg0.pause_reason = 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"Emergency pause activated"));
            arg0.paused_at = 0x1::option::some<u64>(v0);
            arg0.paused_by = 0x1::option::some<address>(v1.proposer);
            arg0.admin_config.last_emergency_action = v0;
        } else if (v1.action_type == 1) {
            arg0.emergency_pause = false;
            arg0.pause_reason = 0x1::option::none<0x1::string::String>();
            arg0.paused_at = 0x1::option::none<u64>();
            arg0.paused_by = 0x1::option::none<address>();
        } else if (v1.action_type == 3) {
            assert!(0x1::option::is_some<address>(&v1.target_address), 1013);
            let v2 = *0x1::option::borrow<address>(&v1.target_address);
            assert!(!0x2::vec_set::contains<address>(&arg0.admin_config.admins, &v2), 1024);
            0x2::vec_set::insert<address>(&mut arg0.admin_config.admins, v2);
            arg0.admin_config.required_signatures = 0x2::vec_set::size<address>(&arg0.admin_config.admins) / 2 + 1;
        } else if (v1.action_type == 4) {
            assert!(0x1::option::is_some<address>(&v1.target_address), 1013);
            let v3 = *0x1::option::borrow<address>(&v1.target_address);
            assert!(0x2::vec_set::size<address>(&arg0.admin_config.admins) > 1, 1023);
            assert!(v3 != v1.proposer || 0x2::vec_set::size<address>(&arg0.admin_config.admins) > 1, 1025);
            0x2::vec_set::remove<address>(&mut arg0.admin_config.admins, &v3);
            let v4 = 0x2::vec_set::size<address>(&arg0.admin_config.admins);
            arg0.admin_config.required_signatures = 0x1::u64::min(v4 / 2 + 1, v4);
        } else if (v1.action_type == 5) {
            assert!(0x1::option::is_some<u64>(&v1.value), 1013);
            let v5 = *0x1::option::borrow<u64>(&v1.value);
            arg0.gas_sponsor.balance = v5;
            arg0.gas_sponsor.enabled = v5 > 0;
        };
        let v6 = AdminActionEvent{
            admin       : v1.proposer,
            action_type : v1.action_type,
            target      : v1.target_address,
            value       : v1.value,
            timestamp   : v0,
            proposal_id : 0x1::option::some<u64>(arg1),
        };
        0x2::event::emit<AdminActionEvent>(v6);
    }

    public fun get_admin_info(arg0: &PrivexaStorage) : (u64, u64) {
        (0x2::vec_set::size<address>(&arg0.admin_config.admins), arg0.admin_config.required_signatures)
    }

    public fun get_file_access_data(arg0: &mut PrivexaStorage, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x1::string::String, 0x1::string::String, vector<u8>) {
        assert!(!arg0.emergency_pause, 1009);
        assert!(0x2::table::contains<0x1::string::String, FileMetadata>(&arg0.files_metadata, arg1), 1001);
        assert!(0x2::table::contains<0x1::string::String, InternalFileData>(&arg0.files_internal, arg1), 1001);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(!0x2::table::borrow<0x1::string::String, FileMetadata>(&arg0.files_metadata, arg1).is_deleted, 1001);
        assert!(has_file_access(arg0, &arg1, v0, v1), 1000);
        let v2 = 0x2::table::borrow_mut<0x1::string::String, FileMetadata>(&mut arg0.files_metadata, arg1);
        v2.last_accessed = v1;
        v2.access_count = safe_add(v2.access_count, 1);
        if (v0 != v2.owner) {
            let v3 = 0x2::table::borrow_mut<0x1::string::String, InternalFileData>(&mut arg0.files_internal, arg1);
            if (0x2::table::contains<address, ShareInfo>(&v3.shares, v0)) {
                let v4 = 0x2::table::borrow_mut<address, ShareInfo>(&mut v3.shares, v0);
                v4.access_count = safe_add(v4.access_count, 1);
                v4.last_accessed = 0x1::option::some<u64>(v1);
            };
        };
        let v5 = 0x2::table::borrow<0x1::string::String, InternalFileData>(&arg0.files_internal, arg1);
        (v5.blob_id, v5.storage_url, v5.access_key_hash)
    }

    public fun get_file_metadata(arg0: &PrivexaStorage, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : FileMetadata {
        assert!(!arg0.emergency_pause, 1009);
        assert!(0x2::table::contains<0x1::string::String, FileMetadata>(&arg0.files_metadata, arg1), 1001);
        let v0 = 0x2::table::borrow<0x1::string::String, FileMetadata>(&arg0.files_metadata, arg1);
        assert!(!v0.is_deleted, 1001);
        assert!(has_file_access(arg0, &arg1, 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2)), 1000);
        *v0
    }

    public fun get_shared_with_me(arg0: &PrivexaStorage, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : vector<FileMetadata> {
        assert!(0x2::tx_context::sender(arg3) == arg1, 1000);
        0x1::vector::empty<FileMetadata>()
    }

    public fun get_storage_stats(arg0: &PrivexaStorage) : (u64, u64, u64, u64, bool) {
        (arg0.total_files, arg0.total_deleted_files, arg0.total_users, arg0.total_storage_used, arg0.emergency_pause)
    }

    public fun get_user_files(arg0: &PrivexaStorage, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : vector<FileMetadata> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1 || 0x2::vec_set::contains<address>(&arg0.admin_config.admins, &v0), 1000);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x1::string::String>>(&arg0.user_files, arg1)) {
            return 0x1::vector::empty<FileMetadata>()
        };
        let v1 = 0x1::vector::empty<FileMetadata>();
        let v2 = 0x2::vec_set::into_keys<0x1::string::String>(*0x2::table::borrow<address, 0x2::vec_set::VecSet<0x1::string::String>>(&arg0.user_files, arg1));
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v2)) {
            let v4 = 0x1::vector::borrow<0x1::string::String>(&v2, v3);
            if (0x2::table::contains<0x1::string::String, FileMetadata>(&arg0.files_metadata, *v4)) {
                let v5 = 0x2::table::borrow<0x1::string::String, FileMetadata>(&arg0.files_metadata, *v4);
                if (!v5.is_deleted) {
                    0x1::vector::push_back<FileMetadata>(&mut v1, *v5);
                };
            };
            v3 = v3 + 1;
        };
        v1
    }

    public fun get_user_profile(arg0: &PrivexaStorage, arg1: address, arg2: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, u8, bool) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1 || 0x2::vec_set::contains<address>(&arg0.admin_config.admins, &v0), 1000);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1), 1000);
        let v1 = 0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg1);
        (v1.storage_used, v1.storage_limit, v1.files_count, v1.weekly_uploads, v1.subscription_tier, v1.is_suspended)
    }

    fun has_file_access(arg0: &PrivexaStorage, arg1: &0x1::string::String, arg2: address, arg3: u64) : bool {
        if (0x2::table::borrow<0x1::string::String, FileMetadata>(&arg0.files_metadata, *arg1).owner == arg2) {
            return true
        };
        if (0x2::vec_set::contains<address>(&arg0.admin_config.admins, &arg2)) {
            return true
        };
        let v0 = 0x2::table::borrow<0x1::string::String, InternalFileData>(&arg0.files_internal, *arg1);
        if (0x2::table::contains<address, ShareInfo>(&v0.shares, arg2)) {
            let v1 = 0x2::table::borrow<address, ShareInfo>(&v0.shares, arg2);
            if (0x1::option::is_some<u64>(&v1.expires_at)) {
                if (arg3 >= *0x1::option::borrow<u64>(&v1.expires_at)) {
                    return false
                };
            };
            return true
        };
        if (0x1::option::is_some<PublicAccessInfo>(&v0.public_access)) {
            let v2 = 0x1::option::borrow<PublicAccessInfo>(&v0.public_access);
            if (0x1::option::is_some<u64>(&v2.expires_at)) {
                if (arg3 >= *0x1::option::borrow<u64>(&v2.expires_at)) {
                    return false
                };
            };
            if (0x1::option::is_some<u64>(&v2.max_accesses)) {
                if (v2.access_count >= *0x1::option::borrow<u64>(&v2.max_accesses)) {
                    return false
                };
            };
            return true
        };
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminConfig{
            admins                : v0,
            required_signatures   : 1,
            action_proposals      : 0x2::table::new<u64, AdminProposal>(arg0),
            next_proposal_id      : 0,
            last_emergency_action : 0,
            emergency_cooldown_ms : 3600000,
        };
        let v2 = 0x2::table::new<u8, u64>(arg0);
        0x2::table::add<u8, u64>(&mut v2, 0, 100);
        0x2::table::add<u8, u64>(&mut v2, 1, 100);
        0x2::table::add<u8, u64>(&mut v2, 2, 100);
        let v3 = RateLimitConfig{
            weekly_uploads         : v2,
            min_upload_interval_ms : 60000,
        };
        let v4 = 0x2::table::new<u8, u64>(arg0);
        0x2::table::add<u8, u64>(&mut v4, 0, 1073741824);
        0x2::table::add<u8, u64>(&mut v4, 1, 107374182400);
        0x2::table::add<u8, u64>(&mut v4, 2, 1099511627776);
        let v5 = GasSponsor{
            balance               : 0,
            total_consumed        : 0,
            per_user_limit        : 1000000,
            per_upload_cost       : 100000,
            low_balance_threshold : 100000000,
            enabled               : false,
        };
        let v6 = PrivexaStorage{
            id                      : 0x2::object::new(arg0),
            admin_config            : v1,
            files_metadata          : 0x2::table::new<0x1::string::String, FileMetadata>(arg0),
            files_internal          : 0x2::table::new<0x1::string::String, InternalFileData>(arg0),
            user_files              : 0x2::table::new<address, 0x2::vec_set::VecSet<0x1::string::String>>(arg0),
            user_profiles           : 0x2::table::new<address, UserProfile>(arg0),
            deleted_files           : 0x2::table::new<0x1::string::String, DeletedFileRecord>(arg0),
            total_files             : 0,
            total_deleted_files     : 0,
            total_users             : 0,
            total_storage_used      : 0,
            rate_limits             : v3,
            gas_sponsor             : v5,
            max_file_size           : 52428800,
            storage_limits          : v4,
            emergency_pause         : false,
            pause_reason            : 0x1::option::none<0x1::string::String>(),
            paused_at               : 0x1::option::none<u64>(),
            paused_by               : 0x1::option::none<address>(),
            upgrade_cap_transferred : false,
            upgrade_cap_holder      : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<PrivexaStorage>(v6);
    }

    public entry fun lock_upgrade_capability(arg0: &mut PrivexaStorage, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_config.admins, &v0), 1012);
        assert!(!arg0.upgrade_cap_transferred, 1027);
        arg0.upgrade_cap_transferred = true;
        arg0.upgrade_cap_holder = 0x1::option::some<address>(arg1);
    }

    public entry fun propose_admin_action(arg0: &mut PrivexaStorage, arg1: u8, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_config.admins, &v0), 1012);
        let v2 = AdminProposal{
            proposer       : v0,
            action_type    : arg1,
            target_address : arg2,
            value          : arg3,
            approvals      : 0x2::vec_set::singleton<address>(v0),
            created_at     : v1,
            expires_at     : safe_add(v1, 86400000),
        };
        let v3 = arg0.admin_config.next_proposal_id;
        0x2::table::add<u64, AdminProposal>(&mut arg0.admin_config.action_proposals, v3, v2);
        arg0.admin_config.next_proposal_id = safe_add(v3, 1);
        if (0x2::vec_set::size<address>(&arg0.admin_config.admins) == 1) {
            execute_admin_action(arg0, v3, arg4);
        };
    }

    public entry fun revoke_share(arg0: &mut PrivexaStorage, arg1: 0x1::string::String, arg2: address, arg3: 0x1::option::Option<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_pause, 1009);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<0x1::string::String, FileMetadata>(&arg0.files_metadata, arg1), 1001);
        let v1 = 0x2::table::borrow<0x1::string::String, FileMetadata>(&arg0.files_metadata, arg1);
        assert!(!v1.is_deleted, 1001);
        assert!(v1.owner == v0, 1000);
        let v2 = 0x2::table::borrow_mut<0x1::string::String, InternalFileData>(&mut arg0.files_internal, arg1);
        assert!(0x2::table::contains<address, ShareInfo>(&v2.shares, arg2), 1018);
        0x2::table::remove<address, ShareInfo>(&mut v2.shares, arg2);
        let v3 = ShareRevokedEvent{
            file_id      : arg1,
            owner        : v0,
            revoked_from : arg2,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
            reason       : arg3,
        };
        0x2::event::emit<ShareRevokedEvent>(v3);
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0 && v0 >= arg1, 1019);
        v0
    }

    fun safe_multiply(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = arg0 * arg1;
        assert!(v0 / arg0 == arg1, 1019);
        v0
    }

    fun safe_subtract(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 1019);
        arg0 - arg1
    }

    public entry fun share_file(arg0: &mut PrivexaStorage, arg1: 0x1::string::String, arg2: address, arg3: u8, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_pause, 1009);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x2::table::contains<0x1::string::String, FileMetadata>(&arg0.files_metadata, arg1), 1001);
        let v2 = 0x2::table::borrow<0x1::string::String, FileMetadata>(&arg0.files_metadata, arg1);
        assert!(!v2.is_deleted, 1001);
        assert!(v2.owner == v0, 1000);
        assert!(arg2 != v0, 1005);
        let v3 = if (0x1::option::is_some<u64>(&arg4)) {
            let v4 = *0x1::option::borrow<u64>(&arg4);
            assert!(v4 > 0 && v4 <= 8760, 1026);
            0x1::option::some<u64>(safe_add(v1, safe_multiply(v4, 3600000)))
        } else {
            0x1::option::none<u64>()
        };
        let v5 = 0x2::table::borrow_mut<0x1::string::String, InternalFileData>(&mut arg0.files_internal, arg1);
        assert!(!0x2::table::contains<address, ShareInfo>(&v5.shares, arg2), 1017);
        let v6 = ShareInfo{
            granted_at    : v1,
            expires_at    : v3,
            permissions   : arg3,
            access_count  : 0,
            last_accessed : 0x1::option::none<u64>(),
        };
        0x2::table::add<address, ShareInfo>(&mut v5.shares, arg2, v6);
        let v7 = FileSharedEvent{
            file_id     : arg1,
            owner       : v0,
            shared_with : arg2,
            permissions : arg3,
            expires_at  : v3,
            timestamp   : v1,
        };
        0x2::event::emit<FileSharedEvent>(v7);
    }

    public entry fun suspend_user(arg0: &mut PrivexaStorage, arg1: address, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_config.admins, &v0), 1012);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1), 1000);
        let v1 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, arg1);
        v1.is_suspended = true;
        v1.suspension_reason = 0x1::option::some<0x1::string::String>(arg2);
        let v2 = SecurityAlertEvent{
            alert_type    : 0x1::string::utf8(b"user_suspended"),
            severity      : 1,
            details       : 0x1::string::utf8(b"User account suspended by admin"),
            timestamp     : 0x2::clock::timestamp_ms(arg3),
            affected_user : 0x1::option::some<address>(arg1),
        };
        0x2::event::emit<SecurityAlertEvent>(v2);
    }

    public entry fun update_user_tier(arg0: &mut PrivexaStorage, arg1: address, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_config.admins, &v0), 1012);
        assert!(arg2 <= 2, 1013);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1), 1000);
        let v1 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, arg1);
        v1.subscription_tier = arg2;
        v1.storage_limit = *0x2::table::borrow<u8, u64>(&arg0.storage_limits, arg2);
        v1.gas_consumed = 0;
        v1.last_gas_reset = 0x2::clock::timestamp_ms(arg3);
    }

    fun update_user_upload_stats(arg0: &mut UserProfile, arg1: u64, arg2: u64) : u64 {
        if (arg2 >= safe_add(arg0.week_start_time, 604800000)) {
            arg0.weekly_uploads = 0;
            arg0.week_start_time = arg2;
        };
        arg0.storage_used = safe_add(arg0.storage_used, arg1);
        arg0.files_count = safe_add(arg0.files_count, 1);
        arg0.weekly_uploads = safe_add(arg0.weekly_uploads, 1);
        arg0.last_upload_time = arg2;
        arg0.last_active = arg2;
        arg0.weekly_uploads
    }

    public entry fun upload_file(arg0: &mut PrivexaStorage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: u8, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: u8, arg12: 0x1::option::Option<vector<u8>>, arg13: vector<0x1::string::String>, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: bool, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg18);
        let v1 = 0x2::clock::timestamp_ms(arg17);
        assert!(!arg0.emergency_pause, 1009);
        validate_upload_inputs(&arg1, &arg2, arg3, &arg4, arg5, &arg6, &arg7, &arg8, &arg10, arg11, &arg13, &arg14, &arg15);
        assert!(!0x2::table::contains<0x1::string::String, FileMetadata>(&arg0.files_metadata, arg1), 1006);
        ensure_user_profile(arg0, v0, v1, arg18);
        let v2 = 0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, v0);
        assert!(!v2.is_suspended, 1000);
        let v3 = v2.subscription_tier;
        check_rate_limits_immutable(v2, v1, &arg0.rate_limits, v3);
        assert!(safe_add(v2.storage_used, arg3) <= *0x2::table::borrow<u8, u64>(&arg0.storage_limits, v3), 1002);
        if (arg16) {
            assert!(arg0.gas_sponsor.enabled, 1008);
            assert!(arg0.gas_sponsor.balance >= arg0.gas_sponsor.per_upload_cost, 1016);
            assert!(0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, v0).gas_consumed + arg0.gas_sponsor.per_upload_cost <= arg0.gas_sponsor.per_user_limit, 1007);
            arg0.gas_sponsor.balance = arg0.gas_sponsor.balance - arg0.gas_sponsor.per_upload_cost;
            arg0.gas_sponsor.total_consumed = safe_add(arg0.gas_sponsor.total_consumed, arg0.gas_sponsor.per_upload_cost);
            let v4 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v0);
            v4.gas_consumed = safe_add(v4.gas_consumed, arg0.gas_sponsor.per_upload_cost);
            if (arg0.gas_sponsor.balance < arg0.gas_sponsor.low_balance_threshold) {
                let v5 = GasSponsorAlert{
                    current_balance : arg0.gas_sponsor.balance,
                    threshold       : arg0.gas_sponsor.low_balance_threshold,
                    timestamp       : v1,
                };
                0x2::event::emit<GasSponsorAlert>(v5);
            };
        };
        let v6 = FileMetadata{
            file_id           : arg1,
            file_name         : arg2,
            file_size         : arg3,
            mime_type         : arg4,
            storage_type      : arg5,
            encryption_method : arg11,
            owner             : v0,
            upload_time       : v1,
            last_modified     : v1,
            last_accessed     : v1,
            access_count      : 0,
            version           : 1,
            is_deleted        : false,
            tags              : arg13,
            description       : arg14,
            category          : arg15,
        };
        let v7 = InternalFileData{
            access_key_hash : arg8,
            access_key_salt : arg9,
            blob_id         : arg6,
            storage_url     : arg7,
            content_hash    : arg10,
            encryption_iv   : arg12,
            shares          : 0x2::table::new<address, ShareInfo>(arg18),
            public_access   : 0x1::option::none<PublicAccessInfo>(),
        };
        0x2::table::add<0x1::string::String, FileMetadata>(&mut arg0.files_metadata, arg1, v6);
        0x2::table::add<0x1::string::String, InternalFileData>(&mut arg0.files_internal, arg1, v7);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x1::string::String>>(&arg0.user_files, v0)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x1::string::String>>(&mut arg0.user_files, v0, 0x2::vec_set::empty<0x1::string::String>());
        };
        0x2::vec_set::insert<0x1::string::String>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x1::string::String>>(&mut arg0.user_files, v0), arg1);
        let v8 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v0);
        arg0.total_files = safe_add(arg0.total_files, 1);
        arg0.total_storage_used = safe_add(arg0.total_storage_used, arg3);
        let v9 = if (arg16) {
            arg0.gas_sponsor.per_upload_cost
        } else {
            0
        };
        let v10 = FileUploadedEvent{
            file_id           : arg1,
            owner             : v0,
            file_size         : arg3,
            storage_type      : arg5,
            encryption_method : arg11,
            timestamp         : v1,
            version           : 1,
            daily_count       : 0,
            weekly_count      : update_user_upload_stats(v8, arg3, v1),
            gas_consumed      : v9,
        };
        0x2::event::emit<FileUploadedEvent>(v10);
    }

    fun validate_upload_inputs(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: u64, arg3: &0x1::string::String, arg4: u8, arg5: &0x1::string::String, arg6: &0x1::string::String, arg7: &vector<u8>, arg8: &vector<u8>, arg9: u8, arg10: &vector<0x1::string::String>, arg11: &0x1::string::String, arg12: &0x1::string::String) {
        assert!(arg2 > 0 && arg2 <= 52428800, 1003);
        assert!(0x1::string::length(arg0) > 0 && 0x1::string::length(arg0) <= 128, 1014);
        assert!(0x1::string::length(arg1) > 0 && 0x1::string::length(arg1) <= 255, 1014);
        assert!(0x1::string::length(arg3) > 0 && 0x1::string::length(arg3) <= 100, 1014);
        assert!(0x1::string::length(arg5) > 0, 1013);
        assert!(0x1::string::length(arg6) > 0 && 0x1::string::length(arg6) <= 2048, 1014);
        assert!(0x1::string::length(arg11) <= 500, 1014);
        assert!(0x1::string::length(arg12) <= 50, 1014);
        assert!(arg4 <= 2, 1020);
        assert!(arg9 <= 2, 1021);
        assert!(0x1::vector::length<u8>(arg7) == 32, 1013);
        assert!(0x1::vector::length<u8>(arg8) == 32, 1013);
        assert!(0x1::vector::length<0x1::string::String>(arg10) <= 10, 1015);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg10)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(arg10, v0);
            assert!(0x1::string::length(v1) > 0 && 0x1::string::length(v1) <= 50, 1014);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

