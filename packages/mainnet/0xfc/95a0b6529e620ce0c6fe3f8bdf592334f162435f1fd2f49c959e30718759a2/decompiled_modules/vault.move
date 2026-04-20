module 0xfc95a0b6529e620ce0c6fe3f8bdf592334f162435f1fd2f49c959e30718759a2::vault {
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
        minimum_balance: u64,
        sponsor_reclaimed: bool,
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
        wal_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
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

    struct BeneficiariesUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        new_beneficiaries_count: u64,
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
        new_timeout: u64,
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

    struct VaultExpired has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        walrus_blob_id: 0x1::string::String,
        beneficiaries: vector<Beneficiary>,
        expired_at: u64,
    }

    struct VaultClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        beneficiary_hash: vector<u8>,
        claimed_at: u64,
    }

    struct VaultDeleted has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        deleted_by: address,
        deleted_at: u64,
    }

    struct SponsorFundsReclaimed has copy, drop {
        vault_id: 0x2::object::ID,
        sponsor: address,
        amount_reclaimed: u64,
        reclaimed_at: u64,
    }

    struct EarlyUnlockTriggered has copy, drop {
        vault_id: 0x2::object::ID,
        approvals: u64,
        threshold: u64,
        triggered_at: u64,
    }

    struct WalToppedUp has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount_added: u64,
        new_balance: u64,
        timestamp: u64,
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

    struct WalBalanceLow has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        current_balance: u64,
        alert_threshold: u64,
        timestamp: u64,
    }

    fun apply_vault_info_update(arg0: &mut Vault, arg1: 0x1::string::String, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(v0 > 0, 4);
        assert!(0x1::vector::length<u8>(&arg3) == v0, 5);
        let v1 = 0x1::vector::length<vector<u8>>(&arg4);
        assert!(v1 == 0 || v1 == v0, 5);
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
            let v2 = Beneficiary{
                identifier_hash  : *0x1::vector::borrow<vector<u8>>(&arg0, v0),
                beneficiary_type : *0x1::vector::borrow<u8>(&arg1, v0),
            };
            0x1::vector::push_back<Beneficiary>(&mut v1, v2);
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
        assert!(0x2::tx_context::sender(arg2) == arg0.sponsor, 9);
        assert!(!arg0.claimed, 2);
        assert!(!arg0.early_expiring, 2);
        let v1 = arg0.last_checkin + arg0.timeout_period;
        assert!(v0 < v1, 2);
        if (arg0.checkin_window_secs > 0 && arg0.timeout_period > arg0.checkin_window_secs) {
            assert!(v0 >= v1 - arg0.checkin_window_secs, 15);
        };
        arg0.last_checkin = v0;
        let v2 = CheckinRecord{
            timestamp : v0,
            epoch     : 0x2::tx_context::epoch(arg2),
        };
        if (0x1::vector::length<CheckinRecord>(&arg0.checkin_history) >= 50) {
            0x1::vector::remove<CheckinRecord>(&mut arg0.checkin_history, 0);
        };
        0x1::vector::push_back<CheckinRecord>(&mut arg0.checkin_history, v2);
        let v3 = VaultCheckedIn{
            vault_id       : 0x2::object::uid_to_inner(&arg0.id),
            owner          : arg0.owner,
            new_expiration : v0 + arg0.timeout_period,
            timestamp      : v0,
        };
        0x2::event::emit<VaultCheckedIn>(v3);
    }

    public entry fun claim_vault(arg0: &mut Vault, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(!arg0.claimed, 2);
        assert!(v0 >= arg0.last_checkin + arg0.timeout_period, 1);
        let v1 = &arg0.beneficiaries;
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<Beneficiary>(v1)) {
            if (0x1::vector::borrow<Beneficiary>(v1, v2).identifier_hash == arg1) {
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v3, 5);
        arg0.claimed = true;
        let v4 = VaultClaimed{
            vault_id         : 0x2::object::uid_to_inner(&arg0.id),
            beneficiary_hash : arg1,
            claimed_at       : v0,
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

    public entry fun create_vault(arg0: &SponsorRegistry, arg1: address, arg2: 0x1::string::String, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: 0x1::string::String, arg6: u64, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.sponsor, 8);
        assert!(arg6 > 0, 3);
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v0 > 0, 4);
        assert!(0x1::vector::length<u8>(&arg4) == v0, 5);
        let v1 = 0x1::vector::length<vector<u8>>(&arg7);
        assert!(v1 == 0 || v1 == v0, 5);
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
        let v8 = 0x1::vector::empty<bool>();
        if (v1 > 0) {
            let v9 = 0;
            while (v9 < v0) {
                0x1::vector::push_back<bool>(&mut v8, false);
                v9 = v9 + 1;
            };
        };
        let v10 = Vault{
            id                       : v5,
            owner                    : arg1,
            sponsor                  : 0x2::tx_context::sender(arg9),
            minimum_balance          : 0,
            sponsor_reclaimed        : false,
            beneficiary_code_hashes  : arg7,
            early_unlock_submissions : v8,
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
            wal_reserve              : 0x2::balance::zero<0x2::sui::SUI>(),
            blob_expiry_unix         : 0,
            total_renewals           : 0,
        };
        let v11 = VaultCreated{
            vault_id            : 0x2::object::uid_to_inner(&v5),
            owner               : arg1,
            timeout_period      : v3,
            beneficiaries_count : v0,
            timestamp           : v2,
        };
        0x2::event::emit<VaultCreated>(v11);
        0x2::transfer::public_transfer<Vault>(v10, 0x2::tx_context::sender(arg9));
    }

    public entry fun delete_vault(arg0: Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.sponsor, 9);
        assert!(arg0.claimed, 20);
        assert!(arg0.sponsor_reclaimed, 21);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.wal_reserve) == 0, 21);
        let Vault {
            id                       : v1,
            owner                    : _,
            sponsor                  : _,
            minimum_balance          : _,
            sponsor_reclaimed        : _,
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
            wal_reserve              : v22,
            blob_expiry_unix         : _,
            total_renewals           : _,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v22);
        0x2::object::delete(v1);
        let v25 = VaultDeleted{
            vault_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner      : arg0.owner,
            deleted_by : v0,
            deleted_at : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<VaultDeleted>(v25);
    }

    public entry fun extend_timeout(arg0: &mut Vault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(0x2::tx_context::sender(arg3) == arg0.sponsor, 9);
        assert!(arg1 > 0, 3);
        assert!(v0 < arg0.last_checkin + arg0.timeout_period, 2);
        let v1 = arg0.timeout_period;
        let v2 = v1 + arg1 * 24 * 60 * 60;
        arg0.timeout_period = v2;
        let v3 = TimeoutExtended{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            owner       : arg0.owner,
            old_timeout : v1,
            new_timeout : v2,
            timestamp   : v0,
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

    public fun get_minimum_balance(arg0: &Vault) : u64 {
        arg0.minimum_balance
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

    public fun get_wal_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.wal_reserve)
    }

    public fun get_walrus_blob_id(arg0: &Vault) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SponsorRegistry{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            sponsor : @0x6c4dc89a631fb5367b6ea09974f71be24da5a25d8d18ddbdbd92e52d28177505,
        };
        0x2::transfer::share_object<SponsorRegistry>(v0);
    }

    public fun is_early_unlock_enabled(arg0: &Vault) : bool {
        !0x1::vector::is_empty<vector<u8>>(&arg0.beneficiary_code_hashes)
    }

    public fun is_expired(arg0: &Vault, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.last_checkin + arg0.timeout_period
    }

    public fun is_sponsor_reclaimed(arg0: &Vault) : bool {
        arg0.sponsor_reclaimed
    }

    public entry fun reclaim_sponsor_funds(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.sponsor, 9);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v1 >= arg0.last_checkin + arg0.timeout_period || arg0.early_expiring, 10);
        assert!(!arg0.sponsor_reclaimed, 11);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.wal_reserve);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.wal_reserve, v2), arg2), v0);
        };
        arg0.sponsor_reclaimed = true;
        let v3 = SponsorFundsReclaimed{
            vault_id         : 0x2::object::uid_to_inner(&arg0.id),
            sponsor          : v0,
            amount_reclaimed : v2,
            reclaimed_at     : v1,
        };
        0x2::event::emit<SponsorFundsReclaimed>(v3);
    }

    public entry fun renew_blob(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg0.sponsor || v0 == arg0.owner, 9);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.wal_reserve) >= arg3, 6);
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.wal_reserve, arg3), arg6), v0);
        };
        arg0.blob_expiry_unix = arg1;
        arg0.total_renewals = arg0.total_renewals + 1;
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.wal_reserve);
        let v3 = BlobRenewed{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            walrus_blob_id  : arg0.walrus_blob_id,
            epochs_added    : arg2,
            new_expiry_unix : arg1,
            cost_paid       : arg3,
            renewed_by      : v0,
            timestamp       : v1,
        };
        0x2::event::emit<BlobRenewed>(v3);
        if (arg4 > 0 && v2 < arg4) {
            let v4 = WalBalanceLow{
                vault_id        : 0x2::object::uid_to_inner(&arg0.id),
                owner           : arg0.owner,
                current_balance : v2,
                alert_threshold : arg4,
                timestamp       : v1,
            };
            0x2::event::emit<WalBalanceLow>(v4);
        };
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

    public entry fun set_checkin_window(arg0: &mut Vault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.sponsor, 9);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v0 < arg0.last_checkin + arg0.timeout_period, 2);
        let v1 = arg1 * 24 * 60 * 60;
        assert!(v1 == 0 || v1 <= arg0.timeout_period, 16);
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

    public entry fun set_minimum_balance(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.sponsor, 9);
        arg0.minimum_balance = arg1;
    }

    public entry fun submit_early_unlock(arg0: &mut Vault, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<vector<u8>>(&arg0.beneficiary_code_hashes), 12);
        assert!(!arg0.claimed, 2);
        assert!(!arg0.early_expiring, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v0 < arg0.last_checkin + arg0.timeout_period, 2);
        let v1 = 0x1::vector::length<Beneficiary>(&arg0.beneficiaries);
        let v2 = 0;
        let v3 = false;
        let v4 = 0;
        while (v2 < v1) {
            if (0x1::vector::borrow<Beneficiary>(&arg0.beneficiaries, v2).identifier_hash == arg1) {
                v3 = true;
                v4 = v2;
                break
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

    public entry fun top_up(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.sponsor, 9);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.wal_reserve, v0);
        let v1 = WalToppedUp{
            vault_id     : 0x2::object::uid_to_inner(&arg0.id),
            owner        : arg0.owner,
            amount_added : 0x2::balance::value<0x2::sui::SUI>(&v0),
            new_balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.wal_reserve),
            timestamp    : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<WalToppedUp>(v1);
    }

    public entry fun trigger_expiry(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 >= arg0.last_checkin + arg0.timeout_period || arg0.early_expiring, 1);
        assert!(!arg0.claimed, 2);
        arg0.claimed = true;
        let v1 = VaultExpired{
            vault_id       : 0x2::object::uid_to_inner(&arg0.id),
            owner          : arg0.owner,
            walrus_blob_id : arg0.walrus_blob_id,
            beneficiaries  : arg0.beneficiaries,
            expired_at     : v0,
        };
        0x2::event::emit<VaultExpired>(v1);
    }

    public entry fun update_beneficiaries(arg0: &mut Vault, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x1::vector::length<vector<u8>>(&arg1);
        assert!(v1 > 0, 4);
        assert!(0x1::vector::length<u8>(&arg2) == v1, 5);
        assert!(v0 < arg0.last_checkin + arg0.timeout_period, 2);
        arg0.beneficiaries = build_beneficiaries(arg1, arg2);
        let v2 = BeneficiariesUpdated{
            vault_id                : 0x2::object::uid_to_inner(&arg0.id),
            owner                   : arg0.owner,
            new_beneficiaries_count : v1,
            timestamp               : v0,
        };
        0x2::event::emit<BeneficiariesUpdated>(v2);
    }

    public entry fun update_metadata(arg0: &mut Vault, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v0 < arg0.last_checkin + arg0.timeout_period, 2);
        arg0.name = arg1;
        let v1 = MetadataUpdated{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg0.owner,
            timestamp : v0,
        };
        0x2::event::emit<MetadataUpdated>(v1);
    }

    public entry fun update_secret(arg0: &mut Vault, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(0x2::tx_context::sender(arg3) == arg0.sponsor, 9);
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

    // decompiled from Move bytecode v7
}

