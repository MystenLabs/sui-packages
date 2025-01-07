module 0xbc728038c81f72b836ea317f0ae01132ce239393325a9c575c75c9edd7f00c6c::game {
    struct GussSizeGame has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xff85f8ddcf845480e267cbca8f3735a5738bdd6c9deccf48608960d6bd800a7d::faucetcoin::FAUCETCOIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut GussSizeGame, arg1: 0x2::coin::Coin<0xff85f8ddcf845480e267cbca8f3735a5738bdd6c9deccf48608960d6bd800a7d::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xff85f8ddcf845480e267cbca8f3735a5738bdd6c9deccf48608960d6bd800a7d::faucetcoin::FAUCETCOIN>(&mut arg0.pool, 0x2::coin::into_balance<0xff85f8ddcf845480e267cbca8f3735a5738bdd6c9deccf48608960d6bd800a7d::faucetcoin::FAUCETCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GussSizeGame{
            id   : 0x2::object::new(arg0),
            pool : 0x2::balance::zero<0xff85f8ddcf845480e267cbca8f3735a5738bdd6c9deccf48608960d6bd800a7d::faucetcoin::FAUCETCOIN>(),
        };
        0x2::transfer::share_object<GussSizeGame>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut GussSizeGame, arg1: 0x2::coin::Coin<0xff85f8ddcf845480e267cbca8f3735a5738bdd6c9deccf48608960d6bd800a7d::faucetcoin::FAUCETCOIN>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xff85f8ddcf845480e267cbca8f3735a5738bdd6c9deccf48608960d6bd800a7d::faucetcoin::FAUCETCOIN>(&arg1) == 1000000000, 0);
        deposit(arg0, arg1, arg3);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = if (0x2::random::generate_u8_in_range(&mut v0, 0, 5) < 3) {
            0
        } else {
            2000000000
        };
        let v2 = 0x2::tx_context::sender(arg3);
        withdraw(arg0, v1, v2, arg3);
    }

    public entry fun withdraw(arg0: &mut GussSizeGame, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xff85f8ddcf845480e267cbca8f3735a5738bdd6c9deccf48608960d6bd800a7d::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xff85f8ddcf845480e267cbca8f3735a5738bdd6c9deccf48608960d6bd800a7d::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xff85f8ddcf845480e267cbca8f3735a5738bdd6c9deccf48608960d6bd800a7d::faucetcoin::FAUCETCOIN>(&mut arg0.pool, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

