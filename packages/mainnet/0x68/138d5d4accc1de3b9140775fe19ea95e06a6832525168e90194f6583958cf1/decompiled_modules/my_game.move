module 0x68138d5d4accc1de3b9140775fe19ea95e06a6832525168e90194f6583958cf1::my_game {
    struct GameCap has key {
        id: 0x2::object::UID,
    }

    struct JethrozzGame has key {
        id: 0x2::object::UID,
        amt: 0x2::balance::Balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>,
    }

    public entry fun add_coin(arg0: &mut JethrozzGame, arg1: 0x2::coin::Coin<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&mut arg0.amt, 0x2::coin::into_balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameCap{id: 0x2::object::new(arg0)};
        let v1 = JethrozzGame{
            id  : 0x2::object::new(arg0),
            amt : 0x2::balance::zero<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(),
        };
        0x2::transfer::share_object<JethrozzGame>(v1);
        0x2::transfer::transfer<GameCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: u8, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>, arg3: &mut JethrozzGame, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 4, 1);
        let v0 = 0x2::coin::value<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&arg2);
        assert!(0x2::balance::value<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&arg3.amt) >= v0 * 10, 2);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        let v2 = 0x2::random::generate_u8_in_range(&mut v1, 1, 3);
        if (v2 > arg0 && v2 - arg0 == 1 || arg0 < v2 && v2 - arg0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>>(0x2::coin::from_balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(0x2::balance::split<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&mut arg3.amt, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&mut arg3.amt, 0x2::coin::into_balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(arg2));
        };
    }

    public entry fun remove_coin(arg0: &GameCap, arg1: &mut JethrozzGame, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>>(0x2::coin::from_balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(0x2::balance::split<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&mut arg1.amt, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

