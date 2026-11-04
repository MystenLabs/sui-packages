module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::dividends {
    struct DividendsAbility has drop {
        dummy_field: bool,
    }

    struct Dividends<phantom T0> has key {
        id: 0x2::object::UID,
        funder: address,
        snapshot_id: 0x2::object::ID,
        total_funds: u64,
        unused_funds: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<address, u64>,
        fully_claimed: 0x1::option::Option<0x2::table::Table<address, bool>>,
        versioning: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::Versioning,
    }

    struct Funded<phantom T0, phantom T1> has copy, drop {
        dividends_id: 0x2::object::ID,
        funder: address,
        amount: u64,
        snapshot_id: 0x2::object::ID,
    }

    struct Claimed<phantom T0, phantom T1> has copy, drop {
        dividends_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
        snapshot_id: 0x2::object::ID,
    }

    struct RemainderRetrieved<phantom T0, phantom T1> has copy, drop {
        dividends_id: 0x2::object::ID,
        funder: address,
        amount_retrieved: u64,
        new_total_funds: u64,
        snapshot_id: 0x2::object::ID,
    }

    public fun versioning<T0>(arg0: &Dividends<T0>) : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::Versioning {
        arg0.versioning
    }

    public fun add_fully_claimed<T0, T1>(arg0: &mut Dividends<T1>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg0.versioning);
        assert!(0x2::tx_context::sender(arg3) == arg0.funder, 5);
        assert!(arg0.snapshot_id == 0x2::object::id<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>>(arg1), 7);
        assert!(calculate_available_dividends<T0, T1>(arg0, arg1, arg2) == 0, 0);
        register_fully_claimed_internal<T1>(arg0, arg2);
    }

    public fun calculate_available_dividends<T0, T1>(arg0: &Dividends<T1>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>, arg2: address) : u64 {
        assert!(0x2::object::id<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>>(arg1) == arg0.snapshot_id, 7);
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::total_supply<T0>(arg1);
        if (v0 == 0) {
            return 0
        };
        let v1 = if (0x2::table::contains<address, u64>(&arg0.claimed, arg2)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed, arg2)
        } else {
            0
        };
        (((arg0.total_funds as u128) * (0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::address_balance<T0>(arg1, arg2) as u128) / (v0 as u128)) as u64) - v1
    }

    public fun claim_all<T0, T1>(arg0: &mut Dividends<T1>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg0.versioning);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = calculate_available_dividends<T0, T1>(arg0, arg1, v0);
        register_fully_claimed_internal<T1>(arg0, v0);
        if (!0x2::table::contains<address, u64>(&arg0.claimed, v0)) {
            0x2::table::add<address, u64>(&mut arg0.claimed, v0, 0);
        };
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.claimed, v0);
        *v2 = *v2 + v1;
        let v3 = Claimed<T0, T1>{
            dividends_id : 0x2::object::id<Dividends<T1>>(arg0),
            claimer      : v0,
            amount       : v1,
            snapshot_id  : arg0.snapshot_id,
        };
        0x2::event::emit<Claimed<T0, T1>>(v3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.unused_funds, v1), arg2)
    }

    public fun claim_amount<T0, T1>(arg0: &mut Dividends<T1>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg0.versioning);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = calculate_available_dividends<T0, T1>(arg0, arg1, v0);
        assert!(arg2 <= v1, 3);
        if (arg2 == v1) {
            register_fully_claimed_internal<T1>(arg0, v0);
        };
        if (!0x2::table::contains<address, u64>(&arg0.claimed, v0)) {
            0x2::table::add<address, u64>(&mut arg0.claimed, v0, 0);
        };
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.claimed, v0);
        *v2 = *v2 + arg2;
        let v3 = Claimed<T0, T1>{
            dividends_id : 0x2::object::id<Dividends<T1>>(arg0),
            claimer      : v0,
            amount       : arg2,
            snapshot_id  : arg0.snapshot_id,
        };
        0x2::event::emit<Claimed<T0, T1>>(v3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.unused_funds, arg2), arg3)
    }

    public fun is_valid_version<T0>(arg0: &Dividends<T0>) : bool {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::is_current_version_valid(&arg0.versioning)
    }

    public fun new_dividends<T0, T1>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::accepted_currencies::AcceptedCurrencies<T0>, arg2: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : Dividends<T1> {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, DividendsAbility>(arg0), 2);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::accepted_currencies::contains<T0, T1>(arg1), 1);
        let v0 = Dividends<T1>{
            id            : 0x2::object::new(arg4),
            funder        : 0x2::tx_context::sender(arg4),
            snapshot_id   : 0x2::object::id<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>>(arg2),
            total_funds   : 0x2::coin::value<T1>(&arg3),
            unused_funds  : 0x2::coin::into_balance<T1>(arg3),
            claimed       : 0x2::table::new<address, u64>(arg4),
            fully_claimed : 0x1::option::some<0x2::table::Table<address, bool>>(0x2::table::new<address, bool>(arg4)),
            versioning    : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::versioning<T0>(arg0),
        };
        let v1 = Funded<T0, T1>{
            dividends_id : 0x2::object::id<Dividends<T1>>(&v0),
            funder       : 0x2::tx_context::sender(arg4),
            amount       : v0.total_funds,
            snapshot_id  : 0x2::object::id<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>>(arg2),
        };
        0x2::event::emit<Funded<T0, T1>>(v1);
        v0
    }

    public fun refund<T0, T1>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut Dividends<T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<address, bool> {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg1.versioning);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, DividendsAbility>(arg0), 2);
        assert!(0x2::tx_context::sender(arg3) == arg1.funder, 6);
        let v0 = 0x2::coin::value<T1>(&arg2);
        arg1.total_funds = arg1.total_funds + v0;
        0x2::balance::join<T1>(&mut arg1.unused_funds, 0x2::coin::into_balance<T1>(arg2));
        let v1 = Funded<T0, T1>{
            dividends_id : 0x2::object::id<Dividends<T1>>(arg1),
            funder       : 0x2::tx_context::sender(arg3),
            amount       : v0,
            snapshot_id  : arg1.snapshot_id,
        };
        0x2::event::emit<Funded<T0, T1>>(v1);
        0x1::option::swap<0x2::table::Table<address, bool>>(&mut arg1.fully_claimed, 0x2::table::new<address, bool>(arg3))
    }

    fun register_fully_claimed_internal<T0>(arg0: &mut Dividends<T0>, arg1: address) {
        let v0 = &mut arg0.fully_claimed;
        if (0x1::option::is_some<0x2::table::Table<address, bool>>(v0)) {
            let v1 = 0x1::option::borrow_mut<0x2::table::Table<address, bool>>(v0);
            if (!0x2::table::contains<address, bool>(v1, arg1)) {
                0x2::table::add<address, bool>(v1, arg1, true);
            };
        };
    }

    public fun retrieve_remaining_dividends<T0, T1>(arg0: &mut Dividends<T1>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg0.versioning);
        assert!(0x2::tx_context::sender(arg2) == arg0.funder, 5);
        assert!(arg0.snapshot_id == 0x2::object::id<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>>(arg1), 7);
        assert!(0x2::table::length<address, bool>(0x1::option::borrow<0x2::table::Table<address, bool>>(&arg0.fully_claimed)) == 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::addresses_length<T0>(arg1), 4);
        let v0 = 0x2::balance::withdraw_all<T1>(&mut arg0.unused_funds);
        let v1 = 0x2::balance::value<T1>(&v0);
        arg0.total_funds = arg0.total_funds - v1;
        let v2 = RemainderRetrieved<T0, T1>{
            dividends_id     : 0x2::object::id<Dividends<T1>>(arg0),
            funder           : arg0.funder,
            amount_retrieved : v1,
            new_total_funds  : arg0.total_funds,
            snapshot_id      : 0x2::object::id<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::Snapshot<T0>>(arg1),
        };
        0x2::event::emit<RemainderRetrieved<T0, T1>>(v2);
        0x2::coin::from_balance<T1>(v0, arg2)
    }

    public fun share_dividends<T0>(arg0: Dividends<T0>) {
        0x2::transfer::share_object<Dividends<T0>>(arg0);
    }

    public fun sync_versioning<T0>(arg0: &mut Dividends<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::VersionRegistry) {
        arg0.versioning = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::versioning(arg1);
    }

    // decompiled from Move bytecode v7
}

