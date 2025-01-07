module 0x6dfda359440d1ff0c35ac461db2e1cde7441b2e2f4d0286b0c3521ab7123fed1::global_config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        advance_deep_fee: bool,
        advance_amount: u64,
        vault: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        package_version: u64,
    }

    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
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
        assert!(1 == arg0.package_version, 0);
    }

    public fun deep_fee_amount(arg0: &GlobalConfig) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.vault)
    }

    public fun deposit_deep_fee(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.vault, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id               : 0x2::object::new(arg0),
            advance_deep_fee : true,
            advance_amount   : 100000000,
            vault            : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            package_version  : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v0);
        let v2 = InitEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v1),
            global_config_id : 0x2::object::id<GlobalConfig>(&v0),
        };
        0x2::event::emit<InitEvent>(v2);
    }

    public fun set_advance_deep_fee(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.advance_deep_fee = arg2;
    }

    public fun update_advance_amount(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        let v0 = SetAdvanceAmount{
            new_amount : arg2,
            old_amount : arg1.advance_amount,
        };
        0x2::event::emit<SetAdvanceAmount>(v0);
        arg1.advance_amount = arg2;
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
        let v0 = arg0.advance_amount;
        assert!(deep_fee_amount(arg0) >= v0, 1);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.vault, v0), arg1)
    }

    public fun withdraw_deep_fee(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(deep_fee_amount(arg1) >= arg2, 1);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.vault, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

