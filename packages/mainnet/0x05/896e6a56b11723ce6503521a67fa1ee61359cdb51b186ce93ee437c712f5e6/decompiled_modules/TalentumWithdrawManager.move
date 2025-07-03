module 0x5896e6a56b11723ce6503521a67fa1ee61359cdb51b186ce93ee437c712f5e6::TalentumWithdrawManager {
    struct WithdrawEvent has copy, drop, store {
        withdraw_id: 0x1::string::String,
        to: address,
        amount: u64,
    }

    struct WithdrawManager has key {
        id: 0x2::object::UID,
        owner: address,
        used_ids: 0x2::table::Table<0x1::string::String, bool>,
    }

    public fun change_owner(arg0: &mut WithdrawManager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.owner = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawManager{
            id       : 0x2::object::new(arg0),
            owner    : 0x2::tx_context::sender(arg0),
            used_ids : 0x2::table::new<0x1::string::String, bool>(arg0),
        };
        0x2::transfer::share_object<WithdrawManager>(v0);
    }

    public fun withdraw(arg0: &mut WithdrawManager, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        if (0x2::table::contains<0x1::string::String, bool>(&arg0.used_ids, arg1)) {
            abort 2
        };
        let v0 = WithdrawEvent{
            withdraw_id : arg1,
            to          : arg2,
            amount      : arg3,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::table::add<0x1::string::String, bool>(&mut arg0.used_ids, arg1, true);
    }

    // decompiled from Move bytecode v6
}

