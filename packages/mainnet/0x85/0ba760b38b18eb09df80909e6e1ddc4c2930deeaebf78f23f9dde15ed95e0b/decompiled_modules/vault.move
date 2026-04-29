module 0x850ba760b38b18eb09df80909e6e1ddc4c2930deeaebf78f23f9dde15ed95e0b::vault {
    struct SponsorRegistry has store, key {
        id: 0x2::object::UID,
        admin: address,
        sponsor: address,
    }

    struct Beneficiary has copy, drop, store {
        identifier_hash: vector<u8>,
        beneficiary_type: u8,
    }

    struct CheckinRecord has copy, drop, store {
        timestamp: u64,
        epoch: u64,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        owner: address,
        sponsor: address,
        authorized_sponsors: vector<address>,
        beneficiary_code_hashes: vector<vector<u8>>,
        early_unlock_submissions: vector<bool>,
        early_unlock_count: u64,
        early_expiring: bool,
        name: 0x1::string::String,
        beneficiaries: vector<Beneficiary>,
        walrus_blob_id: 0x1::string::String,
        timeout_period: u64,
        checkin_window_secs: u64,
        last_checkin: u64,
        created_at: u64,
        checkin_history: vector<CheckinRecord>,
        claimed: bool,
        last_metadata_updated: u64,
        last_secret_updated: u64,
        secret_version: u64,
        blob_expiry_unix: u64,
        total_renewals: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        timeout_period: u64,
        beneficiaries_count: u64,
        timestamp: u64,
    }

    struct VaultCheckedIn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        new_expiration: u64,
        timestamp: u64,
    }

    struct SecretUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        new_walrus_blob_id: 0x1::string::String,
        secret_version: u64,
        next_update_allowed_at: u64,
        updated_by: address,
        timestamp: u64,
    }

    struct MetadataUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct TimeoutExtended has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        old_timeout: u64,
        added_timeout: u64,
        timestamp: u64,
    }

    struct CheckinWindowUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        old_window: u64,
        new_window: u64,
        timestamp: u64,
    }

    struct SponsorRotated has copy, drop {
        old_sponsor: address,
        new_sponsor: address,
        rotated_by: address,
        timestamp: u64,
    }

    struct VaultSponsorsUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        primary_sponsor: address,
        sponsors_count: u64,
        updated_by: address,
        timestamp: u64,
    }

    struct VaultExpired has copy, drop {
        vault_id: 0x2::object::ID,
        walrus_blob_id: 0x1::string::String,
    }

    struct VaultClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        claimed_at: u64,
    }

    struct VaultDeleted has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        deleted_by: address,
        deleted_at: u64,
    }

    struct EarlyUnlockTriggered has copy, drop {
        vault_id: 0x2::object::ID,
        approvals: u64,
        threshold: u64,
        triggered_at: u64,
    }

    struct BlobRenewed has copy, drop {
        vault_id: 0x2::object::ID,
        walrus_blob_id: 0x1::string::String,
        epochs_added: u64,
        new_expiry_unix: u64,
        cost_paid: u64,
        renewed_by: address,
        timestamp: u64,
    }

    fun apply_vault_info_update(arg0: &mut Vault, arg1: 0x1::string::String, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64) {
        assert!(!arg0.early_expiring, 2);
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(v0 > 0, 4);
        assert!(0x1::vector::length<u8>(&arg3) == v0, 5);
        assert_hashes_len(&arg2);
        let v1 = 0x1::vector::length<vector<u8>>(&arg4);
        assert!(v1 == 0 || v1 == v0, 5);
        assert_hashes_len(&arg4);
        if (!beneficiaries_equal(arg0, &arg2, &arg3) || !code_hashes_equal(&arg0.beneficiary_code_hashes, &arg4)) {
            arg0.beneficiary_code_hashes = arg4;
            if (v1 == 0) {
                arg0.early_unlock_submissions = 0x1::vector::empty<bool>();
            } else {
                arg0.early_unlock_submissions = build_empty_submissions(v0);
            };
            arg0.early_unlock_count = 0;
            arg0.early_expiring = false;
        };
        arg0.beneficiaries = build_beneficiaries(arg2, arg3);
        arg0.name = arg1;
        arg0.last_metadata_updated = arg5;
    }

    fun assert_authorized_sponsor(arg0: &Vault, arg1: address) {
        assert!(is_sender_authorized_sponsor(arg0, arg1), 9);
    }

    fun assert_hashes_len(arg0: &vector<vector<u8>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg0, v0)) == 32, 5);
            v0 = v0 + 1;
        };
    }

    fun assert_vault_unresolved(arg0: &Vault) {
        assert!(!arg0.claimed, 2);
    }

    fun beneficiaries_equal(arg0: &Vault, arg1: &vector<vector<u8>>, arg2: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(arg1);
        if (v0 != 0x1::vector::length<u8>(arg2) || v0 != 0x1::vector::length<Beneficiary>(&arg0.beneficiaries)) {
            return false
        };
        let v1 = 0;
        let v2 = true;
        while (v1 < v0) {
            let v3 = 0x1::vector::borrow<Beneficiary>(&arg0.beneficiaries, v1);
            if (v3.identifier_hash != *0x1::vector::borrow<vector<u8>>(arg1, v1) || v3.beneficiary_type != *0x1::vector::borrow<u8>(arg2, v1)) {
                v2 = false;
            };
            v1 = v1 + 1;
        };
        v2
    }

    fun build_beneficiaries(arg0: vector<vector<u8>>, arg1: vector<u8>) : vector<Beneficiary> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<Beneficiary>();
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(&arg0, v0);
            assert!(0x1::vector::length<u8>(&v2) == 32, 5);
            let v3 = Beneficiary{
                identifier_hash  : v2,
                beneficiary_type : *0x1::vector::borrow<u8>(&arg1, v0),
            };
            0x1::vector::push_back<Beneficiary>(&mut v1, v3);
            v0 = v0 + 1;
        };
        v1
    }

    fun build_empty_submissions(arg0: u64) : vector<bool> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<bool>();
        while (v0 < arg0) {
            0x1::vector::push_back<bool>(&mut v1, false);
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun checkin(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert_authorized_sponsor(arg0, 0x2::tx_context::sender(arg2));
        assert!(!arg0.claimed, 2);
        assert!(!arg0.early_expiring, 2);
        let v1 = arg0.last_checkin + arg0.timeout_period;
        assert!(v0 < v1, 2);
        let v2 = effective_checkin_window_secs(arg0);
        if (arg0.timeout_period > v2) {
            assert!(v0 >= v1 - v2, 15);
        };
        arg0.last_checkin = v0;
        let v3 = CheckinRecord{
            timestamp : v0,
            epoch     : 0x2::tx_context::epoch(arg2),
        };
        if (0x1::vector::length<CheckinRecord>(&arg0.checkin_history) >= 50) {
            0x1::vector::remove<CheckinRecord>(&mut arg0.checkin_history, 0);
        };
        0x1::vector::push_back<CheckinRecord>(&mut arg0.checkin_history, v3);
        let v4 = VaultCheckedIn{
            vault_id       : 0x2::object::uid_to_inner(&arg0.id),
            owner          : arg0.owner,
            new_expiration : v0 + arg0.timeout_period,
            timestamp      : v0,
        };
        0x2::event::emit<VaultCheckedIn>(v4);
    }

    public entry fun claim_vault(arg0: &mut Vault, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_authorized_sponsor(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert_vault_unresolved(arg0);
        assert!(v0 >= arg0.last_checkin + arg0.timeout_period, 21);
        let v1 = &arg0.beneficiaries;
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<Beneficiary>(v1) && !v3) {
            if (0x1::vector::borrow<Beneficiary>(v1, v2).identifier_hash == arg1) {
                v3 = true;
            };
            v2 = v2 + 1;
        };
        assert!(v3, 5);
        arg0.claimed = true;
        let v4 = VaultClaimed{
            vault_id   : 0x2::object::uid_to_inner(&arg0.id),
            claimed_at : v0,
        };
        0x2::event::emit<VaultClaimed>(v4);
    }

    fun code_hashes_equal(arg0: &vector<vector<u8>>, arg1: &vector<vector<u8>>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        if (v0 != 0x1::vector::length<vector<u8>>(arg1)) {
            return false
        };
        let v1 = 0;
        let v2 = true;
        while (v1 < v0) {
            if (*0x1::vector::borrow<vector<u8>>(arg0, v1) != *0x1::vector::borrow<vector<u8>>(arg1, v1)) {
                v2 = false;
            };
            v1 = v1 + 1;
        };
        v2
    }

    fun contains_address(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun create_vault(arg0: &SponsorRegistry, arg1: address, arg2: 0x1::string::String, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: 0x1::string::String, arg6: u64, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.sponsor, 8);
        assert!(arg1 != arg0.sponsor, 24);
        assert!(arg6 > 0, 3);
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v0 > 0, 4);
        assert!(0x1::vector::length<u8>(&arg4) == v0, 5);
        assert_hashes_len(&arg3);
        let v1 = 0x1::vector::length<vector<u8>>(&arg7);
        assert!(v1 == 0 || v1 == v0, 5);
        assert_hashes_len(&arg7);
        let v2 = 0x2::clock::timestamp_ms(arg8) / 1000;
        let v3 = arg6 * 24 * 60 * 60;
        let v4 = if (v3 > 2592000) {
            2592000
        } else {
            v3
        };
        let v5 = 0x2::object::new(arg9);
        let v6 = 0x1::vector::empty<CheckinRecord>();
        let v7 = CheckinRecord{
            timestamp : v2,
            epoch     : 0x2::tx_context::epoch(arg9),
        };
        0x1::vector::push_back<CheckinRecord>(&mut v6, v7);
        let v8 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v8, 0x2::tx_context::sender(arg9));
        let v9 = 0x1::vector::empty<bool>();
        if (v1 > 0) {
            let v10 = 0;
            while (v10 < v0) {
                0x1::vector::push_back<bool>(&mut v9, false);
                v10 = v10 + 1;
            };
        };
        let v11 = Vault{
            id                       : v5,
            owner                    : arg1,
            sponsor                  : 0x2::tx_context::sender(arg9),
            authorized_sponsors      : v8,
            beneficiary_code_hashes  : arg7,
            early_unlock_submissions : v9,
            early_unlock_count       : 0,
            early_expiring           : false,
            name                     : arg2,
            beneficiaries            : build_beneficiaries(arg3, arg4),
            walrus_blob_id           : arg5,
            timeout_period           : v3,
            checkin_window_secs      : v4,
            last_checkin             : v2,
            created_at               : v2,
            checkin_history          : v6,
            claimed                  : false,
            last_metadata_updated    : 0,
            last_secret_updated      : 0,
            secret_version           : 1,
            blob_expiry_unix         : 0,
            total_renewals           : 0,
        };
        let v12 = VaultCreated{
            vault_id            : 0x2::object::uid_to_inner(&v5),
            owner               : arg1,
            timeout_period      : v3,
            beneficiaries_count : v0,
            timestamp           : v2,
        };
        0x2::event::emit<VaultCreated>(v12);
        0x2::transfer::public_transfer<Vault>(v11, 0x2::tx_context::sender(arg9));
    }

    public entry fun create_vault_shared(arg0: &SponsorRegistry, arg1: address, arg2: vector<address>, arg3: 0x1::string::String, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: 0x1::string::String, arg7: u64, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == arg0.sponsor, 8);
        validate_authorized_sponsors(&arg2, arg1);
        assert!(arg7 > 0, 3);
        let v0 = 0x1::vector::length<vector<u8>>(&arg4);
        assert!(v0 > 0, 4);
        assert!(0x1::vector::length<u8>(&arg5) == v0, 5);
        assert_hashes_len(&arg4);
        let v1 = 0x1::vector::length<vector<u8>>(&arg8);
        assert!(v1 == 0 || v1 == v0, 5);
        assert_hashes_len(&arg8);
        let v2 = 0x2::clock::timestamp_ms(arg9) / 1000;
        let v3 = arg7 * 24 * 60 * 60;
        let v4 = if (v3 > 2592000) {
            2592000
        } else {
            v3
        };
        let v5 = *0x1::vector::borrow<address>(&arg2, 0);
        let v6 = 0x2::object::new(arg10);
        let v7 = 0x2::object::uid_to_inner(&v6);
        let v8 = 0x1::vector::empty<CheckinRecord>();
        let v9 = CheckinRecord{
            timestamp : v2,
            epoch     : 0x2::tx_context::epoch(arg10),
        };
        0x1::vector::push_back<CheckinRecord>(&mut v8, v9);
        let v10 = 0x1::vector::empty<bool>();
        if (v1 > 0) {
            let v11 = 0;
            while (v11 < v0) {
                0x1::vector::push_back<bool>(&mut v10, false);
                v11 = v11 + 1;
            };
        };
        let v12 = Vault{
            id                       : v6,
            owner                    : arg1,
            sponsor                  : v5,
            authorized_sponsors      : arg2,
            beneficiary_code_hashes  : arg8,
            early_unlock_submissions : v10,
            early_unlock_count       : 0,
            early_expiring           : false,
            name                     : arg3,
            beneficiaries            : build_beneficiaries(arg4, arg5),
            walrus_blob_id           : arg6,
            timeout_period           : v3,
            checkin_window_secs      : v4,
            last_checkin             : v2,
            created_at               : v2,
            checkin_history          : v8,
            claimed                  : false,
            last_metadata_updated    : 0,
            last_secret_updated      : 0,
            secret_version           : 1,
            blob_expiry_unix         : 0,
            total_renewals           : 0,
        };
        let v13 = VaultCreated{
            vault_id            : v7,
            owner               : arg1,
            timeout_period      : v3,
            beneficiaries_count : v0,
            timestamp           : v2,
        };
        0x2::event::emit<VaultCreated>(v13);
        let v14 = VaultSponsorsUpdated{
            vault_id        : v7,
            owner           : arg1,
            primary_sponsor : v5,
            sponsors_count  : 0x1::vector::length<address>(&arg2),
            updated_by      : 0x2::tx_context::sender(arg10),
            timestamp       : v2,
        };
        0x2::event::emit<VaultSponsorsUpdated>(v14);
        0x2::transfer::share_object<Vault>(v12);
    }

    public entry fun delete_vault(arg0: Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_authorized_sponsor(&arg0, v0);
        assert!(arg0.claimed, 20);
        let Vault {
            id                       : v1,
            owner                    : _,
            sponsor                  : _,
            authorized_sponsors      : _,
            beneficiary_code_hashes  : _,
            early_unlock_submissions : _,
            early_unlock_count       : _,
            early_expiring           : _,
            name                     : _,
            beneficiaries            : _,
            walrus_blob_id           : _,
            timeout_period           : _,
            checkin_window_secs      : _,
            last_checkin             : _,
            created_at               : _,
            checkin_history          : _,
            claimed                  : _,
            last_metadata_updated    : _,
            last_secret_updated      : _,
            secret_version           : _,
            blob_expiry_unix         : _,
            total_renewals           : _,
        } = arg0;
        0x2::object::delete(v1);
        let v23 = VaultDeleted{
            vault_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner      : arg0.owner,
            deleted_by : v0,
            deleted_at : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<VaultDeleted>(v23);
    }

    fun effective_checkin_window_secs(arg0: &Vault) : u64 {
        let v0 = if (arg0.timeout_period > 2592000) {
            2592000
        } else {
            arg0.timeout_period
        };
        let v1 = if (arg0.checkin_window_secs == 0) {
            v0
        } else {
            arg0.checkin_window_secs
        };
        if (v1 > arg0.timeout_period) {
            arg0.timeout_period
        } else {
            v1
        }
    }

    public entry fun extend_timeout(arg0: &mut Vault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert_authorized_sponsor(arg0, 0x2::tx_context::sender(arg3));
        assert!(!arg0.claimed, 2);
        assert!(arg1 > 0, 3);
        assert!(v0 < arg0.last_checkin + arg0.timeout_period, 2);
        let v1 = arg0.timeout_period;
        let v2 = arg1 * 24 * 60 * 60;
        arg0.timeout_period = v1 + v2;
        let v3 = TimeoutExtended{
            vault_id      : 0x2::object::uid_to_inner(&arg0.id),
            owner         : arg0.owner,
            old_timeout   : v1,
            added_timeout : v2,
            timestamp     : v0,
        };
        0x2::event::emit<TimeoutExtended>(v3);
    }

    public fun get_active_sponsor(arg0: &SponsorRegistry) : address {
        arg0.sponsor
    }

    public fun get_beneficiaries_count(arg0: &Vault) : u64 {
        0x1::vector::length<Beneficiary>(&arg0.beneficiaries)
    }

    public fun get_blob_expiry_unix(arg0: &Vault) : u64 {
        arg0.blob_expiry_unix
    }

    public fun get_checkin_window_secs(arg0: &Vault) : u64 {
        arg0.checkin_window_secs
    }

    public fun get_early_expiring(arg0: &Vault) : bool {
        arg0.early_expiring
    }

    public fun get_early_unlock_count(arg0: &Vault) : u64 {
        arg0.early_unlock_count
    }

    public fun get_expiration_time(arg0: &Vault) : u64 {
        arg0.last_checkin + arg0.timeout_period
    }

    public fun get_last_secret_updated(arg0: &Vault) : u64 {
        arg0.last_secret_updated
    }

    public fun get_owner(arg0: &Vault) : address {
        arg0.owner
    }

    public fun get_registry_admin(arg0: &SponsorRegistry) : address {
        arg0.admin
    }

    public fun get_secret_version(arg0: &Vault) : u64 {
        arg0.secret_version
    }

    public fun get_sponsor(arg0: &Vault) : address {
        arg0.sponsor
    }

    public fun get_total_renewals(arg0: &Vault) : u64 {
        arg0.total_renewals
    }

    public fun get_walrus_blob_id(arg0: &Vault) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = SponsorRegistry{
            id      : 0x2::object::new(arg0),
            admin   : v0,
            sponsor : v0,
        };
        0x2::transfer::share_object<SponsorRegistry>(v1);
    }

    public fun is_early_unlock_enabled(arg0: &Vault) : bool {
        !0x1::vector::is_empty<vector<u8>>(&arg0.beneficiary_code_hashes)
    }

    public fun is_expired(arg0: &Vault, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.last_checkin + arg0.timeout_period
    }

    fun is_sender_authorized_sponsor(arg0: &Vault, arg1: address) : bool {
        if (arg1 == arg0.sponsor) {
            return true
        };
        contains_address(&arg0.authorized_sponsors, arg1)
    }

    public entry fun renew_blob(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_authorized_sponsor(arg0, v0);
        assert!(!arg0.claimed, 2);
        assert!(arg2 > 0 && arg2 <= 53, 22);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        if (arg0.blob_expiry_unix > 0) {
            let v2 = if (arg0.blob_expiry_unix > 7776000) {
                arg0.blob_expiry_unix - 7776000
            } else {
                0
            };
            assert!(v1 >= v2, 23);
            assert!(arg1 >= arg0.blob_expiry_unix + arg2 * 86400 && arg1 <= arg0.blob_expiry_unix + arg2 * 1209600 + 7200, 22);
        } else {
            assert!(arg1 > v1, 22);
        };
        arg0.blob_expiry_unix = arg1;
        arg0.total_renewals = arg0.total_renewals + 1;
        let v3 = BlobRenewed{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            walrus_blob_id  : arg0.walrus_blob_id,
            epochs_added    : arg2,
            new_expiry_unix : arg1,
            cost_paid       : 0,
            renewed_by      : v0,
            timestamp       : v1,
        };
        0x2::event::emit<BlobRenewed>(v3);
    }

    public entry fun rotate_sponsor(arg0: &mut SponsorRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.admin, 17);
        arg0.sponsor = arg1;
        let v1 = SponsorRotated{
            old_sponsor : arg0.sponsor,
            new_sponsor : arg1,
            rotated_by  : v0,
            timestamp   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<SponsorRotated>(v1);
    }

    public entry fun set_authorized_sponsors(arg0: &mut Vault, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.sponsor, 9);
        validate_authorized_sponsors(&arg1, arg0.owner);
        let v1 = *0x1::vector::borrow<address>(&arg1, 0);
        arg0.sponsor = v1;
        arg0.authorized_sponsors = arg1;
        let v2 = VaultSponsorsUpdated{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            owner           : arg0.owner,
            primary_sponsor : v1,
            sponsors_count  : 0x1::vector::length<address>(&arg1),
            updated_by      : v0,
            timestamp       : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<VaultSponsorsUpdated>(v2);
    }

    public entry fun set_checkin_window(arg0: &mut Vault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_authorized_sponsor(arg0, 0x2::tx_context::sender(arg3));
        assert!(!arg0.claimed, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v0 < arg0.last_checkin + arg0.timeout_period, 2);
        let v1 = arg1 * 24 * 60 * 60;
        assert!(v1 >= 86400 && v1 <= arg0.timeout_period, 16);
        arg0.checkin_window_secs = v1;
        let v2 = CheckinWindowUpdated{
            vault_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner      : arg0.owner,
            old_window : arg0.checkin_window_secs,
            new_window : v1,
            timestamp  : v0,
        };
        0x2::event::emit<CheckinWindowUpdated>(v2);
    }

    public entry fun submit_early_unlock(arg0: &mut Vault, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_authorized_sponsor(arg0, 0x2::tx_context::sender(arg4));
        assert!(!arg0.early_expiring, 2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 5);
        assert!(!0x1::vector::is_empty<vector<u8>>(&arg0.beneficiary_code_hashes), 12);
        assert!(!arg0.claimed, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v0 < arg0.last_checkin + arg0.timeout_period, 2);
        let v1 = 0x1::vector::length<Beneficiary>(&arg0.beneficiaries);
        let v2 = 0;
        let v3 = false;
        let v4 = 0;
        while (v2 < v1 && !v3) {
            if (0x1::vector::borrow<Beneficiary>(&arg0.beneficiaries, v2).identifier_hash == arg1) {
                v3 = true;
            };
            v2 = v2 + 1;
        };
        assert!(v3, 5);
        assert!(!*0x1::vector::borrow<bool>(&arg0.early_unlock_submissions, v4), 13);
        assert!(*0x1::vector::borrow<vector<u8>>(&arg0.beneficiary_code_hashes, v4) == arg2, 14);
        *0x1::vector::borrow_mut<bool>(&mut arg0.early_unlock_submissions, v4) = true;
        arg0.early_unlock_count = arg0.early_unlock_count + 1;
        let v5 = v1 / 2 + 1;
        if (arg0.early_unlock_count >= v5) {
            arg0.early_expiring = true;
            let v6 = EarlyUnlockTriggered{
                vault_id     : 0x2::object::uid_to_inner(&arg0.id),
                approvals    : arg0.early_unlock_count,
                threshold    : v5,
                triggered_at : v0,
            };
            0x2::event::emit<EarlyUnlockTriggered>(v6);
        };
    }

    public entry fun trigger_expiry(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_authorized_sponsor(arg0, 0x2::tx_context::sender(arg2));
        assert_vault_unresolved(arg0);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.last_checkin + arg0.timeout_period || arg0.early_expiring, 21);
        arg0.claimed = true;
        let v0 = VaultExpired{
            vault_id       : 0x2::object::uid_to_inner(&arg0.id),
            walrus_blob_id : arg0.walrus_blob_id,
        };
        0x2::event::emit<VaultExpired>(v0);
    }

    public entry fun update_metadata(arg0: &mut Vault, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert_authorized_sponsor(arg0, 0x2::tx_context::sender(arg3));
        assert!(!arg0.claimed, 2);
        assert!(v0 < arg0.last_checkin + arg0.timeout_period, 2);
        assert!(arg0.last_metadata_updated == 0 || v0 >= arg0.last_metadata_updated + 2592000, 7);
        arg0.name = arg1;
        arg0.last_metadata_updated = v0;
        let v1 = MetadataUpdated{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg0.owner,
            timestamp : v0,
        };
        0x2::event::emit<MetadataUpdated>(v1);
    }

    public entry fun update_secret(arg0: &mut Vault, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert_authorized_sponsor(arg0, 0x2::tx_context::sender(arg3));
        assert!(!arg0.claimed, 2);
        assert!(!arg0.early_expiring, 2);
        let v1 = arg0.last_checkin + arg0.timeout_period;
        assert!(v0 < v1, 2);
        if (arg0.timeout_period > 2592000) {
            assert!(v0 < v1 - 2592000, 19);
        };
        assert!(arg0.last_secret_updated == 0 || v0 >= arg0.last_secret_updated + 2592000, 18);
        arg0.walrus_blob_id = arg1;
        arg0.last_secret_updated = v0;
        arg0.secret_version = arg0.secret_version + 1;
        let v2 = SecretUpdated{
            vault_id               : 0x2::object::uid_to_inner(&arg0.id),
            owner                  : arg0.owner,
            new_walrus_blob_id     : arg1,
            secret_version         : arg0.secret_version,
            next_update_allowed_at : v0 + 2592000,
            updated_by             : 0x2::tx_context::sender(arg3),
            timestamp              : v0,
        };
        0x2::event::emit<SecretUpdated>(v2);
    }

    public entry fun update_vault_info(arg0: &mut Vault, arg1: 0x1::string::String, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert_authorized_sponsor(arg0, 0x2::tx_context::sender(arg5));
        assert!(!arg0.claimed, 2);
        assert!(v0 < arg0.last_checkin + arg0.timeout_period, 2);
        assert!(arg0.last_metadata_updated == 0 || v0 >= arg0.last_metadata_updated + 2592000, 7);
        apply_vault_info_update(arg0, arg1, arg2, arg3, 0x1::vector::empty<vector<u8>>(), v0);
        let v1 = MetadataUpdated{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg0.owner,
            timestamp : v0,
        };
        0x2::event::emit<MetadataUpdated>(v1);
    }

    public entry fun update_vault_info_with_codes(arg0: &mut Vault, arg1: 0x1::string::String, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        assert_authorized_sponsor(arg0, 0x2::tx_context::sender(arg6));
        assert!(!arg0.claimed, 2);
        assert!(v0 < arg0.last_checkin + arg0.timeout_period, 2);
        assert!(arg0.last_metadata_updated == 0 || v0 >= arg0.last_metadata_updated + 2592000, 7);
        apply_vault_info_update(arg0, arg1, arg2, arg3, arg4, v0);
        let v1 = MetadataUpdated{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg0.owner,
            timestamp : v0,
        };
        0x2::event::emit<MetadataUpdated>(v1);
    }

    fun validate_authorized_sponsors(arg0: &vector<address>, arg1: address) {
        let v0 = 0x1::vector::length<address>(arg0);
        assert!(v0 > 0 && v0 <= 5, 25);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(arg0, v1);
            assert!(v2 != arg1, 24);
            let v3 = v1 + 1;
            while (v3 < v0) {
                assert!(v2 != *0x1::vector::borrow<address>(arg0, v3), 25);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

