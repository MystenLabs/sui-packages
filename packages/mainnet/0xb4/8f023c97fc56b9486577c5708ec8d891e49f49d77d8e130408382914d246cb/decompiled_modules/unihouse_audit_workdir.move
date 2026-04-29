module 0xb48f023c97fc56b9486577c5708ec8d891e49f49d77d8e130408382914d246cb::unihouse_audit_workdir {
    struct House has key {
        id: 0x2::object::UID,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun deposit(arg0: &mut House, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = House{
            id   : 0x2::object::new(arg0),
            fees : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<House>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun withdraw_fees(arg0: &mut House, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fees);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fees, v0), arg1), 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v7
}

