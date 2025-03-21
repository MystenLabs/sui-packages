module 0x3a4760a8d362d49e81a6b3e98c3c5f3360e861d1c1546b15bc8d987830f73767::moveGame {
    struct Bet has drop, store {
        player: address,
        guess: bool,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        admin: address,
        bets: vector<Bet>,
        val: 0x2::balance::Balance<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>,
    }

    public entry fun deposit(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Bet{
            player : 0x2::tx_context::sender(arg3),
            guess  : arg1,
        };
        0x2::balance::join<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(arg2));
        0x1::vector::push_back<Bet>(&mut arg0.bets, v0);
        assert!(0x1::vector::length<Bet>(&arg0.bets) <= 2, 1000);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
            bets  : 0x1::vector::empty<Bet>(),
            val   : 0x2::balance::zero<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
    }

    public entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1001);
        assert!(0x1::vector::length<Bet>(&arg0.bets) == 2, 1002);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = 0x1::vector::borrow<Bet>(&arg0.bets, 0);
        let v2 = 0x1::vector::borrow<Bet>(&arg0.bets, 1);
        assert!(v1.guess != v2.guess, 1003);
        let v3 = if (v1.guess == 0x2::random::generate_bool(&mut v0)) {
            v1.player
        } else {
            v2.player
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>>(0x2::coin::from_balance<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(0x2::balance::split<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(&mut arg0.val, 0x2::balance::value<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(&arg0.val)), arg2), v3);
        0x1::vector::pop_back<Bet>(&mut arg0.bets);
        0x1::vector::pop_back<Bet>(&mut arg0.bets);
    }

    public entry fun withdraw(arg0: &mut Game, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1001);
        assert!(0x2::balance::value<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(&arg0.val) >= arg1, 1004);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>>(0x2::coin::from_balance<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(0x2::balance::split<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(&mut arg0.val, arg1), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

