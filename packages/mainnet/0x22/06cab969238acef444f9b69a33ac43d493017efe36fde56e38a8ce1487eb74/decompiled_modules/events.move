module 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events {
    struct BinCreatedEvent has copy, drop {
        bin_id: 0x2::object::ID,
        device_id: vector<u8>,
        owner: address,
        bin_user: 0x1::option::Option<address>,
        location: vector<u8>,
    }

    struct BinStatusChangedEvent has copy, drop {
        bin_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
        timestamp: u64,
        location: vector<u8>,
    }

    struct BinFullEvent has copy, drop {
        bin_id: 0x2::object::ID,
        device_id: vector<u8>,
        timestamp: u64,
        location: vector<u8>,
    }

    struct BinLocationUpdatedEvent has copy, drop {
        bin_id: 0x2::object::ID,
        location: vector<u8>,
        timestamp: u64,
    }

    struct BinDestroyedEvent has copy, drop {
        bin_id: 0x2::object::ID,
        device_id: vector<u8>,
        owner: address,
        destroyed_by: address,
        timestamp: u64,
    }

    struct EscrowLinkedEvent has copy, drop {
        bin_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        bin_user: address,
        location: vector<u8>,
    }

    struct SubscriptionLinkedEvent has copy, drop {
        bin_id: 0x2::object::ID,
        subscription_id: 0x2::object::ID,
        bin_user: address,
        location: vector<u8>,
    }

    struct CollectorRegisteredEvent has copy, drop {
        collector_id: 0x2::object::ID,
        collector_address: address,
        region: vector<u8>,
    }

    struct JobAcceptedEvent has copy, drop {
        collector_id: 0x2::object::ID,
        bin_id: 0x2::object::ID,
        timestamp: u64,
        location: vector<u8>,
    }

    struct PickupConfirmedEvent has copy, drop {
        collector_id: 0x2::object::ID,
        bin_id: 0x2::object::ID,
        timestamp: u64,
        location: vector<u8>,
    }

    struct ValidatorRegisteredEvent has copy, drop {
        validator_id: 0x2::object::ID,
        validator_address: address,
    }

    struct DropOffValidatedEvent has copy, drop {
        validator_id: 0x2::object::ID,
        bin_id: 0x2::object::ID,
        is_valid: bool,
        timestamp: u64,
        location: vector<u8>,
    }

    struct EscrowCreatedEvent has copy, drop {
        escrow_id: 0x2::object::ID,
        bin_id: 0x2::object::ID,
        amount: u64,
        collector_address: 0x1::option::Option<address>,
        validator_address: 0x1::option::Option<address>,
    }

    struct PaymentReleasedEvent has copy, drop {
        escrow_id: 0x2::object::ID,
        bin_id: 0x2::object::ID,
        collector_amount: u64,
        validator_amount: u64,
        timestamp: u64,
    }

    struct SubscriptionCreatedEvent has copy, drop {
        subscription_id: 0x2::object::ID,
        bin_id: 0x2::object::ID,
        owner: address,
        start_timestamp: u64,
        expiry_timestamp: u64,
        initial_balance: u64,
    }

    struct SubscriptionExpiredEvent has copy, drop {
        subscription_id: 0x2::object::ID,
        bin_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct PickupCostDeductedEvent has copy, drop {
        subscription_id: 0x2::object::ID,
        bin_id: 0x2::object::ID,
        cost: u64,
        remaining_balance: u64,
        pickups_used: u64,
        timestamp: u64,
    }

    struct SubscriptionLowBalanceEvent has copy, drop {
        subscription_id: 0x2::object::ID,
        bin_id: 0x2::object::ID,
        remaining_balance: u64,
        required_balance: u64,
        timestamp: u64,
    }

    struct SubscriptionMaxPickupsReachedEvent has copy, drop {
        subscription_id: 0x2::object::ID,
        bin_id: 0x2::object::ID,
        pickups_used: u64,
        max_pickups: u64,
        timestamp: u64,
    }

    struct SubscriptionPaymentInsufficientEvent has copy, drop {
        subscription_id: 0x2::object::ID,
        bin_id: 0x2::object::ID,
        current_balance: u64,
        required_balance: u64,
        timestamp: u64,
    }

    struct ErrorEvent has copy, drop {
        error_code: u64,
        error_message: vector<u8>,
        context: vector<u8>,
        timestamp: u64,
    }

    struct SystemPausedEvent has copy, drop {
        is_paused: bool,
        timestamp: u64,
    }

    struct AllowlistUpdatedEvent has copy, drop {
        entity_type: vector<u8>,
        entity_address: address,
        is_allowed: bool,
        timestamp: u64,
    }

    struct AdminCapCreatedEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        admin_address: address,
    }

    struct AdminCapRevokedEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        revoked_admin: address,
        revoked_by: address,
        timestamp: u64,
    }

    struct SystemConfigUpdatedEvent has copy, drop {
        is_paused: bool,
        timestamp: u64,
    }

    public fun emit_admin_cap_created(arg0: 0x2::object::ID, arg1: address) {
        let v0 = AdminCapCreatedEvent{
            admin_cap_id  : arg0,
            admin_address : arg1,
        };
        0x2::event::emit<AdminCapCreatedEvent>(v0);
    }

    public fun emit_admin_cap_revoked(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = AdminCapRevokedEvent{
            admin_cap_id  : arg0,
            revoked_admin : arg1,
            revoked_by    : arg2,
            timestamp     : arg3,
        };
        0x2::event::emit<AdminCapRevokedEvent>(v0);
    }

    public fun emit_allowlist_updated(arg0: vector<u8>, arg1: address, arg2: bool, arg3: u64) {
        let v0 = AllowlistUpdatedEvent{
            entity_type    : arg0,
            entity_address : arg1,
            is_allowed     : arg2,
            timestamp      : arg3,
        };
        0x2::event::emit<AllowlistUpdatedEvent>(v0);
    }

    public fun emit_bin_created(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: address, arg3: 0x1::option::Option<address>, arg4: vector<u8>) {
        let v0 = BinCreatedEvent{
            bin_id    : arg0,
            device_id : arg1,
            owner     : arg2,
            bin_user  : arg3,
            location  : arg4,
        };
        0x2::event::emit<BinCreatedEvent>(v0);
    }

    public fun emit_bin_destroyed(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: address, arg3: address, arg4: u64) {
        let v0 = BinDestroyedEvent{
            bin_id       : arg0,
            device_id    : arg1,
            owner        : arg2,
            destroyed_by : arg3,
            timestamp    : arg4,
        };
        0x2::event::emit<BinDestroyedEvent>(v0);
    }

    public fun emit_bin_full(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: vector<u8>) {
        let v0 = BinFullEvent{
            bin_id    : arg0,
            device_id : arg1,
            timestamp : arg2,
            location  : arg3,
        };
        0x2::event::emit<BinFullEvent>(v0);
    }

    public fun emit_bin_location_updated(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = BinLocationUpdatedEvent{
            bin_id    : arg0,
            location  : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<BinLocationUpdatedEvent>(v0);
    }

    public fun emit_bin_status_changed(arg0: 0x2::object::ID, arg1: u8, arg2: u8, arg3: u64, arg4: vector<u8>) {
        let v0 = BinStatusChangedEvent{
            bin_id     : arg0,
            old_status : arg1,
            new_status : arg2,
            timestamp  : arg3,
            location   : arg4,
        };
        0x2::event::emit<BinStatusChangedEvent>(v0);
    }

    public fun emit_collector_registered(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>) {
        let v0 = CollectorRegisteredEvent{
            collector_id      : arg0,
            collector_address : arg1,
            region            : arg2,
        };
        0x2::event::emit<CollectorRegisteredEvent>(v0);
    }

    public fun emit_dropoff_validated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: vector<u8>) {
        let v0 = DropOffValidatedEvent{
            validator_id : arg0,
            bin_id       : arg1,
            is_valid     : arg2,
            timestamp    : arg3,
            location     : arg4,
        };
        0x2::event::emit<DropOffValidatedEvent>(v0);
    }

    public fun emit_error(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        let v0 = ErrorEvent{
            error_code    : arg0,
            error_message : arg1,
            context       : arg2,
            timestamp     : arg3,
        };
        0x2::event::emit<ErrorEvent>(v0);
    }

    public fun emit_escrow_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<address>) {
        let v0 = EscrowCreatedEvent{
            escrow_id         : arg0,
            bin_id            : arg1,
            amount            : arg2,
            collector_address : arg3,
            validator_address : arg4,
        };
        0x2::event::emit<EscrowCreatedEvent>(v0);
    }

    public fun emit_escrow_linked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>) {
        let v0 = EscrowLinkedEvent{
            bin_id    : arg0,
            escrow_id : arg1,
            bin_user  : arg2,
            location  : arg3,
        };
        0x2::event::emit<EscrowLinkedEvent>(v0);
    }

    public fun emit_job_accepted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>) {
        let v0 = JobAcceptedEvent{
            collector_id : arg0,
            bin_id       : arg1,
            timestamp    : arg2,
            location     : arg3,
        };
        0x2::event::emit<JobAcceptedEvent>(v0);
    }

    public fun emit_payment_released(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PaymentReleasedEvent{
            escrow_id        : arg0,
            bin_id           : arg1,
            collector_amount : arg2,
            validator_amount : arg3,
            timestamp        : arg4,
        };
        0x2::event::emit<PaymentReleasedEvent>(v0);
    }

    public fun emit_pickup_confirmed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>) {
        let v0 = PickupConfirmedEvent{
            collector_id : arg0,
            bin_id       : arg1,
            timestamp    : arg2,
            location     : arg3,
        };
        0x2::event::emit<PickupConfirmedEvent>(v0);
    }

    public fun emit_pickup_cost_deducted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = PickupCostDeductedEvent{
            subscription_id   : arg0,
            bin_id            : arg1,
            cost              : arg2,
            remaining_balance : arg3,
            pickups_used      : arg4,
            timestamp         : arg5,
        };
        0x2::event::emit<PickupCostDeductedEvent>(v0);
    }

    public fun emit_subscription_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SubscriptionCreatedEvent{
            subscription_id  : arg0,
            bin_id           : arg1,
            owner            : arg2,
            start_timestamp  : arg3,
            expiry_timestamp : arg4,
            initial_balance  : arg5,
        };
        0x2::event::emit<SubscriptionCreatedEvent>(v0);
    }

    public fun emit_subscription_expired(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = SubscriptionExpiredEvent{
            subscription_id : arg0,
            bin_id          : arg1,
            timestamp       : arg2,
        };
        0x2::event::emit<SubscriptionExpiredEvent>(v0);
    }

    public fun emit_subscription_linked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>) {
        let v0 = SubscriptionLinkedEvent{
            bin_id          : arg0,
            subscription_id : arg1,
            bin_user        : arg2,
            location        : arg3,
        };
        0x2::event::emit<SubscriptionLinkedEvent>(v0);
    }

    public fun emit_subscription_low_balance(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = SubscriptionLowBalanceEvent{
            subscription_id   : arg0,
            bin_id            : arg1,
            remaining_balance : arg2,
            required_balance  : arg3,
            timestamp         : arg4,
        };
        0x2::event::emit<SubscriptionLowBalanceEvent>(v0);
    }

    public fun emit_subscription_max_pickups_reached(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = SubscriptionMaxPickupsReachedEvent{
            subscription_id : arg0,
            bin_id          : arg1,
            pickups_used    : arg2,
            max_pickups     : arg3,
            timestamp       : arg4,
        };
        0x2::event::emit<SubscriptionMaxPickupsReachedEvent>(v0);
    }

    public fun emit_subscription_payment_insufficient(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = SubscriptionPaymentInsufficientEvent{
            subscription_id  : arg0,
            bin_id           : arg1,
            current_balance  : arg2,
            required_balance : arg3,
            timestamp        : arg4,
        };
        0x2::event::emit<SubscriptionPaymentInsufficientEvent>(v0);
    }

    public fun emit_system_config_updated(arg0: bool, arg1: u64) {
        let v0 = SystemConfigUpdatedEvent{
            is_paused : arg0,
            timestamp : arg1,
        };
        0x2::event::emit<SystemConfigUpdatedEvent>(v0);
    }

    public fun emit_system_paused(arg0: bool, arg1: u64) {
        let v0 = SystemPausedEvent{
            is_paused : arg0,
            timestamp : arg1,
        };
        0x2::event::emit<SystemPausedEvent>(v0);
    }

    public fun emit_validator_registered(arg0: 0x2::object::ID, arg1: address) {
        let v0 = ValidatorRegisteredEvent{
            validator_id      : arg0,
            validator_address : arg1,
        };
        0x2::event::emit<ValidatorRegisteredEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

