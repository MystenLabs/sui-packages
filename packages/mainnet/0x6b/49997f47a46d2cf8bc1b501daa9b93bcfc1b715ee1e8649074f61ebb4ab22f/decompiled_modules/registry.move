module 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry {
    struct GameRegistration has store, key {
        id: 0x2::object::UID,
        game_type_id: u64,
        game_name: vector<u8>,
        theoretical_rtp_bps: u64,
        max_payout_per_round: u64,
        registered_by: address,
    }

    public fun game_name(arg0: &GameRegistration) : &vector<u8> {
        &arg0.game_name
    }

    public fun game_type_id(arg0: &GameRegistration) : u64 {
        arg0.game_type_id
    }

    public fun get_game_metadata(arg0: &GameRegistration) : (u64, vector<u8>, u64) {
        (arg0.game_type_id, arg0.game_name, arg0.theoretical_rtp_bps)
    }

    public fun id_of(arg0: &GameRegistration) : 0x2::object::ID {
        0x2::object::id<GameRegistration>(arg0)
    }

    public fun max_payout_per_round(arg0: &GameRegistration) : u64 {
        arg0.max_payout_per_round
    }

    public fun register_game<T0: drop>(arg0: T0, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : GameRegistration {
        assert!(arg1 > 0, 402);
        assert!(arg3 > 0 && arg3 <= 20000, 400);
        assert!(arg4 > 0, 401);
        GameRegistration{
            id                   : 0x2::object::new(arg5),
            game_type_id         : arg1,
            game_name            : arg2,
            theoretical_rtp_bps  : arg3,
            max_payout_per_round : arg4,
            registered_by        : 0x2::tx_context::sender(arg5),
        }
    }

    public fun registered_by(arg0: &GameRegistration) : address {
        arg0.registered_by
    }

    public fun theoretical_rtp_bps(arg0: &GameRegistration) : u64 {
        arg0.theoretical_rtp_bps
    }

    // decompiled from Move bytecode v7
}

