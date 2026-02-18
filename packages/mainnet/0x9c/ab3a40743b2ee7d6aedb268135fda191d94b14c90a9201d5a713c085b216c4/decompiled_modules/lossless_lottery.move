module 0x9cab3a40743b2ee7d6aedb268135fda191d94b14c90a9201d5a713c085b216c4::lossless_lottery {
    struct Pool has key {
        id: 0x2::object::UID,
        total_principal: 0x2::balance::Balance<0x2::sui::SUI>,
        interest_accumulated: 0x2::balance::Balance<0x2::sui::SUI>,
        players: vector<address>,
    }

    struct DepositMade has copy, drop {
        player: address,
        amount: u64,
    }

    struct WinnerDrawn has copy, drop {
        winner: address,
        amount: u64,
    }

    public fun add_interest(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.interest_accumulated, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun create_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id                   : 0x2::object::new(arg0),
            total_principal      : 0x2::balance::zero<0x2::sui::SUI>(),
            interest_accumulated : 0x2::balance::zero<0x2::sui::SUI>(),
            players              : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public fun deposit(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_principal, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (!0x1::vector::contains<address>(&arg0.players, &v0)) {
            0x1::vector::push_back<address>(&mut arg0.players, v0);
        };
        let v1 = DepositMade{
            player : v0,
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<DepositMade>(v1);
    }

    public entry fun draw_winner(arg0: &mut Pool, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0.players);
        assert!(v0 > 0, 1);
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = *0x1::vector::borrow<address>(&arg0.players, 0x2::random::generate_u64_in_range(&mut v1, 0, v0 - 1));
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.interest_accumulated);
        let v4 = WinnerDrawn{
            winner : v2,
            amount : v3,
        };
        0x2::event::emit<WinnerDrawn>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.interest_accumulated, v3, arg2), v2);
    }

    public fun withdraw_all(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_principal, 0x2::balance::value<0x2::sui::SUI>(&arg0.total_principal), arg1)
    }

    // decompiled from Move bytecode v6
}

