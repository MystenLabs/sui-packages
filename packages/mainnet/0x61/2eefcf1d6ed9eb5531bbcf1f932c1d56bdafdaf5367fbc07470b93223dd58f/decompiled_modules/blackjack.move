module 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack {
    struct Table has store, key {
        id: 0x2::object::UID,
        banker: address,
        banker_funds: 0x2::balance::Balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>,
        players: vector<PlayerInfo>,
        state: u8,
        pool_id: 0x2::object::ID,
    }

    struct PlayerInfo has store {
        player: address,
        bet: u64,
        cards: vector<u8>,
        points: u8,
        is_bust: bool,
    }

    struct GameResult has copy, drop {
        dummy_field: bool,
    }

    public fun banker(arg0: &Table) : address {
        arg0.banker
    }

    public fun banker_funds_value(arg0: &Table) : u64 {
        0x2::balance::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg0.banker_funds)
    }

    public fun create_table(arg0: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : Table {
        let v0 = if (arg2) {
            @0x0
        } else {
            0x2::tx_context::sender(arg3)
        };
        Table{
            id           : 0x2::object::new(arg3),
            banker       : v0,
            banker_funds : 0x2::coin::into_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(arg0),
            players      : 0x1::vector::empty<PlayerInfo>(),
            state        : 0,
            pool_id      : arg1,
        }
    }

    public fun deal(arg0: &mut Table, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public fun hit(arg0: &mut Table, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public fun join_table(arg0: &mut Table, arg1: u64, arg2: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 0);
        assert!(0x2::coin::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg2) == arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>>(arg2, 0x2::tx_context::sender(arg3));
        let v0 = PlayerInfo{
            player  : 0x2::tx_context::sender(arg3),
            bet     : arg1,
            cards   : b"",
            points  : 0,
            is_bust : false,
        };
        0x1::vector::push_back<PlayerInfo>(&mut arg0.players, v0);
    }

    public fun players_count(arg0: &Table) : u64 {
        0x1::vector::length<PlayerInfo>(&arg0.players)
    }

    public fun settle(arg0: &mut Table, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun stand(arg0: &mut Table, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

