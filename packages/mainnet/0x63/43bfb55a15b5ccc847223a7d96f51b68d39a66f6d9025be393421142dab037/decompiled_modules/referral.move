module 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::referral {
    struct Referral has store {
        discount: u64,
        commission: u64,
        sales: u64,
        receiver_address: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public(friend) fun join(arg0: &mut Referral, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun balance_value(arg0: &Referral) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public(friend) fun burn(arg0: Referral, arg1: &mut 0x2::tx_context::TxContext) {
        let Referral {
            discount         : _,
            commission       : _,
            sales            : _,
            receiver_address : v3,
            balance          : v4,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg1), v3);
    }

    public(friend) fun change_commission(arg0: &mut Referral, arg1: u64) {
        arg0.commission = arg1;
    }

    public(friend) fun change_discount(arg0: &mut Referral, arg1: u64) {
        arg0.discount = arg1;
    }

    public(friend) fun change_receiver_address(arg0: &mut Referral, arg1: address) {
        arg0.receiver_address = arg1;
    }

    public fun commission(arg0: &Referral) : u64 {
        arg0.commission
    }

    public(friend) fun create_referral(arg0: u64, arg1: u64, arg2: u64, arg3: address) : Referral {
        Referral{
            discount         : arg0,
            commission       : arg1,
            sales            : arg2,
            receiver_address : arg3,
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun discount(arg0: &Referral) : u64 {
        arg0.discount
    }

    public(friend) fun new_sale(arg0: &mut Referral) {
        arg0.sales = arg0.sales + 1;
    }

    public fun receiver_address(arg0: &Referral) : address {
        arg0.receiver_address
    }

    public fun sales(arg0: &Referral) : u64 {
        arg0.sales
    }

    public(friend) fun withdraw(arg0: &mut Referral) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance)
    }

    // decompiled from Move bytecode v6
}

