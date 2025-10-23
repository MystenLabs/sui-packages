module 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::fee_router {
    struct FeeRouter has store, key {
        id: 0x2::object::UID,
        fees: 0x2::table::Table<address, u64>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun deposit_payment(arg0: &mut FeeRouter, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_accrued_fees(arg0: &FeeRouter, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.fees, arg1), 13906834380501811199);
        *0x2::table::borrow<address, u64>(&arg0.fees, arg1)
    }

    public(friend) fun new_fee_router(arg0: &mut 0x2::tx_context::TxContext) : FeeRouter {
        FeeRouter{
            id      : 0x2::object::new(arg0),
            fees    : 0x2::table::new<address, u64>(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public(friend) fun record_fee(arg0: &mut FeeRouter, arg1: address, arg2: u64) {
        assert!(arg2 > 0, 13906834277422596095);
        if (!0x2::table::contains<address, u64>(&arg0.fees, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.fees, arg1, arg2);
        } else {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.fees, arg1);
            *v0 = *v0 + arg2;
        };
    }

    public(friend) fun withdraw_fees(arg0: &mut FeeRouter, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(0x2::table::contains<address, u64>(&arg0.fees, 0x2::tx_context::sender(arg1)), 13906834341847105535);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.fees, 0x2::tx_context::sender(arg1));
        assert!(*v0 > 0, 13906834350437040127);
        *v0 = 0;
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, *v0)
    }

    // decompiled from Move bytecode v6
}

