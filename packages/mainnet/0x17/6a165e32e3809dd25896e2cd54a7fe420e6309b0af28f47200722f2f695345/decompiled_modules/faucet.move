module 0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::faucet {
    struct Faucet has key {
        id: 0x2::object::UID,
        coins: 0x2::bag::Bag,
        creator: address,
        admins: 0x2::vec_set::VecSet<address>,
    }

    public entry fun add_admin(arg0: &mut Faucet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
    }

    public entry fun add_supply<T0>(arg0: &mut Faucet, arg1: 0x2::coin::TreasuryCap<T0>) {
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Supply<T0>>(&mut arg0.coins, 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0x2::coin::treasury_into_supply<T0>(arg1));
    }

    public entry fun claim<T0>(arg0: &mut Faucet, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_coins<T0>(arg0, 1, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun force_add_liquidity(arg0: &mut Faucet, arg1: &mut 0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::implements::Global, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.creator == v0 || 0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        let v1 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::BTC>(arg0, 10000, arg2);
        let v2 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::ETH>(arg0, 100000, arg2);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::interface::add_liquidity<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::BTC, 0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::ETH>(arg1, v1, 1, v2, 1, arg2);
        let v3 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::BTC>(arg0, 10000, arg2);
        let v4 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDT>(arg0, 1000000, arg2);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::interface::add_liquidity<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::BTC, 0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDT>(arg1, v3, 1, v4, 1, arg2);
        let v5 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::ETH>(arg0, 100000, arg2);
        let v6 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDT>(arg0, 1000000, arg2);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::interface::add_liquidity<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::ETH, 0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDT>(arg1, v5, 1, v6, 1, arg2);
        let v7 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDC>(arg0, 1000000, arg2);
        let v8 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDT>(arg0, 1000000, arg2);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::interface::add_liquidity<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDC, 0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDT>(arg1, v7, 1, v8, 1, arg2);
        let v9 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::BNB>(arg0, 100000, arg2);
        let v10 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDT>(arg0, 1000000, arg2);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::interface::add_liquidity<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::BNB, 0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDT>(arg1, v9, 1, v10, 1, arg2);
        let v11 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::BNB>(arg0, 100000, arg2);
        let v12 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDC>(arg0, 1000000, arg2);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::interface::add_liquidity<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::BNB, 0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDC>(arg1, v11, 1, v12, 1, arg2);
        let v13 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::DAI>(arg0, 1000000, arg2);
        let v14 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDC>(arg0, 1000000, arg2);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::interface::add_liquidity<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::DAI, 0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::USDC>(arg1, v13, 1, v14, 1, arg2);
        let v15 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::BTC>(arg0, 10000, arg2);
        let v16 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::DAI>(arg0, 1000000, arg2);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::interface::add_liquidity<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::BTC, 0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::DAI>(arg1, v15, 1, v16, 1, arg2);
        let v17 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::DAI>(arg0, 1000000, arg2);
        let v18 = mint_coins<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::ETH>(arg0, 100000, arg2);
        0x4a6dc5db87823ca5a9bf338e5e1b366afd15ff3f3363c14625f8187870669933::interface::add_liquidity<0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::DAI, 0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::ETH>(arg1, v17, 1, v18, 1, arg2);
    }

    public entry fun force_claim<T0>(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.creator == v0 || 0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(mint_coins<T0>(arg0, arg1, arg2), v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, @0xc05eaaf1369ece51ce0b8ad5cb797b737d4f2eba);
        let v1 = Faucet{
            id      : 0x2::object::new(arg0),
            coins   : 0x176a165e32e3809dd25896e2cd54a7fe420e6309b0af28f47200722f2f695345::coins::get_coins(arg0),
            creator : 0x2::tx_context::sender(arg0),
            admins  : v0,
        };
        0x2::transfer::share_object<Faucet>(v1);
    }

    fun mint_coins<T0>(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::bag::contains_with_type<0x1::ascii::String, 0x2::balance::Supply<T0>>(&arg0.coins, v0), 2);
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Supply<T0>>(&mut arg0.coins, v0), arg1 * 100000000), arg2)
    }

    public entry fun remove_admin(arg0: &mut Faucet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
    }

    // decompiled from Move bytecode v6
}

