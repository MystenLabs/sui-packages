module 0x2833546159c9d05015e28304096ab26ac3b264d1b25d24d77ad4ccfa48c45c94::global_config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        advance_deep_fee: bool,
        advance_amount: u64,
        vault: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        protocol_fee_rate_table: 0x2::table::Table<address, u64>,
        protocol_fees: 0x2::bag::Bag,
        package_version: u64,
    }

    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
    }

    struct UpdateProtocolFeeRateEvent has copy, drop {
        pool: address,
        old_rate: u64,
        new_rate: u64,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct SetAdvanceAmount has copy, drop {
        new_amount: u64,
        old_amount: u64,
    }

    public fun advance_amount(arg0: &GlobalConfig) : u64 {
        arg0.advance_amount
    }

    public fun advance_deep_fee(arg0: &GlobalConfig) : bool {
        arg0.advance_deep_fee
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 0);
    }

    public fun deep_fee_amount(arg0: &GlobalConfig) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.vault)
    }

    public fun deposit_deep_fee(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.vault, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public(friend) fun deposit_protocol_fee<T0>(arg0: &mut GlobalConfig, arg1: address, arg2: 0x2::balance::Balance<T0>) {
        if (0x2::bag::contains<address>(&arg0.protocol_fees, arg1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, arg1), arg2);
        } else {
            0x2::bag::add<address, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, arg1, arg2);
        };
    }

    public fun get_protocol_fee_rate(arg0: &mut GlobalConfig, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.protocol_fee_rate_table, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.protocol_fee_rate_table, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                      : 0x2::object::new(arg0),
            advance_deep_fee        : true,
            advance_amount          : 100000000,
            vault                   : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            protocol_fee_rate_table : 0x2::table::new<address, u64>(arg0),
            protocol_fees           : 0x2::bag::new(arg0),
            package_version         : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = InitEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v1),
            global_config_id : 0x2::object::id<GlobalConfig>(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v0);
        0x2::event::emit<InitEvent>(v2);
    }

    public fun set_advance_deep_fee(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.advance_deep_fee = arg2;
    }

    public fun set_protocol_fee_rate(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u64) : u64 {
        assert!(arg3 <= 1000000, 1);
        if (!0x2::table::contains<address, u64>(&arg1.protocol_fee_rate_table, arg2)) {
            0x2::table::add<address, u64>(&mut arg1.protocol_fee_rate_table, arg2, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg1.protocol_fee_rate_table, arg2);
        *v0 = arg3;
        let v1 = UpdateProtocolFeeRateEvent{
            pool     : arg2,
            old_rate : *v0,
            new_rate : arg3,
        };
        0x2::event::emit<UpdateProtocolFeeRateEvent>(v1);
        arg3
    }

    public fun update_advance_amount(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.advance_amount = arg2;
        let v0 = SetAdvanceAmount{
            new_amount : arg2,
            old_amount : arg1.advance_amount,
        };
        0x2::event::emit<SetAdvanceAmount>(v0);
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    public(friend) fun withdraw_advance_deep(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(deep_fee_amount(arg0) >= arg0.advance_amount, 1);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.vault, arg0.advance_amount), arg1)
    }

    public(friend) fun withdraw_deep(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.vault, arg1), arg2)
    }

    public fun withdraw_deep_fee(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(deep_fee_amount(arg1) >= arg2, 1);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.vault, arg2), arg3)
    }

    public fun withdraw_protocol_fee<T0>(arg0: &mut GlobalConfig, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::bag::contains<address>(&arg0.protocol_fees, arg1), 3);
        let v0 = 0x2::bag::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, arg1);
        assert!(0x2::balance::value<T0>(v0) >= arg2, 2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

