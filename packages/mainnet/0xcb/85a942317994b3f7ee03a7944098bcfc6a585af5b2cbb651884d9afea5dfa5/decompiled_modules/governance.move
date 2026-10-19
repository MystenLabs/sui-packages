module 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::governance {
    struct AdminVault<phantom T0> has key {
        id: 0x2::object::UID,
        package_version: u64,
        owner: address,
        cap: 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::AdminCap<T0>,
        due: u64,
        parameters: vector<u64>,
    }

    struct UpgradeVault has key {
        id: 0x2::object::UID,
        package_version: u64,
        owner: address,
        cap: 0x2::package::UpgradeCap,
        due: u64,
        digest: vector<u8>,
        policy: u8,
    }

    struct Proposed has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        due: u64,
        kind: u8,
        payload: vector<u8>,
    }

    struct Executed has copy, drop {
        vault: 0x2::object::ID,
        kind: u8,
    }

    public fun authorize_upgrade(arg0: &mut UpgradeVault, arg1: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        assert!(arg0.package_version == 1, 900);
        assert!(arg0.due > 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.due, 2);
        arg0.due = 0;
        arg0.digest = b"";
        0x2::package::authorize_upgrade(&mut arg0.cap, arg0.policy, arg0.digest)
    }

    public fun commit_upgrade(arg0: &mut UpgradeVault, arg1: 0x2::package::UpgradeReceipt) {
        assert!(arg0.package_version == 1, 900);
        0x2::package::commit_upgrade(&mut arg0.cap, arg1);
        let v0 = Executed{
            vault : 0x2::object::id<UpgradeVault>(arg0),
            kind  : 2,
        };
        0x2::event::emit<Executed>(v0);
    }

    public fun withdraw_dev_fees<T0>(arg0: &AdminVault<T0>, arg1: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::withdraw_dev_fees<T0>(&arg0.cap, arg1, arg2, arg3);
    }

    public fun acknowledge_security<T0>(arg0: &AdminVault<T0>, arg1: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::State<T0>, arg2: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::acknowledge_security<T0>(&arg0.cap, arg1, arg2);
    }

    public fun approve_emergency_frame<T0>(arg0: &AdminVault<T0>, arg1: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::State<T0>, arg2: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg3: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::Frame, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u64>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg9) == arg0.owner, 1);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::approve_emergency_frame<T0>(&arg0.cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun approve_emergency_retirement<T0>(arg0: &AdminVault<T0>, arg1: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::State<T0>, arg2: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 1);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::approve_emergency_retirement<T0>(&arg0.cap, arg1, arg2, arg3, arg4, arg5);
    }

    public fun begin_provision<T0>(arg0: &AdminVault<T0>, arg1: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::State<T0>, arg2: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::begin_provision<T0>(&arg0.cap, arg1, arg2, arg3);
    }

    public fun cancel_parameters<T0>(arg0: &mut AdminVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.due = 0;
        arg0.parameters = vector[];
        let v0 = Executed{
            vault : 0x2::object::id<AdminVault<T0>>(arg0),
            kind  : 1,
        };
        0x2::event::emit<Executed>(v0);
    }

    public fun cancel_upgrade(arg0: &mut UpgradeVault, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.due = 0;
        arg0.digest = b"";
        let v0 = Executed{
            vault : 0x2::object::id<UpgradeVault>(arg0),
            kind  : 3,
        };
        0x2::event::emit<Executed>(v0);
    }

    public fun custody_admin<T0>(arg0: 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::AdminCap<T0>, arg1: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 1);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::engine_admin<T0>(&arg0, arg1);
        let v0 = AdminVault<T0>{
            id              : 0x2::object::new(arg3),
            package_version : 1,
            owner           : arg2,
            cap             : arg0,
            due             : 0,
            parameters      : vector[],
        };
        0x2::transfer::share_object<AdminVault<T0>>(v0);
    }

    public fun custody_upgrade(arg0: 0x2::package::UpgradeCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 1);
        let v0 = UpgradeVault{
            id              : 0x2::object::new(arg2),
            package_version : 1,
            owner           : arg1,
            cap             : arg0,
            due             : 0,
            digest          : b"",
            policy          : 0,
        };
        0x2::transfer::share_object<UpgradeVault>(v0);
    }

    public fun emergency_exit_step<T0>(arg0: &AdminVault<T0>, arg1: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::State<T0>, arg2: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg3: vector<u8>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::emergency_exit_step<T0>(&arg0.cap, arg1, arg2, arg3, arg4, arg5);
    }

    public fun execute_parameters<T0>(arg0: &mut AdminVault<T0>, arg1: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(arg0.due > 0 && 0x2::clock::timestamp_ms(arg2) >= arg0.due, 2);
        let v0 = arg0.parameters;
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::engine_dividend_config<T0>(&arg0.cap, arg1, *0x1::vector::borrow<u64>(&v0, 0), *0x1::vector::borrow<u64>(&v0, 1), arg3);
        arg0.due = 0;
        arg0.parameters = vector[];
        let v1 = Executed{
            vault : 0x2::object::id<AdminVault<T0>>(arg0),
            kind  : 0,
        };
        0x2::event::emit<Executed>(v1);
    }

    public fun migrate_admin<T0>(arg0: &mut AdminVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner && arg0.package_version < 1, 900);
        arg0.package_version = 1;
    }

    public fun migrate_engine<T0>(arg0: &AdminVault<T0>, arg1: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::State<T0>, arg2: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1 && 0x2::tx_context::sender(arg3) == arg0.owner, 900);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::migrate_package<T0>(&arg0.cap, arg1, arg2);
    }

    public fun migrate_exchange<T0>(arg0: &AdminVault<T0>, arg1: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1 && 0x2::tx_context::sender(arg2) == arg0.owner, 900);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::migrate_package<T0>(&arg0.cap, arg1);
    }

    public fun migrate_upgrade(arg0: &mut UpgradeVault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner && arg0.package_version < 1, 900);
        arg0.package_version = 1;
    }

    public fun next_generation<T0>(arg0: &AdminVault<T0>, arg1: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::State<T0>, arg2: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 1);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::next_generation<T0>(&arg0.cap, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun propose_keys<T0>(arg0: &AdminVault<T0>, arg1: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::State<T0>, arg2: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 1);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::propose_keys<T0>(&arg0.cap, arg1, arg2, arg3, arg4, arg5);
    }

    public fun propose_parameters<T0>(arg0: &mut AdminVault<T0>, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(0x1::vector::length<u64>(&arg1) == 2, 3);
        arg0.parameters = arg1;
        arg0.due = 0x2::clock::timestamp_ms(arg2) + 3600000;
        let v0 = Proposed{
            vault   : 0x2::object::id<AdminVault<T0>>(arg0),
            owner   : arg0.owner,
            due     : arg0.due,
            kind    : 0,
            payload : 0x1::bcs::to_bytes<vector<u64>>(&arg1),
        };
        0x2::event::emit<Proposed>(v0);
    }

    public fun propose_upgrade(arg0: &mut UpgradeVault, arg1: vector<u8>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        let v0 = if (0x1::vector::length<u8>(&arg1) == 32) {
            if (arg2 == 0) {
                true
            } else if (arg2 == 128) {
                true
            } else {
                arg2 == 192
            }
        } else {
            false
        };
        assert!(v0, 3);
        arg0.digest = arg1;
        arg0.policy = arg2;
        arg0.due = 0x2::clock::timestamp_ms(arg3) + 3600000;
        let v1 = Proposed{
            vault   : 0x2::object::id<UpgradeVault>(arg0),
            owner   : arg0.owner,
            due     : arg0.due,
            kind    : 2,
            payload : arg1,
        };
        0x2::event::emit<Proposed>(v1);
    }

    public fun resume<T0>(arg0: &AdminVault<T0>, arg1: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::State<T0>, arg2: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.package_version == 1, 900);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::offchain_engine::resume<T0>(&arg0.cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

