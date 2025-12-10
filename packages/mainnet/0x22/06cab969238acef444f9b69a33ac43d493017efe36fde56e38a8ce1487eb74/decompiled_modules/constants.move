module 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants {
    public fun bin_status_collected() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::BinStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::bin_status_collected()
    }

    public fun bin_status_empty() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::BinStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::bin_status_empty()
    }

    public fun bin_status_error() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::BinStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::bin_status_error()
    }

    public fun bin_status_full() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::BinStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::bin_status_full()
    }

    public fun bin_status_to_u8(arg0: 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::BinStatus) : u8 {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::bin_status_to_u8(arg0)
    }

    public fun bin_status_validated() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::BinStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::bin_status_validated()
    }

    public fun collector_status_assigned() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::collector_status_assigned()
    }

    public fun collector_status_available() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::collector_status_available()
    }

    public fun collector_status_completed() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::collector_status_completed()
    }

    public fun collector_status_in_transit() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::collector_status_in_transit()
    }

    public fun escrow_status_cancelled() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::escrow_status_cancelled()
    }

    public fun escrow_status_pending() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::escrow_status_pending()
    }

    public fun escrow_status_released() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::escrow_status_released()
    }

    public fun get_collector_reward_per_pickup() : u64 {
        1000000000
    }

    public fun get_default_bin_fee() : u64 {
        5000000000
    }

    public fun get_default_collector_reward() : u64 {
        50000000000
    }

    public fun get_default_validator_reward() : u64 {
        10000000000
    }

    public fun get_error_already_assigned() : u64 {
        7
    }

    public fun get_error_already_released() : u64 {
        8
    }

    public fun get_error_insufficient_funds() : u64 {
        6
    }

    public fun get_error_invalid_amount() : u64 {
        9
    }

    public fun get_error_invalid_device_id() : u64 {
        12
    }

    public fun get_error_invalid_state() : u64 {
        3
    }

    public fun get_error_max_pickups_exceeded() : u64 {
        16
    }

    public fun get_error_no_payment() : u64 {
        13
    }

    public fun get_error_not_allowlisted() : u64 {
        2
    }

    public fun get_error_not_authorized() : u64 {
        1
    }

    public fun get_error_subscription_expired() : u64 {
        14
    }

    public fun get_error_subscription_insufficient_balance() : u64 {
        15
    }

    public fun get_error_system_paused() : u64 {
        10
    }

    public fun get_escrow_refund_grace_ms() : u64 {
        86400000
    }

    public fun get_hardware_type_esp32() : vector<u8> {
        b"ESP32"
    }

    public fun get_max_device_id_length() : u64 {
        256
    }

    public fun get_max_pickups_per_month() : u64 {
        5
    }

    public fun get_min_device_id_length() : u64 {
        1
    }

    public fun get_monthly_subscription_amount() : u64 {
        20000000000
    }

    public fun get_pay_per_pickup_amount() : u64 {
        5000000000
    }

    public fun get_pay_per_pickup_collector_share() : u64 {
        1000000000
    }

    public fun get_pay_per_pickup_system_share() : u64 {
        3000000000
    }

    public fun get_pay_per_pickup_validator_share() : u64 {
        1000000000
    }

    public fun get_subscription_duration_ms() : u64 {
        2592000000
    }

    public fun get_subscription_refund_grace_ms() : u64 {
        86400000
    }

    public fun get_system_cost_per_pickup() : u64 {
        2000000000
    }

    public fun get_system_treasury_address() : address {
        @0x1544643ecd21f2f5e79daf5f5feeb117d3c0006c677bc3fe834c985ab4c7c0f1
    }

    public fun get_validator_reward_per_pickup() : u64 {
        1000000000
    }

    public fun is_escrow_pending(arg0: 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowStatus) : bool {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::is_escrow_pending(arg0)
    }

    public fun is_escrow_released(arg0: 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowStatus) : bool {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::is_escrow_released(arg0)
    }

    public fun is_valid_device_id(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        v0 >= get_min_device_id_length() && v0 <= get_max_device_id_length()
    }

    public fun u8_to_bin_status(arg0: u8) : 0x1::option::Option<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::BinStatus> {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::u8_to_bin_status(arg0)
    }

    public fun validator_status_active() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::validator_status_active()
    }

    public fun validator_status_paused() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::validator_status_paused()
    }

    public fun validator_status_suspended() : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::validator_status_suspended()
    }

    // decompiled from Move bytecode v6
}

