module 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::rps_game {
    struct GameRoom has key {
        id: 0x2::object::UID,
        player1: address,
        player2: 0x1::option::Option<address>,
        stake: u64,
        hand1: u8,
        hand2: u8,
        commitment1: vector<u8>,
        commitment2: vector<u8>,
        salt1: vector<u8>,
        salt2: vector<u8>,
        created_at: u64,
        state: u8,
        pool_id: 0x2::object::ID,
        escrow_balance: 0x2::balance::Balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>,
    }

    struct GameCreated has copy, drop {
        room_id: 0x2::object::ID,
        player1: address,
        stake: u64,
    }

    struct GameJoined has copy, drop {
        room_id: 0x2::object::ID,
        player2: address,
    }

    struct GameRevealed has copy, drop {
        room_id: 0x2::object::ID,
    }

    struct GameSettled has copy, drop {
        room_id: 0x2::object::ID,
        winner: 0x1::option::Option<address>,
        fee: u64,
    }

    struct GameTimedOut has copy, drop {
        room_id: 0x2::object::ID,
    }

    fun borrow_pool(arg0: 0x2::object::ID) : &mut 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::pool::Pool<GameRoom> {
        abort 0
    }

    public fun create_game(arg0: u64, arg1: 0x2::object::ID, arg2: u8, arg3: vector<u8>, arg4: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : GameRoom {
        assert!(arg2 <= 2, 0);
        assert!(0x2::coin::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg4) == arg0, 1);
        let v0 = GameRoom{
            id             : 0x2::object::new(arg6),
            player1        : 0x2::tx_context::sender(arg6),
            player2        : 0x1::option::none<address>(),
            stake          : arg0,
            hand1          : 0,
            hand2          : 0,
            commitment1    : hash(arg2, arg3),
            commitment2    : b"",
            salt1          : arg3,
            salt2          : b"",
            created_at     : 0x2::clock::timestamp_ms(arg5),
            state          : 0,
            pool_id        : arg1,
            escrow_balance : 0x2::coin::into_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(arg4),
        };
        let v1 = GameCreated{
            room_id : 0x2::object::id<GameRoom>(&v0),
            player1 : 0x2::tx_context::sender(arg6),
            stake   : arg0,
        };
        0x2::event::emit<GameCreated>(v1);
        v0
    }

    fun determine_winner(arg0: u8, arg1: u8, arg2: address, arg3: 0x1::option::Option<address>) : 0x1::option::Option<address> {
        if (arg0 == arg1) {
            return 0x1::option::none<address>()
        };
        let v0 = 0x1::option::borrow<address>(&arg3);
        let v1 = if (arg0 == 0 && arg1 == 2) {
            true
        } else if (arg0 == 1 && arg1 == 0) {
            true
        } else {
            arg0 == 2 && arg1 == 1
        };
        if (v1) {
            0x1::option::some<address>(arg2)
        } else {
            0x1::option::some<address>(*v0)
        }
    }

    fun hash(arg0: u8, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        v0
    }

    public fun join_game(arg0: &mut GameRoom, arg1: vector<u8>, arg2: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 0);
        assert!(0x2::coin::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg2) == arg0.stake, 1);
        0x2::balance::join<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.escrow_balance, 0x2::coin::into_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(arg2));
        arg0.player2 = 0x1::option::some<address>(0x2::tx_context::sender(arg3));
        arg0.commitment2 = arg1;
        arg0.state = 1;
        let v0 = GameJoined{
            room_id : 0x2::object::id<GameRoom>(arg0),
            player2 : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<GameJoined>(v0);
    }

    public fun reveal(arg0: &mut GameRoom, arg1: u8, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (v0 == arg0.player1) {
            assert!(arg0.commitment1 == hash(arg1, arg2), 0);
            arg0.hand1 = arg1;
            arg0.salt1 = arg2;
        } else {
            assert!(0x1::option::contains<address>(&arg0.player2, &v0), 2);
            assert!(arg0.commitment2 == hash(arg1, arg2), 0);
            arg0.hand2 = arg1;
            arg0.salt2 = arg2;
        };
        if (arg0.hand1 != 0 && arg0.hand2 != 0) {
            arg0.state = 2;
            let v1 = GameRevealed{room_id: 0x2::object::id<GameRoom>(arg0)};
            0x2::event::emit<GameRevealed>(v1);
            settle(arg0, arg3);
        };
    }

    fun settle(arg0: &mut GameRoom, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = determine_winner(arg0.hand1, arg0.hand2, arg0.player1, arg0.player2);
        let v1 = borrow_pool(arg0.pool_id);
        let v2 = arg0.stake * 2;
        let (v3, v4) = if (0x1::option::is_some<address>(&v0)) {
            let v5 = v2 * 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::pool::fee_rate_bps<GameRoom>(v1) / 10000;
            (v2 - v5, v5)
        } else {
            let v6 = v2 * 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::pool::fee_rate_bps<GameRoom>(v1) / 20000;
            (arg0.stake - v6 / 2, v6)
        };
        if (0x1::option::is_some<address>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>>(0x2::coin::from_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(0x2::balance::split<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.escrow_balance, v3), arg1), 0x1::option::destroy_some<address>(v0));
            0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::pool::deposit<GameRoom>(v1, 0x2::coin::from_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(0x2::balance::split<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.escrow_balance, 0x2::balance::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg0.escrow_balance)), arg1));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>>(0x2::coin::from_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(0x2::balance::split<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.escrow_balance, v3), arg1), arg0.player1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>>(0x2::coin::from_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(0x2::balance::split<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.escrow_balance, 0x2::balance::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg0.escrow_balance)), arg1), *0x1::option::borrow<address>(&arg0.player2));
        };
        arg0.state = 3;
        let v7 = GameSettled{
            room_id : 0x2::object::id<GameRoom>(arg0),
            winner  : 0x1::option::none<address>(),
            fee     : v4,
        };
        0x2::event::emit<GameSettled>(v7);
    }

    public fun timeout(arg0: &mut GameRoom, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 0);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.created_at + 600000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>>(0x2::coin::from_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(0x2::balance::split<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.escrow_balance, 0x2::balance::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg0.escrow_balance)), arg2), arg0.player1);
        arg0.state = 4;
        let v0 = GameTimedOut{room_id: 0x2::object::id<GameRoom>(arg0)};
        0x2::event::emit<GameTimedOut>(v0);
    }

    // decompiled from Move bytecode v6
}

