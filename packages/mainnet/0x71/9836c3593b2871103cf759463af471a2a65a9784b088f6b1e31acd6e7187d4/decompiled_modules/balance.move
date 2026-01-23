module 0x719836c3593b2871103cf759463af471a2a65a9784b088f6b1e31acd6e7187d4::balance {
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
        assert!(0x1::type_name::get<0x2::sui::SUI>() == v1 || 0x1::type_name::into_string(v1) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x89d4967bb9f8be150b185965df277629db80b9eabebc416807512ca845fd9bd6);
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

