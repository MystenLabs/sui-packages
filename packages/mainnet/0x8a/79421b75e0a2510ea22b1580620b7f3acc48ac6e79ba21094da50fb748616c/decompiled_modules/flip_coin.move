module 0x8a79421b75e0a2510ea22b1580620b7f3acc48ac6e79ba21094da50fb748616c::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        value: 0x2::balance::Balance<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_coin(arg0: &mut Game, arg1: 0x2::coin::Coin<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>(&mut arg0.value, 0x2::coin::into_balance<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id    : 0x2::object::new(arg0),
            value : 0x2::balance::zero<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>(&arg3);
        if (0x2::balance::value<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>(&arg0.value) >= v0 * 10) {
            abort 273
        };
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>>(arg3, 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>>(0x2::coin::from_balance<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>(0x2::balance::split<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>(&mut arg0.value, v0), arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>(&mut arg0.value, 0x2::coin::into_balance<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>(arg3));
        };
    }

    public entry fun remove_coin(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>>(0x2::coin::from_balance<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>(0x2::balance::split<0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet::HANDSOMEPUDDINGFAUCET>(&mut arg1.value, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

