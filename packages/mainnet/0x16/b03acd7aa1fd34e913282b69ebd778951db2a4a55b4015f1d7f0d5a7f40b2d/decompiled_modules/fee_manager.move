module 0x16b03acd7aa1fd34e913282b69ebd778951db2a4a55b4015f1d7f0d5a7f40b2d::fee_manager {
    struct FeeConfig has key {
        id: 0x2::object::UID,
        admin: address,
        operator: address,
        fees: 0x2::table::Table<u64, u64>,
    }

    struct FeeUpdatedEvent has copy, drop {
        chain_id: u64,
        fee: u64,
    }

    struct AdminChangedEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct OperatorChangedEvent has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    public entry fun change_admin(arg0: &mut FeeConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
        let v0 = AdminChangedEvent{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminChangedEvent>(v0);
    }

    public entry fun change_operator(arg0: &mut FeeConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.operator = arg1;
        let v0 = OperatorChangedEvent{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorChangedEvent>(v0);
    }

    public fun get_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.fees, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.fees, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = FeeConfig{
            id       : 0x2::object::new(arg0),
            admin    : v0,
            operator : v0,
            fees     : 0x2::table::new<u64, u64>(arg0),
        };
        0x2::transfer::share_object<FeeConfig>(v1);
    }

    public entry fun set_fee(arg0: &mut FeeConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.operator, 1);
        if (0x2::table::contains<u64, u64>(&arg0.fees, arg1)) {
            0x2::table::remove<u64, u64>(&mut arg0.fees, arg1);
        };
        0x2::table::add<u64, u64>(&mut arg0.fees, arg1, arg2);
        let v0 = FeeUpdatedEvent{
            chain_id : arg1,
            fee      : arg2,
        };
        0x2::event::emit<FeeUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

