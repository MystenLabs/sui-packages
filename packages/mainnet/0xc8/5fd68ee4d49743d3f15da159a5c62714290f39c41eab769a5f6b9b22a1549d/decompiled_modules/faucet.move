module 0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::faucet {
    struct Faucet has key {
        id: 0x2::object::UID,
        coins: 0x2::bag::Bag,
        coin_decimals: 0x2::bag::Bag,
        creator: address,
        admins: 0x2::vec_set::VecSet<address>,
    }

    public entry fun add_admin(arg0: &mut Faucet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
    }

    public entry fun claim<T0>(arg0: &mut Faucet, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(extract_coins<T0>(arg0, 100, arg1), v0);
    }

    fun extract_coins<T0>(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::bag::contains_with_type<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.coins, v0), 2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.coins, v0), arg1 * get_coin_unit(*0x2::bag::borrow<0x1::ascii::String, u8>(&mut arg0.coin_decimals, v0))), arg2)
    }

    public entry fun force_add_liquidity(arg0: &mut Faucet, arg1: &mut 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::implements::Global, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.creator == v0 || 0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        let v1 = extract_coins<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_btc::TEST_BTC>(arg0, 1000, arg2);
        let v2 = extract_coins<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_eth::TEST_ETH>(arg0, 10000, arg2);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::interface::add_liquidity<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_btc::TEST_BTC, 0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_eth::TEST_ETH>(arg1, v1, 1, v2, 1, arg2);
        let v3 = extract_coins<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_btc::TEST_BTC>(arg0, 100, arg2);
        let v4 = extract_coins<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdt::TEST_USDT>(arg0, 10000, arg2);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::interface::add_liquidity<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_btc::TEST_BTC, 0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdt::TEST_USDT>(arg1, v3, 1, v4, 1, arg2);
        let v5 = extract_coins<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_eth::TEST_ETH>(arg0, 1000, arg2);
        let v6 = extract_coins<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdt::TEST_USDT>(arg0, 10000, arg2);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::interface::add_liquidity<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_eth::TEST_ETH, 0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdt::TEST_USDT>(arg1, v5, 1, v6, 1, arg2);
        let v7 = extract_coins<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdc::TEST_USDC>(arg0, 10000, arg2);
        let v8 = extract_coins<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdt::TEST_USDT>(arg0, 10000, arg2);
        0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::interface::add_liquidity<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdc::TEST_USDC, 0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdt::TEST_USDT>(arg1, v7, 1, v8, 1, arg2);
    }

    public entry fun force_claim<T0>(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.creator == v0 || 0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(extract_coins<T0>(arg0, arg1, arg2), v0);
    }

    public fun get_coin_unit(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, @0x789ee4711cd92c4896c990a46e9bf2c9df189f4a274e54f56793af6aef271a00);
        let v1 = Faucet{
            id            : 0x2::object::new(arg0),
            coins         : 0x2::bag::new(arg0),
            coin_decimals : 0x2::bag::new(arg0),
            creator       : 0x2::tx_context::sender(arg0),
            admins        : v0,
        };
        0x2::transfer::share_object<Faucet>(v1);
    }

    public entry fun init_mint(arg0: &mut 0x2::coin::TreasuryCap<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_btc::TEST_BTC>, arg1: &mut 0x2::coin::TreasuryCap<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_eth::TEST_ETH>, arg2: &mut 0x2::coin::TreasuryCap<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdc::TEST_USDC>, arg3: &mut 0x2::coin::TreasuryCap<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdt::TEST_USDT>, arg4: &mut Faucet) {
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_btc::TEST_BTC>>(&mut arg4.coins, 0x1::type_name::into_string(0x1::type_name::get<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_btc::TEST_BTC>()), 0x2::coin::mint_balance<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_btc::TEST_BTC>(arg0, 184467440737095516));
        0x2::bag::add<0x1::ascii::String, u8>(&mut arg4.coin_decimals, 0x1::type_name::into_string(0x1::type_name::get<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_btc::TEST_BTC>()), 8);
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_eth::TEST_ETH>>(&mut arg4.coins, 0x1::type_name::into_string(0x1::type_name::get<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_eth::TEST_ETH>()), 0x2::coin::mint_balance<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_eth::TEST_ETH>(arg1, 184467440737095516));
        0x2::bag::add<0x1::ascii::String, u8>(&mut arg4.coin_decimals, 0x1::type_name::into_string(0x1::type_name::get<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_eth::TEST_ETH>()), 6);
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdc::TEST_USDC>>(&mut arg4.coins, 0x1::type_name::into_string(0x1::type_name::get<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdc::TEST_USDC>()), 0x2::coin::mint_balance<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdc::TEST_USDC>(arg2, 184467440737095516));
        0x2::bag::add<0x1::ascii::String, u8>(&mut arg4.coin_decimals, 0x1::type_name::into_string(0x1::type_name::get<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdc::TEST_USDC>()), 4);
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdt::TEST_USDT>>(&mut arg4.coins, 0x1::type_name::into_string(0x1::type_name::get<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdt::TEST_USDT>()), 0x2::coin::mint_balance<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdt::TEST_USDT>(arg3, 184467440737095516));
        0x2::bag::add<0x1::ascii::String, u8>(&mut arg4.coin_decimals, 0x1::type_name::into_string(0x1::type_name::get<0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_usdt::TEST_USDT>()), 10);
    }

    public entry fun remove_admin(arg0: &mut Faucet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
    }

    // decompiled from Move bytecode v6
}

