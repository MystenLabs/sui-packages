module 0x6cf84168511035c04c94807c854ccc5a9ef8d9fd12aaa71d3a2b12e5ef79fa2f::coinflip {
    struct CoinFlipMatch has store, key {
        id: 0x2::object::UID,
        player1: address,
        player2: 0x1::option::Option<address>,
        bet_amount: u64,
        player1_choice: bool,
        player2_choice: 0x1::option::Option<bool>,
        result: bool,
        is_active: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    entry fun add_another_player(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut CoinFlipMatch, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1.bet_amount, 1);
        arg1.player2 = 0x1::option::some<address>(0x2::tx_context::sender(arg3));
        arg1.player2_choice = 0x1::option::some<bool>(arg2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, arg0);
    }

    entry fun create_match(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        let v1 = CoinFlipMatch{
            id             : 0x2::object::new(arg3),
            player1        : v0,
            player2        : 0x1::option::none<address>(),
            bet_amount     : arg1,
            player1_choice : arg2,
            player2_choice : 0x1::option::none<bool>(),
            result         : false,
            is_active      : true,
            balance        : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg3)),
        };
        0x2::transfer::public_share_object<CoinFlipMatch>(v1);
    }

    entry fun pay_winner(arg0: &mut CoinFlipMatch, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0.result) {
            arg0.player1
        } else {
            *0x1::option::borrow<address>(&arg0.player2)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg1), v0);
        arg0.is_active = false;
    }

    entry fun set_winner(arg0: &mut CoinFlipMatch, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x97e4092b163d12fa6d78dba200f9b335e7e559bd61189f080a0565da6f841027, 2);
        if (arg1 == arg0.player1_choice) {
            arg0.result = true;
        } else {
            arg0.result = false;
        };
        let v0 = if (arg0.result) {
            arg0.player1
        } else {
            *0x1::option::borrow<address>(&arg0.player2)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2), v0);
        arg0.is_active = false;
    }

    // decompiled from Move bytecode v6
}

