module 0x9dee854a82801fbb77a0c079cf3aeb2b8a21a9301c8c22012258d12319537f86::maybeok_game {
    struct Game has key {
        id: 0x2::object::UID,
        amt: 0x2::balance::Balance<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_maybeok(arg0: &mut Game, arg1: 0x2::coin::Coin<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(&mut arg0.amt, 0x2::coin::into_balance<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            amt : 0x2::balance::zero<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Game>(v0);
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(&arg3);
        assert!(0x2::balance::value<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(&arg0.amt) > v0 * 10, 0);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>>(0x2::coin::from_balance<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(0x2::balance::split<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(&mut arg0.amt, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(&mut arg0.amt, 0x2::coin::into_balance<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(arg3));
        };
    }

    public entry fun remove_maybeok(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(&arg1.amt) > arg2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>>(0x2::coin::from_balance<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(0x2::balance::split<0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet::MAYBEOK_FAUCET>(&mut arg1.amt, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

