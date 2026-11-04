module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot {
    struct SnapshotAbility has drop {
        dummy_field: bool,
    }

    struct SnapshotCap<phantom T0> has key {
        id: 0x2::object::UID,
        timestamp_start: u64,
        total_supply: u64,
        tokens_counted: 0x2::table::Table<0x2::object::ID, u64>,
        addresses: 0x2::table::Table<address, u64>,
        counted_sum: u64,
        versioning: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::Versioning,
    }

    struct Snapshot<phantom T0> has store, key {
        id: 0x2::object::UID,
        timestamp_start: u64,
        timestamp_end: u64,
        tokens_counted: 0x2::table::Table<0x2::object::ID, u64>,
        addresses: 0x2::table::Table<address, u64>,
        total_supply: u64,
    }

    struct SnapshotCapturingStarted<phantom T0> has copy, drop {
        snapshot_cap_id: 0x2::object::ID,
        timestamp_start: u64,
        total_supply: u64,
        sender: address,
    }

    struct SnapshotCapturingFinished<phantom T0> has copy, drop {
        snapshot_cap_id: 0x2::object::ID,
        snapshot_id: 0x2::object::ID,
        timestamp_start: u64,
        total_supply: u64,
        sender: address,
    }

    struct SnapshotCapturingCanceled<phantom T0> has copy, drop {
        snapshot_cap_id: 0x2::object::ID,
        timestamp_start: u64,
        total_supply: u64,
        sender: address,
    }

    public fun transfer<T0, T1: drop>(arg0: SnapshotCap<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::ControlledTreasury<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::assert_valid_version<T0>(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x1::option::borrow<0x1::type_name::TypeName>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::pause_state<T0>(arg1)) == &v0, 2);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::has_ability<T0, T1, SnapshotAbility>(arg1, 0x2::tx_context::sender(arg3)), 1);
        0x2::transfer::transfer<SnapshotCap<T0>>(arg0, arg2);
    }

    public fun versioning<T0>(arg0: &SnapshotCap<T0>) : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::Versioning {
        arg0.versioning
    }

    public fun total_supply<T0>(arg0: &Snapshot<T0>) : u64 {
        arg0.total_supply
    }

    public fun address_balance<T0>(arg0: &Snapshot<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.addresses, arg1)
    }

    public fun addresses_length<T0>(arg0: &Snapshot<T0>) : u64 {
        0x2::table::length<address, u64>(&arg0.addresses)
    }

    public fun cancel_snapshot<T0, T1: drop>(arg0: SnapshotCap<T0>, arg1: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::ControlledTreasury<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::table::Table<0x2::object::ID, u64>, 0x2::table::Table<address, u64>, u64) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::has_ability<T0, T1, SnapshotAbility>(arg1, 0x2::tx_context::sender(arg3)), 1);
        let SnapshotCap {
            id              : v0,
            timestamp_start : v1,
            total_supply    : v2,
            tokens_counted  : v3,
            addresses       : v4,
            counted_sum     : v5,
            versioning      : _,
        } = arg0;
        let v7 = v0;
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::pause_token::resume_token<T0, T1>(arg1, arg2, arg3);
        let v8 = SnapshotCapturingCanceled<T0>{
            snapshot_cap_id : 0x2::object::uid_to_inner(&v7),
            timestamp_start : v1,
            total_supply    : v2,
            sender          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SnapshotCapturingCanceled<T0>>(v8);
        0x2::object::delete(v7);
        (v1, v2, v3, v4, v5)
    }

    fun count_internal<T0>(arg0: &mut SnapshotCap<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.tokens_counted, arg1, arg3);
        if (0x2::table::contains<address, u64>(&arg0.addresses, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.addresses, arg2);
            *v0 = *v0 + arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.addresses, arg2, arg3);
        };
        arg0.counted_sum = arg0.counted_sum + arg3;
    }

    public fun count_timelock<T0>(arg0: &mut SnapshotCap<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::Timelock<T0>) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg0.versioning);
        count_internal<T0>(arg0, 0x2::object::id<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::Timelock<T0>>(arg1), 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::owner<T0>(arg1), 0x2::balance::value<T0>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::left_balance<T0>(arg1)));
    }

    public fun count_token<T0>(arg0: &mut SnapshotCap<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg0.versioning);
        count_internal<T0>(arg0, 0x2::object::id<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>>(arg1), 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::token_owner<T0>(arg1), 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::token_value<T0>(arg1));
    }

    public fun finish_snapshot<T0, T1: drop>(arg0: SnapshotCap<T0>, arg1: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::ControlledTreasury<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Snapshot<T0> {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::has_ability<T0, T1, SnapshotAbility>(arg1, 0x2::tx_context::sender(arg4)), 1);
        let SnapshotCap {
            id              : v0,
            timestamp_start : v1,
            total_supply    : v2,
            tokens_counted  : v3,
            addresses       : v4,
            counted_sum     : v5,
            versioning      : _,
        } = arg0;
        let v7 = v0;
        assert!(v2 == v5, 0);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::total_supply<T0>(arg1) == v2, 3);
        let v8 = 0x2::object::new(arg4);
        let v9 = SnapshotCapturingFinished<T0>{
            snapshot_cap_id : 0x2::object::uid_to_inner(&v7),
            snapshot_id     : 0x2::object::uid_to_inner(&v8),
            timestamp_start : v1,
            total_supply    : v2,
            sender          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SnapshotCapturingFinished<T0>>(v9);
        0x2::object::delete(v7);
        let v10 = Snapshot<T0>{
            id              : v8,
            timestamp_start : v1,
            timestamp_end   : 0x2::clock::timestamp_ms(arg3),
            tokens_counted  : v3,
            addresses       : v4,
            total_supply    : v2,
        };
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::pause_token::resume_token<T0, T1>(arg1, arg2, arg4);
        v10
    }

    public fun is_valid_version<T0>(arg0: &SnapshotCap<T0>) : bool {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::is_current_version_valid(&arg0.versioning)
    }

    public fun return_to_pauser<T0, T1: drop>(arg0: SnapshotCap<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::ControlledTreasury<T0>, arg2: address) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::assert_valid_version<T0>(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x1::option::borrow<0x1::type_name::TypeName>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::pause_state<T0>(arg1)) == &v0, 2);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::has_ability<T0, T1, SnapshotAbility>(arg1, arg2), 1);
        0x2::transfer::transfer<SnapshotCap<T0>>(arg0, arg2);
    }

    public fun start_snapshot<T0>(arg0: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::ControlledTreasury<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : SnapshotCap<T0> {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, SnapshotAbility>(&arg0), 1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::pause_token::pause_token<T0>(arg0, arg1, arg2, arg4);
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::total_supply<T0>(arg1);
        let v3 = SnapshotCapturingStarted<T0>{
            snapshot_cap_id : 0x2::object::uid_to_inner(&v0),
            timestamp_start : v1,
            total_supply    : v2,
            sender          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SnapshotCapturingStarted<T0>>(v3);
        SnapshotCap<T0>{
            id              : v0,
            timestamp_start : v1,
            total_supply    : v2,
            tokens_counted  : 0x2::table::new<0x2::object::ID, u64>(arg4),
            addresses       : 0x2::table::new<address, u64>(arg4),
            counted_sum     : 0,
            versioning      : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::versioning<T0>(&arg0),
        }
    }

    public fun transfer_to_sender<T0>(arg0: SnapshotCap<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<SnapshotCap<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

