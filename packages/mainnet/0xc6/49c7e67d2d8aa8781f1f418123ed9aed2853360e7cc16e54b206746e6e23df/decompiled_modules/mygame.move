module 0xc649c7e67d2d8aa8781f1f418123ed9aed2853360e7cc16e54b206746e6e23df::mygame {
    struct Mora has store, key {
        id: 0x2::object::UID,
        num: u64,
        symbol: 0x1::string::String,
    }

    struct GamePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
    }

    public entry fun battle(arg0: &mut GamePool, arg1: &Mora, arg2: &mut 0x2::tx_context::TxContext) {
        if ((arg1.num - 0xc649c7e67d2d8aa8781f1f418123ed9aed2853360e7cc16e54b206746e6e23df::random::rand_u64_range(0, 3, arg2)) % 3 == 2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GamePool{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            owner   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<GamePool>(v0);
    }

    public entry fun participate(arg0: &mut GamePool, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 2) {
            return
        };
        let v0 = Mora{
            id     : 0x2::object::new(arg3),
            num    : arg1,
            symbol : 0x1::string::utf8(b""),
        };
        if (arg1 == 0) {
            v0.symbol = 0x1::string::utf8(b"Rock");
        } else if (arg1 == 1) {
            v0.symbol = 0x1::string::utf8(b"Scissors");
        } else if (arg1 == 2) {
            v0.symbol = 0x1::string::utf8(b"Paper");
        };
        0x2::transfer::public_transfer<Mora>(v0, 0x2::tx_context::sender(arg3));
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), 1), arg3));
    }

    // decompiled from Move bytecode v6
}

