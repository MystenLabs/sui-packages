module 0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::escrow {
    struct Escrow has store {
        payment: 0x2::balance::Balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>,
        bond: 0x2::balance::Balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>,
        payment_amount: u64,
        bond_amount: u64,
    }

    public fun empty() : Escrow {
        Escrow{
            payment        : 0x2::balance::zero<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(),
            bond           : 0x2::balance::zero<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(),
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
        0x2::balance::destroy_zero<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(v0);
        0x2::balance::destroy_zero<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(v1);
    }

    public fun bond_amount(arg0: &Escrow) : u64 {
        arg0.bond_amount
    }

    public fun bond_balance(arg0: &Escrow) : u64 {
        0x2::balance::value<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&arg0.bond)
    }

    public fun create(arg0: 0x2::coin::Coin<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>) : Escrow {
        Escrow{
            payment        : 0x2::coin::into_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(arg0),
            bond           : 0x2::balance::zero<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(),
            payment_amount : 0x2::coin::value<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&arg0),
            bond_amount    : 0,
        }
    }

    public fun has_bond(arg0: &Escrow) : bool {
        arg0.bond_amount > 0
    }

    public fun lock_bond(arg0: &mut Escrow, arg1: 0x2::coin::Coin<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>, arg2: u64) {
        assert!(0x2::coin::value<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&arg1) >= arg2, 8);
        0x2::balance::join<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&mut arg0.bond, 0x2::coin::into_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(arg1));
        arg0.bond_amount = arg2;
    }

    public fun payment_amount(arg0: &Escrow) : u64 {
        arg0.payment_amount
    }

    public fun payment_balance(arg0: &Escrow) : u64 {
        0x2::balance::value<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&arg0.payment)
    }

    public fun refund_full(arg0: &mut Escrow, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC> {
        0x2::coin::from_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(0x2::balance::withdraw_all<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&mut arg0.payment), arg1)
    }

    public fun refund_with_bond(arg0: &mut Escrow, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>, 0x2::coin::Coin<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>) {
        (0x2::coin::from_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(0x2::balance::withdraw_all<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&mut arg0.payment), arg1), 0x2::coin::from_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(0x2::balance::withdraw_all<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&mut arg0.bond), arg1))
    }

    public fun refund_with_slash(arg0: &mut Escrow, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>, 0x2::coin::Coin<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>, 0x2::coin::Coin<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>) {
        if (arg0.bond_amount == 0) {
            return (0x2::coin::from_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(0x2::balance::withdraw_all<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&mut arg0.payment), arg1), 0x2::coin::zero<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(arg1), 0x2::coin::zero<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(arg1))
        };
        let v0 = arg0.bond_amount * 5000 / 10000;
        (0x2::coin::from_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(0x2::balance::withdraw_all<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&mut arg0.payment), arg1), 0x2::coin::from_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(0x2::balance::split<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&mut arg0.bond, v0), arg1), 0x2::coin::from_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(0x2::balance::split<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&mut arg0.bond, arg0.bond_amount - v0), arg1))
    }

    public fun settle(arg0: &mut Escrow, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>, 0x2::coin::Coin<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>, 0x2::coin::Coin<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>) {
        let v0 = arg0.payment_amount * arg1 / 10000;
        (0x2::coin::from_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(0x2::balance::split<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&mut arg0.payment, arg0.payment_amount - v0), arg2), 0x2::coin::from_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(0x2::balance::withdraw_all<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&mut arg0.bond), arg2), 0x2::coin::from_balance<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(0x2::balance::split<0xe5adf22776930a124d158b4bfab05910420e19638e6455074bdcab84c4e0a47c::types::USDC>(&mut arg0.payment, v0), arg2))
    }

    // decompiled from Move bytecode v6
}

