module 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::minigames {
    struct MinigamesConfig has key {
        id: 0x2::object::UID,
        min_bet: u64,
        max_bet: u64,
    }

    struct CoinFlipResult has copy, drop {
        player: address,
        bet_amount: u64,
        won: bool,
        payout: u64,
    }

    struct MinBetUpdated has copy, drop {
        old_min_bet: u64,
        new_min_bet: u64,
        updated_by: address,
    }

    struct MaxBetUpdated has copy, drop {
        old_max_bet: u64,
        new_max_bet: u64,
        updated_by: address,
    }

    public entry fun admin_update_max_bet(arg0: &0x2::package::Publisher, arg1: &mut MinigamesConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<MinigamesConfig>(arg0), 2);
        arg1.max_bet = arg2;
        let v0 = MaxBetUpdated{
            old_max_bet : arg1.max_bet,
            new_max_bet : arg2,
            updated_by  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MaxBetUpdated>(v0);
    }

    public entry fun admin_update_min_bet(arg0: &0x2::package::Publisher, arg1: &mut MinigamesConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<MinigamesConfig>(arg0), 2);
        arg1.min_bet = arg2;
        let v0 = MinBetUpdated{
            old_min_bet : arg1.min_bet,
            new_min_bet : arg2,
            updated_by  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MinBetUpdated>(v0);
    }

    entry fun coin_flip(arg0: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::config::GlobalConfig, arg1: &MinigamesConfig, arg2: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::MinigamesMintCap, arg3: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SharedTreasury, arg4: 0x2::coin::Coin<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SHTTOKEN>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::config::assert_version_and_feature(arg0, 11, 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::config::feature_coin_flip());
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SHTTOKEN>(&arg4);
        assert!(v1 >= arg1.min_bet, 1);
        assert!(v1 <= arg1.max_bet, 3);
        let v2 = 0x2::random::new_generator(arg5, arg6);
        if (0x2::random::generate_u64_in_range(&mut v2, 0, 99) < 50) {
            0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::burn(arg3, arg4);
            let v3 = v1 * 2;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SHTTOKEN>>(0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::mint_for_minigames(arg2, arg3, v3, arg6), v0);
            let v4 = CoinFlipResult{
                player     : v0,
                bet_amount : v1,
                won        : true,
                payout     : v3,
            };
            0x2::event::emit<CoinFlipResult>(v4);
        } else {
            0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::burn(arg3, arg4);
            let v5 = CoinFlipResult{
                player     : v0,
                bet_amount : v1,
                won        : false,
                payout     : 0,
            };
            0x2::event::emit<CoinFlipResult>(v5);
        };
    }

    public entry fun create_config(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<MinigamesConfig>(arg0), 2);
        let v0 = MinigamesConfig{
            id      : 0x2::object::new(arg1),
            min_bet : 1000000000000,
            max_bet : 1000000000000000,
        };
        0x2::transfer::share_object<MinigamesConfig>(v0);
    }

    public fun get_max_bet(arg0: &MinigamesConfig) : u64 {
        arg0.max_bet
    }

    public fun get_min_bet(arg0: &MinigamesConfig) : u64 {
        arg0.min_bet
    }

    // decompiled from Move bytecode v6
}

