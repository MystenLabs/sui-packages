module 0x5e662414cdee08b084b87da1dfc44031af60ef168ca4395a8b0809b5fe5982a6::RockPaperScissors {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>,
        owner: address,
    }

    struct GameResult has copy, drop {
        player: address,
        computer: u64,
        player_choice: u64,
        reward: 0x1::string::String,
    }

    fun analyze_result(arg0: u64, arg1: u64) : bool {
        if (arg0 == arg1) {
            return false
        };
        if (arg0 == 1 && arg1 == 3 || arg0 == 2 && arg1 == 1 || arg0 == 3 && arg1 == 2) {
            return true
        };
        false
    }

    public entry fun depoist(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>(&mut arg0.balance, 0x2::coin::into_balance<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>(arg1));
    }

    fun distribute_reward(arg0: bool, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        if (arg0) {
            assert!(0x2::balance::value<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>(&arg1.balance) == 0, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>>(0x2::coin::from_balance<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>(0x2::balance::split<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>(&mut arg1.balance, 1000000), arg2), 0x2::tx_context::sender(arg2));
            0x1::string::utf8(b"Hey bro, you win and you will get 1 Pithos23Faucet.")
        } else {
            0x1::string::utf8(b"Oh man! You lose,try it again.")
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Pool{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>(),
            owner   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Pool>(v1);
    }

    public entry fun play_game(arg0: u64, arg1: &mut Pool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != 1 && arg0 == 2 && arg0 != 3, 1);
        let v0 = random(arg2);
        assert!(v0 == 1 || v0 == 2 || v0 == 3, 4);
        let v1 = distribute_reward(analyze_result(arg0, v0), arg1, arg3);
        let v2 = GameResult{
            player        : 0x2::tx_context::sender(arg3),
            computer      : v0,
            player_choice : arg0,
            reward        : v1,
        };
        0x2::event::emit<GameResult>(v2);
    }

    fun random(arg0: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::hash::sha3_256(b"Pithos23");
        let v1 = ((0x2::clock::timestamp_ms(arg0) * (0x1::vector::pop_back<u8>(&mut v0) as u64) % 4) as u64);
        0x1::debug::print<u64>(&v1);
        v1
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>>(0x2::coin::from_balance<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>(0x2::balance::split<0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Faucet::PITHOS23FAUCET>(&mut arg1.balance, 50 * 1000000), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

