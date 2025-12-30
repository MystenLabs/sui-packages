module 0xf8209567df9e80789ec7036f747d6386a8935b50f065e955a715e364f4f893aa::betting {
    struct Platform has key {
        id: 0x2::object::UID,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
    }

    struct Bet has store, key {
        id: 0x2::object::UID,
        bettor: address,
        stake: u64,
        payout: u64,
        status: u8,
    }

    public entry fun deposit(arg0: &mut Platform, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Platform{
            id       : 0x2::object::new(arg0),
            treasury : 0x2::balance::zero<0x2::sui::SUI>(),
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Platform>(v0);
    }

    public entry fun place_bet(arg0: &mut Platform, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = Bet{
            id     : 0x2::object::new(arg3),
            bettor : 0x2::tx_context::sender(arg3),
            stake  : v0,
            payout : v0 * arg2 / 100,
            status : 0,
        };
        0x2::transfer::transfer<Bet>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun settle_bet(arg0: &mut Platform, arg1: &mut Bet, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg1.status == 0, 1);
        if (arg2) {
            arg1.status = 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, arg1.payout), arg3), arg1.bettor);
        } else {
            arg1.status = 2;
        };
    }

    // decompiled from Move bytecode v6
}

