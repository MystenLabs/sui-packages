module 0x2f93f513292f5509e07fb5d8210b7652c8226bc44ed44482980764161e73bc06::fee {
    struct FeeObject has key {
        id: 0x2::object::UID,
        admin: address,
        balance_suai: 0x2::balance::Balance<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    public entry fun collect_fees(arg0: &mut FeeObject, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        0x2f93f513292f5509e07fb5d8210b7652c8226bc44ed44482980764161e73bc06::utils::send_coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(0x2::coin::from_balance<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(0x2::balance::withdraw_all<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&mut arg0.balance_suai), arg1), 0x2::tx_context::sender(arg1));
        0x2f93f513292f5509e07fb5d8210b7652c8226bc44ed44482980764161e73bc06::utils::send_coin<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance_sui), arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun get_mut_balance_sui(arg0: &mut FeeObject) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.balance_sui
    }

    public(friend) fun get_mut_balance_suiai(arg0: &mut FeeObject) : &mut 0x2::balance::Balance<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI> {
        &mut arg0.balance_suai
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            balance_suai : 0x2::balance::zero<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(),
            balance_sui  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    // decompiled from Move bytecode v6
}

