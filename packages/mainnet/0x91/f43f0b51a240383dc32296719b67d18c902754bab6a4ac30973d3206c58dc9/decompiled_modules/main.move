module 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::main {
    struct Control has key {
        id: 0x2::object::UID,
        winner: 0x1::option::Option<address>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        sender1: address,
        amount1: u64,
        sender2: 0x1::option::Option<address>,
        amount2: u64,
    }

    public(friend) fun create_bet(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 13906834316077301761);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 13906834320372400131);
        let v0 = Control{
            id      : 0x2::object::new(arg2),
            winner  : 0x1::option::none<address>(),
            balance : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg2)),
            sender1 : 0x2::tx_context::sender(arg2),
            amount1 : arg1,
            sender2 : 0x1::option::none<address>(),
            amount2 : 0,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<Control>(v0);
    }

    public(friend) fun destroy(arg0: Control) {
        let Control {
            id      : v0,
            winner  : _,
            balance : v2,
            sender1 : _,
            amount1 : _,
            sender2 : _,
            amount2 : _,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        0x2::object::delete(v0);
    }

    public(friend) fun draw(arg0: &mut Control, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.sender2), 13906834474991353861);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg0.amount2), arg1), 0x1::option::extract<address>(&mut arg0.sender2));
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) == arg0.amount1, 13906834496466321415);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg1), arg0.sender1);
        arg0.amount1 = 0;
        arg0.amount2 = 0;
    }

    public(friend) fun finish_game(arg0: &mut Control, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.winner), 13906834535121158153);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg1), *0x1::option::borrow<address>(&arg0.winner));
    }

    public(friend) fun join_bet(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut Control, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.balance) <= arg1, 13906834393386844163);
        arg2.sender2 = 0x1::option::some<address>(0x2::tx_context::sender(arg3));
        arg2.amount2 = arg1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun sender1(arg0: &Control) : address {
        arg0.sender1
    }

    public(friend) fun share_control(arg0: Control) {
        0x2::transfer::share_object<Control>(arg0);
    }

    public(friend) fun winner(arg0: address, arg1: &mut Control) {
        arg1.winner = 0x1::option::some<address>(arg0);
    }

    // decompiled from Move bytecode v6
}

