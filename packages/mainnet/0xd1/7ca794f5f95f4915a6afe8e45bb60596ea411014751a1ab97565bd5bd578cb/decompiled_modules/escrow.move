module 0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::escrow {
    struct Escrow has store {
        payment: 0x2::balance::Balance<0x2::sui::SUI>,
        bond: 0x2::balance::Balance<0x2::sui::SUI>,
        payment_amount: u64,
        bond_amount: u64,
    }

    public fun empty() : Escrow {
        Escrow{
            payment        : 0x2::balance::zero<0x2::sui::SUI>(),
            bond           : 0x2::balance::zero<0x2::sui::SUI>(),
            payment_amount : 0,
            bond_amount    : 0,
        }
    }

    public fun destroy_empty(arg0: Escrow) {
        let Escrow {
            payment        : v0,
            bond           : v1,
            payment_amount : _,
            bond_amount    : _,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
    }

    public fun bond_amount(arg0: &Escrow) : u64 {
        arg0.bond_amount
    }

    public fun bond_balance(arg0: &Escrow) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bond)
    }

    public fun create(arg0: 0x2::coin::Coin<0x2::sui::SUI>) : Escrow {
        Escrow{
            payment        : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            bond           : 0x2::balance::zero<0x2::sui::SUI>(),
            payment_amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            bond_amount    : 0,
        }
    }

    public fun has_bond(arg0: &Escrow) : bool {
        arg0.bond_amount > 0
    }

    public fun lock_bond(arg0: &mut Escrow, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.bond, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.bond_amount = arg2;
    }

    public fun payment_amount(arg0: &Escrow) : u64 {
        arg0.payment_amount
    }

    public fun payment_balance(arg0: &Escrow) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.payment)
    }

    public fun refund_full(arg0: &mut Escrow, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.payment), arg1)
    }

    public fun refund_with_bond(arg0: &mut Escrow, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.payment), arg1), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bond), arg1))
    }

    public fun refund_with_slash(arg0: &mut Escrow, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        if (arg0.bond_amount == 0) {
            return (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.payment), arg1), 0x2::coin::zero<0x2::sui::SUI>(arg1), 0x2::coin::zero<0x2::sui::SUI>(arg1))
        };
        let v0 = arg0.bond_amount * 5000 / 10000;
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.payment), arg1), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bond, v0), arg1), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bond, arg0.bond_amount - v0), arg1))
    }

    public fun settle(arg0: &mut Escrow, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = arg0.payment_amount * arg1 / 10000;
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.payment, arg0.payment_amount - v0), arg2), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bond), arg2), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.payment, v0), arg2))
    }

    // decompiled from Move bytecode v6
}

