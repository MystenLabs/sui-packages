module 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::registry {
    struct GameInfo has copy, drop, store {
        game_type: vector<u8>,
        module_address: address,
        name: vector<u8>,
        fee_rate_bps: u64,
        enabled: bool,
    }

    struct GameRegistry has key {
        id: 0x2::object::UID,
        games: 0x2::table::Table<vector<u8>, GameInfo>,
    }

    struct GameResultEvent has copy, drop {
        game_type: vector<u8>,
        players: vector<address>,
        winners: vector<address>,
        amounts: vector<u64>,
        fee: u64,
        timestamp: u64,
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) : GameRegistry {
        GameRegistry{
            id    : 0x2::object::new(arg0),
            games : 0x2::table::new<vector<u8>, GameInfo>(arg0),
        }
    }

    public fun get_game_info(arg0: &GameRegistry, arg1: vector<u8>) : 0x1::option::Option<GameInfo> {
        if (0x2::table::contains<vector<u8>, GameInfo>(&arg0.games, arg1)) {
            0x1::option::some<GameInfo>(*0x2::table::borrow<vector<u8>, GameInfo>(&arg0.games, arg1))
        } else {
            0x1::option::none<GameInfo>()
        }
    }

    public fun register_game(arg0: &mut GameRegistry, arg1: GameInfo, arg2: &0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::AdminCap) {
        0x2::table::add<vector<u8>, GameInfo>(&mut arg0.games, arg1.game_type, arg1);
    }

    // decompiled from Move bytecode v6
}

