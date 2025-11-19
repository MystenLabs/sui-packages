module 0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::storage_lease {
    struct RenewalRecord has copy, drop, store {
        renewed_at_epoch: u64,
        extended_by_epochs: u64,
        new_expiry_epoch: u64,
        payment_amount: u64,
        renewed_by: address,
    }

    struct StorageLease has store, key {
        id: 0x2::object::UID,
        owner: address,
        submission_id: 0x2::object::ID,
        walrus_blob_id: 0x1::string::String,
        walrus_deal_id: 0x1::string::String,
        capacity_bytes: u64,
        created_at_epoch: u64,
        expires_at_epoch: u64,
        lease_duration_epochs: u64,
        expiry_processed: bool,
        renewal_history: vector<RenewalRecord>,
        total_renewals: u64,
        lease_price_per_epoch: u64,
        total_paid: u64,
    }

    struct LeaseRegistry has key {
        id: 0x2::object::UID,
        total_leases: u64,
        active_leases: u64,
        expired_leases: u64,
        total_storage_bytes: u64,
        total_burned: u64,
        lease_index: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
    }

    struct LeaseCreated has copy, drop {
        lease_id: 0x2::object::ID,
        owner: address,
        submission_id: 0x2::object::ID,
        walrus_blob_id: 0x1::string::String,
        capacity_bytes: u64,
        created_at_epoch: u64,
        expires_at_epoch: u64,
        lease_duration_epochs: u64,
        initial_payment: u64,
    }

    struct LeaseRenewed has copy, drop {
        lease_id: 0x2::object::ID,
        owner: address,
        submission_id: 0x2::object::ID,
        renewed_at_epoch: u64,
        extended_by_epochs: u64,
        old_expiry_epoch: u64,
        new_expiry_epoch: u64,
        payment_amount: u64,
        total_renewals: u64,
    }

    struct LeaseExpiring has copy, drop {
        lease_id: 0x2::object::ID,
        owner: address,
        submission_id: 0x2::object::ID,
        expires_at_epoch: u64,
        epochs_remaining: u64,
    }

    struct LeaseExpired has copy, drop {
        lease_id: 0x2::object::ID,
        owner: address,
        submission_id: 0x2::object::ID,
        expired_at_epoch: u64,
    }

    struct RegistryInitialized has copy, drop {
        registry_id: 0x2::object::ID,
    }

    public fun active_leases(arg0: &LeaseRegistry) : u64 {
        arg0.active_leases
    }

    public fun capacity_bytes(arg0: &StorageLease) : u64 {
        arg0.capacity_bytes
    }

    public fun check_lease_expiry(arg0: &mut StorageLease, arg1: &mut LeaseRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (v0 >= arg0.expires_at_epoch && !arg0.expiry_processed) {
            arg0.expiry_processed = true;
            let v1 = LeaseExpired{
                lease_id         : 0x2::object::uid_to_inner(&arg0.id),
                owner            : arg0.owner,
                submission_id    : arg0.submission_id,
                expired_at_epoch : v0,
            };
            0x2::event::emit<LeaseExpired>(v1);
            if (arg1.active_leases > 0) {
                arg1.active_leases = arg1.active_leases - 1;
                arg1.expired_leases = arg1.expired_leases + 1;
            };
        } else if (v0 + 30 >= arg0.expires_at_epoch && v0 < arg0.expires_at_epoch) {
            let v2 = LeaseExpiring{
                lease_id         : 0x2::object::uid_to_inner(&arg0.id),
                owner            : arg0.owner,
                submission_id    : arg0.submission_id,
                expires_at_epoch : arg0.expires_at_epoch,
                epochs_remaining : arg0.expires_at_epoch - v0,
            };
            0x2::event::emit<LeaseExpiring>(v2);
        };
    }

    public fun create_lease(arg0: &mut LeaseRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(arg5 >= 365 && arg5 <= 1095, 7005);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.lease_index, &arg1), 7007);
        let v2 = StorageLease{
            id                    : 0x2::object::new(arg6),
            owner                 : v1,
            submission_id         : arg1,
            walrus_blob_id        : arg2,
            walrus_deal_id        : arg3,
            capacity_bytes        : arg4,
            created_at_epoch      : v0,
            expires_at_epoch      : v0 + arg5,
            lease_duration_epochs : arg5,
            expiry_processed      : false,
            renewal_history       : 0x1::vector::empty<RenewalRecord>(),
            total_renewals        : 0,
            lease_price_per_epoch : 0,
            total_paid            : 0,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.lease_index, arg1, v3);
        arg0.total_leases = arg0.total_leases + 1;
        arg0.active_leases = arg0.active_leases + 1;
        arg0.total_storage_bytes = arg0.total_storage_bytes + arg4;
        let v4 = LeaseCreated{
            lease_id              : v3,
            owner                 : v1,
            submission_id         : arg1,
            walrus_blob_id        : arg2,
            capacity_bytes        : arg4,
            created_at_epoch      : v0,
            expires_at_epoch      : v0 + arg5,
            lease_duration_epochs : arg5,
            initial_payment       : 0,
        };
        0x2::event::emit<LeaseCreated>(v4);
        0x2::transfer::transfer<StorageLease>(v2, v1);
    }

    public fun epochs_until_expiry(arg0: &StorageLease, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::epoch(arg1);
        if (v0 >= arg0.expires_at_epoch) {
            0
        } else {
            arg0.expires_at_epoch - v0
        }
    }

    public fun expired_leases(arg0: &LeaseRegistry) : u64 {
        arg0.expired_leases
    }

    public fun expires_at_epoch(arg0: &StorageLease) : u64 {
        arg0.expires_at_epoch
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LeaseRegistry{
            id                  : 0x2::object::new(arg0),
            total_leases        : 0,
            active_leases       : 0,
            expired_leases      : 0,
            total_storage_bytes : 0,
            total_burned        : 0,
            lease_index         : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
        };
        let v1 = RegistryInitialized{registry_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<RegistryInitialized>(v1);
        0x2::transfer::share_object<LeaseRegistry>(v0);
    }

    public fun is_active(arg0: &StorageLease, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) < arg0.expires_at_epoch
    }

    public fun is_expiring_soon(arg0: &StorageLease, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::epoch(arg1);
        v0 + 30 >= arg0.expires_at_epoch && v0 < arg0.expires_at_epoch
    }

    public fun owner(arg0: &StorageLease) : address {
        arg0.owner
    }

    public fun renew_lease(arg0: &mut LeaseRegistry, arg1: &mut StorageLease, arg2: u64, arg3: 0x2::coin::Coin<0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::sonar_token::SONAR_TOKEN>, arg4: &mut 0x2::coin::TreasuryCap<0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::sonar_token::SONAR_TOKEN>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(arg1.owner == v1, 7004);
        assert!(arg2 >= 365 && arg2 <= 1095, 7005);
        let v2 = arg5 / 100000;
        assert!(0x2::coin::value<0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::sonar_token::SONAR_TOKEN>(&arg3) >= v2, 7003);
        0x2::balance::decrease_supply<0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::sonar_token::SONAR_TOKEN>(0x2::coin::supply_mut<0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::sonar_token::SONAR_TOKEN>(arg4), 0x2::coin::into_balance<0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::sonar_token::SONAR_TOKEN>(0x2::coin::split<0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::sonar_token::SONAR_TOKEN>(&mut arg3, v2, arg6)));
        if (0x2::coin::value<0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::sonar_token::SONAR_TOKEN>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::sonar_token::SONAR_TOKEN>>(arg3, v1);
        } else {
            0x2::coin::destroy_zero<0x1084073ffefdb80fac657daae2d60895fac976ab6b85196c0ce86bcbce51edf6::sonar_token::SONAR_TOKEN>(arg3);
        };
        let v3 = arg1.expires_at_epoch + arg2;
        let v4 = RenewalRecord{
            renewed_at_epoch   : v0,
            extended_by_epochs : arg2,
            new_expiry_epoch   : v3,
            payment_amount     : v2,
            renewed_by         : v1,
        };
        0x1::vector::push_back<RenewalRecord>(&mut arg1.renewal_history, v4);
        arg1.expires_at_epoch = v3;
        arg1.total_renewals = arg1.total_renewals + 1;
        arg1.total_paid = arg1.total_paid + v2;
        arg1.expiry_processed = false;
        arg0.total_burned = arg0.total_burned + v2;
        let v5 = LeaseRenewed{
            lease_id           : 0x2::object::uid_to_inner(&arg1.id),
            owner              : arg1.owner,
            submission_id      : arg1.submission_id,
            renewed_at_epoch   : v0,
            extended_by_epochs : arg2,
            old_expiry_epoch   : arg1.expires_at_epoch,
            new_expiry_epoch   : v3,
            payment_amount     : v2,
            total_renewals     : arg1.total_renewals,
        };
        0x2::event::emit<LeaseRenewed>(v5);
    }

    public fun submission_id(arg0: &StorageLease) : 0x2::object::ID {
        arg0.submission_id
    }

    public fun total_burned(arg0: &LeaseRegistry) : u64 {
        arg0.total_burned
    }

    public fun total_leases(arg0: &LeaseRegistry) : u64 {
        arg0.total_leases
    }

    public fun total_paid(arg0: &StorageLease) : u64 {
        arg0.total_paid
    }

    public fun total_renewals(arg0: &StorageLease) : u64 {
        arg0.total_renewals
    }

    public fun total_storage_bytes(arg0: &LeaseRegistry) : u64 {
        arg0.total_storage_bytes
    }

    public fun walrus_blob_id(arg0: &StorageLease) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    // decompiled from Move bytecode v6
}

