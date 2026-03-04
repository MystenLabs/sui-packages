module 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::lobby {
    struct Lobby has key {
        id: 0x2::object::UID,
        active_bj_tables: vector<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>,
        max_players_per_table: u64,
        platform_funds: 0x2::balance::Balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>,
        banker_seed_per_table: u64,
        pool_id: 0x2::object::ID,
    }

    struct PlayerJoinedTable has copy, drop {
        lobby_id: 0x2::object::ID,
        table_index: u64,
        player: address,
        bet: u64,
    }

    struct PlatformTableCreated has copy, drop {
        lobby_id: 0x2::object::ID,
        table_index: u64,
    }

    struct PlayerTableCreated has copy, drop {
        lobby_id: 0x2::object::ID,
        table_index: u64,
        banker: address,
    }

    public fun active_table_count(arg0: &Lobby) : u64 {
        0x1::vector::length<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&arg0.active_bj_tables)
    }

    public fun add_platform_funds(arg0: &mut Lobby, arg1: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>) {
        0x2::balance::join<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.platform_funds, 0x2::coin::into_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(arg1));
    }

    public fun create_lobby(arg0: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Lobby {
        Lobby{
            id                    : 0x2::object::new(arg4),
            active_bj_tables      : 0x1::vector::empty<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(),
            max_players_per_table : arg2,
            platform_funds        : 0x2::coin::into_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(arg0),
            banker_seed_per_table : arg3,
            pool_id               : arg1,
        }
    }

    public fun create_platform_table(arg0: &mut Lobby, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg0.platform_funds) >= arg0.banker_seed_per_table, 1);
        0x1::vector::push_back<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&mut arg0.active_bj_tables, 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::create_table(0x2::coin::from_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(0x2::balance::split<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.platform_funds, arg0.banker_seed_per_table), arg1), arg0.pool_id, true, arg1));
        let v0 = PlatformTableCreated{
            lobby_id    : 0x2::object::id<Lobby>(arg0),
            table_index : 0x1::vector::length<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&arg0.active_bj_tables) - 1,
        };
        0x2::event::emit<PlatformTableCreated>(v0);
    }

    public fun create_player_table(arg0: &mut Lobby, arg1: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&mut arg0.active_bj_tables, 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::create_table(arg1, arg0.pool_id, false, arg2));
        let v0 = PlayerTableCreated{
            lobby_id    : 0x2::object::id<Lobby>(arg0),
            table_index : 0x1::vector::length<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&arg0.active_bj_tables) - 1,
            banker      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PlayerTableCreated>(v0);
    }

    fun find_available_bj_table(arg0: &Lobby) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&arg0.active_bj_tables)) {
            if (0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::players_count(0x1::vector::borrow<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&arg0.active_bj_tables, v0)) < arg0.max_players_per_table) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun get_table_info(arg0: &Lobby, arg1: u64) : (address, u64, u64) {
        let v0 = 0x1::vector::borrow<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&arg0.active_bj_tables, arg1);
        (0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::banker(v0), 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::banker_funds_value(v0), 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::players_count(v0))
    }

    public fun join_blackjack(arg0: &mut Lobby, arg1: u64, arg2: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg2) == arg1, 0);
        let v0 = find_available_bj_table(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            assert!(0x2::balance::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg0.platform_funds) >= arg0.banker_seed_per_table, 1);
            0x1::vector::push_back<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&mut arg0.active_bj_tables, 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::create_table(0x2::coin::from_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(0x2::balance::split<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.platform_funds, arg0.banker_seed_per_table), arg3), arg0.pool_id, true, arg3));
            let v1 = 0x1::vector::length<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&arg0.active_bj_tables) - 1;
            let v2 = PlatformTableCreated{
                lobby_id    : 0x2::object::id<Lobby>(arg0),
                table_index : v1,
            };
            0x2::event::emit<PlatformTableCreated>(v2);
            0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::join_table(0x1::vector::borrow_mut<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&mut arg0.active_bj_tables, v1), arg1, arg2, arg3);
            let v3 = PlayerJoinedTable{
                lobby_id    : 0x2::object::id<Lobby>(arg0),
                table_index : v1,
                player      : 0x2::tx_context::sender(arg3),
                bet         : arg1,
            };
            0x2::event::emit<PlayerJoinedTable>(v3);
        } else {
            let v4 = 0x1::option::destroy_some<u64>(v0);
            0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::join_table(0x1::vector::borrow_mut<0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::blackjack::Table>(&mut arg0.active_bj_tables, v4), arg1, arg2, arg3);
            let v5 = PlayerJoinedTable{
                lobby_id    : 0x2::object::id<Lobby>(arg0),
                table_index : v4,
                player      : 0x2::tx_context::sender(arg3),
                bet         : arg1,
            };
            0x2::event::emit<PlayerJoinedTable>(v5);
        };
    }

    public fun platform_funds_balance(arg0: &Lobby) : u64 {
        0x2::balance::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg0.platform_funds)
    }

    // decompiled from Move bytecode v6
}

