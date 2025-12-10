module 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::alo_labs_smart_waste_bin {
    public fun admin_activate_bin(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::admin_activate_bin(arg0, arg1, arg2);
    }

    public fun admin_create_waste_bin(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::admin_create_waste_bin(arg0, arg1, arg2, arg3, arg4);
    }

    public fun admin_destroy_bin(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::admin_destroy_bin(arg0, arg1, arg2);
    }

    public fun admin_freeze_bin(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::admin_freeze_bin(arg0, arg1, arg2);
    }

    public fun create_additional_admin_cap(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::create_additional_admin_cap(arg0, arg1, arg2, arg3), arg2);
    }

    public fun revoke_admin_cap(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg2: 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::revoke_admin_cap(arg0, arg1, arg2, arg3);
    }

    public fun admin_add_collector(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::add_collector_to_allowlist(arg0, arg1, arg2, arg3);
    }

    public fun admin_add_validator(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::add_validator_to_allowlist(arg0, arg1, arg2, arg3);
    }

    public fun admin_pause_system(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::pause_system(arg0, arg1, arg2);
    }

    public fun admin_remove_collector(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::remove_collector_from_allowlist(arg0, arg1, arg2, arg3);
    }

    public fun admin_remove_validator(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::remove_validator_from_allowlist(arg0, arg1, arg2, arg3);
    }

    public fun admin_unpause_system(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::unpause_system(arg0, arg1, arg2);
    }

    public fun cancel_escrow_contract(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract, arg1: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::cancel_escrow(arg0, arg1, arg2, arg3, arg4);
    }

    public fun cancel_subscription(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::subscription::cancel_subscription(arg0, arg1, arg2);
    }

    public fun collector_accept_job_with_escrow(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract, arg3: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::collector::accept_job_with_escrow(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun collector_accept_job_with_subscription(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg3: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::collector::accept_job_with_subscription(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun collector_confirm_pickup(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::collector::confirm_pickup(arg0, arg1, arg2, arg3);
    }

    public fun complete_workflow(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector, arg2: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany, arg3: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract, arg4: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg5: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg6: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::collector::accept_job_with_escrow(arg1, arg0, arg3, arg4, arg8, arg9);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::collector::confirm_pickup(arg1, arg0, arg8, arg9);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::validator::validate_dropoff_with_escrow(arg2, arg0, arg3, arg7, true, arg5, arg6, arg8, arg9);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::collector::complete_job(arg1);
    }

    public(friend) fun create_bin_with_escrow(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: address, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::create_bin(arg0, arg1, arg2, arg6);
        let v1 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::create_escrow(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(&v0), arg3, arg4, arg5, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_default_collector_reward(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_default_validator_reward(), arg6);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::link_escrow(&mut v0, 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(&v1), arg6);
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(v0, arg1);
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(v1, arg1);
    }

    public fun create_escrow_contract(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::create_escrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public fun create_escrow_for_pickup(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::create_escrow_for_pickup(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun create_open_escrow_for_pickup(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::create_open_escrow_for_pickup(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun create_subscription_for_bin(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::subscription::create_subscription(arg1, arg0, arg2, arg3, arg4), arg1);
    }

    public(friend) fun create_waste_bin(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::create_bin(arg0, arg1, arg2, arg3), arg1);
    }

    public fun get_bin_location(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject) : vector<u8> {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_location(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::create_admin_system(arg0);
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::UpgradeCap>(v1, 0x2::tx_context::sender(arg0));
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::share_system_config(v2);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::share_collector_allowlist(v3);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::share_validator_allowlist(v4);
    }

    public fun link_escrow_to_bin(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::link_escrow(arg0, arg1, arg2);
    }

    public fun link_subscription_to_bin(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::link_subscription(arg0, arg1, arg2);
    }

    public fun register_collector(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::collector::register_collector(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun register_validator_company(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::validator::register_validator(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun release_escrow_payment(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract, arg1: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::release_payment(arg0, arg1, arg2, arg3, arg4);
    }

    public fun trigger_bin_full_event(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::trigger_bin_full(arg0, arg1, arg2, arg3);
    }

    public fun unlink_escrow_from_bin(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg1: &0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::unlink_escrow(arg0, arg1);
    }

    public fun unlink_subscription_from_bin(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg1: &0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::unlink_subscription(arg0, arg1);
    }

    public fun update_bin_location(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::update_location(arg0, arg1, arg2, arg3);
    }

    public fun validator_pause(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany, arg1: &0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::validator::pause_validator(arg0, arg1);
    }

    public fun validator_resume(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany, arg1: &0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::validator::resume_validator(arg0, arg1);
    }

    public fun validator_validate_dropoff_with_escrow(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract, arg3: address, arg4: bool, arg5: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg6: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::validator::validate_dropoff_with_escrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun validator_validate_dropoff_with_subscription(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg3: bool, arg4: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg5: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::validator::validate_dropoff_with_subscription(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

