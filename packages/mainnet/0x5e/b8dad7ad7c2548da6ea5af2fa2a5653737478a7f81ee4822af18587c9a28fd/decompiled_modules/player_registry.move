module 0x5eb8dad7ad7c2548da6ea5af2fa2a5653737478a7f81ee4822af18587c9a28fd::player_registry {
    struct Registry has key {
        id: 0x2::object::UID,
        next_player_id: u64,
        players: 0x2::table::Table<address, PlayerInfo>,
        id_to_address: 0x2::table::Table<u64, address>,
        address_to_id: 0x2::table::Table<address, u64>,
    }

    struct PlayerInfo has store {
        id: u64,
        address: address,
        referrer_id: u64,
        registration_time: u64,
        games_joined: vector<u8>,
        referral_count: u64,
        miner_deposit: u64,
        jackpot_deposit: u64,
    }

    public fun get_jackpot_deposit(arg0: &Registry, arg1: address) : u64 {
        0x2::table::borrow<address, PlayerInfo>(&arg0.players, arg1).jackpot_deposit
    }

    public fun get_jackpot_game_id() : u8 {
        2
    }

    public fun get_miner_deposit(arg0: &Registry, arg1: address) : u64 {
        0x2::table::borrow<address, PlayerInfo>(&arg0.players, arg1).miner_deposit
    }

    public fun get_miner_game_id() : u8 {
        1
    }

    public fun get_player_address(arg0: &Registry, arg1: u64) : address {
        *0x2::table::borrow<u64, address>(&arg0.id_to_address, arg1)
    }

    public fun get_player_id(arg0: &Registry, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.address_to_id, arg1)
    }

    public fun get_player_referrer(arg0: &Registry, arg1: u64) : u64 {
        0x2::table::borrow<address, PlayerInfo>(&arg0.players, *0x2::table::borrow<u64, address>(&arg0.id_to_address, arg1)).referrer_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg0),
            next_player_id : 1,
            players        : 0x2::table::new<address, PlayerInfo>(arg0),
            id_to_address  : 0x2::table::new<u64, address>(arg0),
            address_to_id  : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_valid_referrer(arg0: &Registry, arg1: u64) : bool {
        0x2::table::contains<u64, address>(&arg0.id_to_address, arg1)
    }

    public fun register_player(arg0: &mut Registry, arg1: address, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, PlayerInfo>(&arg0.players, arg1)) {
            let v1 = arg0.next_player_id;
            arg0.next_player_id = arg0.next_player_id + 1;
            let v2 = PlayerInfo{
                id                : v1,
                address           : arg1,
                referrer_id       : arg2,
                registration_time : 0x2::clock::timestamp_ms(arg4),
                games_joined      : 0x1::vector::empty<u8>(),
                referral_count    : 0,
                miner_deposit     : 0,
                jackpot_deposit   : 0,
            };
            0x1::vector::push_back<u8>(&mut v2.games_joined, arg3);
            0x2::table::add<address, PlayerInfo>(&mut arg0.players, arg1, v2);
            0x2::table::add<u64, address>(&mut arg0.id_to_address, v1, arg1);
            0x2::table::add<address, u64>(&mut arg0.address_to_id, arg1, v1);
            if (arg2 != 0 && 0x2::table::contains<u64, address>(&arg0.id_to_address, arg2)) {
                let v3 = 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg0.players, *0x2::table::borrow<u64, address>(&arg0.id_to_address, arg2));
                v3.referral_count = v3.referral_count + 1;
            };
            v1
        } else {
            let v4 = 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg0.players, arg1);
            if (!0x1::vector::contains<u8>(&v4.games_joined, &arg3)) {
                0x1::vector::push_back<u8>(&mut v4.games_joined, arg3);
            };
            v4.id
        }
    }

    public fun update_jackpot_deposit(arg0: &mut Registry, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg0.players, arg1);
        v0.jackpot_deposit = v0.jackpot_deposit + arg2;
    }

    public fun update_miner_deposit(arg0: &mut Registry, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg0.players, arg1);
        v0.miner_deposit = v0.miner_deposit + arg2;
    }

    // decompiled from Move bytecode v6
}

