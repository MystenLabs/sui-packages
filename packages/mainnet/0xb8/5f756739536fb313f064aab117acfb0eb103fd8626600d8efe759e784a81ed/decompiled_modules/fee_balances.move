module 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::fee_balances {
    struct FeeBalances<phantom T0> has store {
        deposit: 0x2::balance::Balance<T0>,
        withdraw: 0x2::balance::Balance<T0>,
        protocol: 0x2::balance::Balance<T0>,
    }

    public(friend) fun withdraw_all<T0>(arg0: &mut FeeBalances<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg0.deposit));
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg0.withdraw));
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg0.protocol));
        v0
    }

    public(friend) fun add_deposit<T0>(arg0: &mut FeeBalances<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.deposit, arg1);
    }

    public(friend) fun add_protocol<T0>(arg0: &mut FeeBalances<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.protocol, arg1);
    }

    public(friend) fun add_withdraw<T0>(arg0: &mut FeeBalances<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.withdraw, arg1);
    }

    public fun deposit<T0>(arg0: &FeeBalances<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.deposit)
    }

    public(friend) fun new<T0>() : FeeBalances<T0> {
        FeeBalances<T0>{
            deposit  : 0x2::balance::zero<T0>(),
            withdraw : 0x2::balance::zero<T0>(),
            protocol : 0x2::balance::zero<T0>(),
        }
    }

    public fun protocol<T0>(arg0: &FeeBalances<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.protocol)
    }

    public fun withdraw<T0>(arg0: &FeeBalances<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.withdraw)
    }

    public(friend) fun withdraw_deposit<T0>(arg0: &mut FeeBalances<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.deposit)
    }

    public(friend) fun withdraw_protocol<T0>(arg0: &mut FeeBalances<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.protocol)
    }

    public(friend) fun withdraw_withdraw<T0>(arg0: &mut FeeBalances<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.withdraw)
    }

    // decompiled from Move bytecode v6
}

