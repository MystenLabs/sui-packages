module 0xb4b859859db00a2d6b3d981e2dd32272fa11903d35edf913f2d6149ae1f3b032::coin_flip {
    struct NewGame has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        user_randomness: vector<u8>,
        guess: u8,
        stake: u64,
        fee_bp: u16,
    }

    struct Outcome has copy, drop {
        game_id: 0x2::object::ID,
        player_won: bool,
        challenged: bool,
    }

    struct HouseData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        house: address,
        public_key: vector<u8>,
        max_stake: u64,
        min_stake: u64,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        base_fee_in_bp: u16,
        reduced_fee_in_bp: u16,
    }

    struct Game has key {
        id: 0x2::object::UID,
        guess_placed_epoch: u64,
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        guess: u8,
        player: address,
        user_randomness: vector<u8>,
        fee_bp: u16,
        challenged: bool,
    }

    struct HouseCap has key {
        id: 0x2::object::UID,
    }

    struct Outcomee has copy, drop {
        player_won: bool,
        hashed_beacon_v: vector<u8>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HouseCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun playy(arg0: vector<u8>) {
        let v0 = 0x2::hash::blake2b256(&arg0);
        let v1 = Outcomee{
            player_won      : 1 == *0x1::vector::borrow<u8>(&v0, 0) % 2,
            hashed_beacon_v : v0,
        };
        0x2::event::emit<Outcomee>(v1);
    }

    // decompiled from Move bytecode v6
}

