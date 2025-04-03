module 0x2f569870c9211706499c6b5c6d1d20a858a03fc7cad09a555626d222e9843dac::firefly_swap {
    struct Bank has key {
        id: 0x2::object::UID,
        my_coin: 0x2::balance::Balance<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>,
        faucet: 0x2::balance::Balance<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_coin(arg0: &mut Bank, arg1: &mut 0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(arg1) >= arg2, 0);
        0x2::balance::join<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&mut arg0.my_coin, 0x2::balance::split<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(0x2::coin::balance_mut<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(arg1), arg2));
    }

    public entry fun deposit_faucet(arg0: &mut Bank, arg1: &mut 0x2::coin::Coin<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(arg1) >= arg2, 0);
        0x2::balance::join<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(&mut arg0.faucet, 0x2::balance::split<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(0x2::coin::balance_mut<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(arg1), arg2));
    }

    public entry fun faucet_to_my_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(&arg1) / 7;
        assert!(0x2::balance::value<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&arg0.my_coin) >= v0, 9223372436286734335);
        0x2::balance::join<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(&mut arg0.faucet, 0x2::coin::into_balance<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>>(0x2::coin::from_balance<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(0x2::balance::split<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&mut arg0.my_coin, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id      : 0x2::object::new(arg0),
            my_coin : 0x2::balance::zero<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(),
            faucet  : 0x2::balance::zero<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun my_coin_to_faucet(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&arg1) * 7;
        assert!(0x2::balance::value<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(&arg0.faucet) >= v0, 9223372354682355711);
        0x2::balance::join<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&mut arg0.my_coin, 0x2::coin::into_balance<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>>(0x2::coin::from_balance<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(0x2::balance::split<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(&mut arg0.faucet, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&arg1.my_coin) >= arg2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>>(0x2::coin::from_balance<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(0x2::balance::split<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&mut arg1.my_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_faucet(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(&arg1.faucet) >= arg2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>>(0x2::coin::from_balance<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(0x2::balance::split<0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet::KAMISAYAKA_FAUCET>(&mut arg1.faucet, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

