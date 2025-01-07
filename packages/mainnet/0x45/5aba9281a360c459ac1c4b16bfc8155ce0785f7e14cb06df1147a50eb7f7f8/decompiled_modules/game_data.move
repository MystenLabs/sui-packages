module 0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data {
    struct GameData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>,
        creator: address,
        max_stake: u64,
        min_stake: u64,
        fees: 0x2::balance::Balance<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>,
    }

    struct GameCap has key {
        id: 0x2::object::UID,
    }

    struct GAME_DATA has drop {
        dummy_field: bool,
    }

    public(friend) fun borrow(arg0: &GameData) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut(arg0: &mut GameData) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun balance(arg0: &GameData) : u64 {
        0x2::balance::value<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(&arg0.balance)
    }

    public(friend) fun borrow_balance_mut(arg0: &mut GameData) : &mut 0x2::balance::Balance<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN> {
        &mut arg0.balance
    }

    public(friend) fun borrow_fees_mut(arg0: &mut GameData) : &mut 0x2::balance::Balance<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN> {
        &mut arg0.fees
    }

    public fun claim_fees(arg0: &mut GameData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == creator(arg0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>>(0x2::coin::take<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(&mut arg0.fees, fees(arg0), arg1), creator(arg0));
    }

    public fun creator(arg0: &GameData) : address {
        arg0.creator
    }

    public fun fees(arg0: &GameData) : u64 {
        0x2::balance::value<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(&arg0.fees)
    }

    fun init(arg0: GAME_DATA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<GAME_DATA>(arg0, arg1);
        let v0 = GameCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<GameCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_game_data(arg0: GameCap, arg1: 0x2::coin::Coin<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(&arg1) > 0, 1);
        let v0 = GameData{
            id        : 0x2::object::new(arg2),
            balance   : 0x2::coin::into_balance<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(arg1),
            creator   : 0x2::tx_context::sender(arg2),
            max_stake : 50000000000,
            min_stake : 100000000,
            fees      : 0x2::balance::zero<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(),
        };
        let GameCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<GameData>(v0);
    }

    public fun max_stake(arg0: &GameData) : u64 {
        arg0.max_stake
    }

    public fun min_stake(arg0: &GameData) : u64 {
        arg0.min_stake
    }

    public fun top_up(arg0: &mut GameData, arg1: 0x2::coin::Coin<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(&mut arg0.balance, arg1);
    }

    public fun withdraw(arg0: &mut GameData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == creator(arg0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>>(0x2::coin::take<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(&mut arg0.balance, balance(arg0), arg1), creator(arg0));
    }

    // decompiled from Move bytecode v6
}

