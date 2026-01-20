module 0xeed636837b33336d6275be27125b75c424a89b86f063692c57432958ec52049d::balance {
    struct BalanceTopUp has copy, drop {
        wallet: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct BalanceWithdraw has copy, drop {
        wallet: address,
        amount: u64,
    }

    public fun top_up<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::type_name::get<0x2::sui::SUI>() == v1 || 0x1::type_name::into_string(v1) == 0x1::ascii::string(b"05d4b3023066494235199e14acb330b306afd3d1019198f5124995a5015b97f50::usdc::USDC"), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0xa93d7878602ebce9c56de83a459ad98dfd6faadb1b4c0ee5ca6a4e507fea37de);
        let v2 = BalanceTopUp{
            wallet    : 0x2::tx_context::sender(arg1),
            amount    : v0,
            coin_type : v1,
        };
        0x2::event::emit<BalanceTopUp>(v2);
    }

    public fun withdraw(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 0);
        let v0 = BalanceWithdraw{
            wallet : 0x2::tx_context::sender(arg1),
            amount : arg0,
        };
        0x2::event::emit<BalanceWithdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

