module 0xf3cc86549f161364ac7c7f3180199cc4bd95e638154e7b15bfa8d0c885147e68::guess_number {
    struct GUESS_NUMBER has drop {
        dummy_field: bool,
    }

    struct PrizePool has key {
        id: 0x2::object::UID,
        prize: 0x2::balance::Balance<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>,
        dcwon: address,
    }

    struct PrizePoolCap has key {
        id: 0x2::object::UID,
    }

    public fun withdraw_all(arg0: &mut PrizePool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dcwon == 0x2::tx_context::sender(arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(0x2::balance::withdraw_all<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(&mut arg0.prize), arg1), 0x2::tx_context::sender(arg1));
    }

    fun get_random_num(arg0: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::bcs::new(*0x2::tx_context::digest(arg0));
        0x2::bcs::peel_u8(&mut v0) % 3
    }

    fun init(arg0: GUESS_NUMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PrizePoolCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PrizePoolCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_pool(arg0: PrizePoolCap, arg1: 0x2::coin::Coin<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PrizePool{
            id    : 0x2::object::new(arg2),
            prize : 0x2::coin::into_balance<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(arg1),
            dcwon : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<PrizePool>(v0);
        let PrizePoolCap { id: v1 } = arg0;
        0x2::object::delete(v1);
    }

    public fun query_prize(arg0: &mut PrizePool) : u64 {
        0x2::balance::value<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(&arg0.prize)
    }

    public fun start_game(arg0: &mut PrizePool, arg1: u8, arg2: 0x2::coin::Coin<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>, arg3: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::coin::into_balance<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(arg2);
        let v1 = 0x2::balance::value<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(&v0);
        let v2 = false;
        assert!(v1 < 1000 && v1 > 10, 1);
        0x2::balance::join<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(&mut arg0.prize, v0);
        let v3 = get_random_num(arg3);
        let v4 = 0x1::string::utf8(b"The right number is:");
        0x1::debug::print<0x1::string::String>(&v4);
        0x1::debug::print<u8>(&v3);
        if (arg1 == v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(&mut arg0.prize, 2 * v1), arg3), 0x2::tx_context::sender(arg3));
            v2 = true;
        };
        v2
    }

    public fun top_up(arg0: &mut PrizePool, arg1: 0x2::coin::Coin<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>) {
        0x2::coin::put<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(&mut arg0.prize, arg1);
    }

    public fun withdraw(arg0: &mut PrizePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dcwon == 0x2::tx_context::sender(arg2), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(&mut arg0.prize, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

