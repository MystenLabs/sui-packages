module 0xd59299d330b00d203e4017f14cfb0fb5db9cb9d2e227ec78f8f26409ca1bb863::balance {
    struct DEBUGBalanceTopUp has copy, drop {
        wallet: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        type_string: 0x1::ascii::String,
    }

    struct BalanceWithdraw has copy, drop {
        wallet: address,
        amount: u64,
    }

    public fun top_up<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        let v1 = 0x1::type_name::get<T0>();
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x89d4967bb9f8be150b185965df277629db80b9eabebc416807512ca845fd9bd6);
        let v2 = DEBUGBalanceTopUp{
            wallet      : 0x2::tx_context::sender(arg1),
            amount      : v0,
            coin_type   : v1,
            type_string : 0x1::type_name::into_string(v1),
        };
        0x2::event::emit<DEBUGBalanceTopUp>(v2);
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

