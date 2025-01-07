module 0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::bnusd_crosschain {
    struct REGISTER_WITNESS has drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun configure(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>, arg2: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg3: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg4: 0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::WitnessCarrier<REGISTER_WITNESS>, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::configure<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR, REGISTER_WITNESS>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun cross_transfer(arg0: &mut 0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>, arg5: 0x1::string::String, arg6: 0x1::option::Option<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::cross_transfer<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun enforce_version(arg0: &0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>) {
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::enforce_version<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0, 1);
    }

    entry fun execute_call(arg0: &mut 0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>, arg1: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg2: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::execute_call<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun execute_force_rollback(arg0: &0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>, arg1: &AdminCap, arg2: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::execute_force_rollback<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun execute_rollback(arg0: &mut 0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::execute_rollback<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0, arg1, arg2, arg3);
    }

    public fun get_config_id(arg0: &0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>) : 0x2::object::ID {
        enforce_version(arg0);
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::get_config_id<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0)
    }

    entry fun get_execute_call_params(arg0: &0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>) : (0x2::object::ID, 0x2::object::ID) {
        enforce_version(arg0);
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::get_execute_call_params<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0)
    }

    entry fun get_execute_params(arg0: &0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>, arg1: vector<u8>) : 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::ExecuteParams {
        enforce_version(arg0);
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::get_execute_params<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0, arg1)
    }

    public(friend) fun get_idcap(arg0: &0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>) : &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap {
        enforce_version(arg0);
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::get_idcap<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0)
    }

    entry fun get_rollback_params(arg0: &0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>, arg1: vector<u8>) : 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::ExecuteParams {
        enforce_version(arg0);
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::get_rollback_params<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0, arg1)
    }

    public fun get_xcall_id(arg0: &0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>) : 0x2::object::ID {
        enforce_version(arg0);
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::get_xcall_id<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0)
    }

    public fun get_xcall_manager_id(arg0: &0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>) : 0x2::object::ID {
        enforce_version(arg0);
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::get_xcall_manager_id<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0)
    }

    entry fun migrate(arg0: &mut 0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::Config<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>, arg1: &0x2::package::UpgradeCap) {
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::migrate<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(arg0, arg1, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = REGISTER_WITNESS{dummy_field: false};
        0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain::transfer_witness<REGISTER_WITNESS>(v1, arg0);
    }

    // decompiled from Move bytecode v6
}

