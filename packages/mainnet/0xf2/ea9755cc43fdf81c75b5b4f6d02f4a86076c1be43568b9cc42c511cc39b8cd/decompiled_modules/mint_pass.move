module 0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::mint_pass {
    struct MintConfig has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        liquidity_reserve: address,
        dev: address,
        wallet_mints: 0x2::table::Table<address, u64>,
        total_minted: u64,
        paused: bool,
    }

    struct MintInfo has copy, drop {
        mint_price: u64,
        max_per_wallet: u64,
        max_per_player: u64,
        total_minted: u64,
        wallet_minted: u64,
        paused: bool,
    }

    struct PublicMint has copy, drop {
        card_id: 0x2::object::ID,
        player_id: u64,
        buyer: address,
        price: u64,
    }

    public fun get_mint_info(arg0: &MintConfig, arg1: address) : MintInfo {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.wallet_mints, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.wallet_mints, arg1)
        } else {
            0
        };
        MintInfo{
            mint_price     : 5000000,
            max_per_wallet : 5,
            max_per_player : 40,
            total_minted   : arg0.total_minted,
            wallet_minted  : v0,
            paused         : arg0.paused,
        }
    }

    public fun info_paused(arg0: &MintInfo) : bool {
        arg0.paused
    }

    public fun info_price(arg0: &MintInfo) : u64 {
        arg0.mint_price
    }

    public fun info_total_minted(arg0: &MintInfo) : u64 {
        arg0.total_minted
    }

    public fun info_wallet_minted(arg0: &MintInfo) : u64 {
        arg0.wallet_minted
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = MintConfig{
            id                : 0x2::object::new(arg0),
            admin             : v0,
            treasury          : v0,
            liquidity_reserve : v0,
            dev               : v0,
            wallet_mints      : 0x2::table::new<address, u64>(arg0),
            total_minted      : 0,
            paused            : false,
        };
        0x2::transfer::share_object<MintConfig>(v1);
    }

    public fun mint_card(arg0: &mut MintConfig, arg1: &mut 0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::MintRegistry, arg2: &mut 0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::reward_distributor::RewardPool, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u8, arg16: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg16) >= 5000000, 0);
        let v0 = 0x2::tx_context::sender(arg18);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.wallet_mints, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.wallet_mints, v0)
        } else {
            0
        };
        assert!(v1 < 5, 1);
        assert!(0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::minted_count(arg1, arg3) < 40, 2);
        let v2 = 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg16, 5000000, arg18);
        let v3 = 5000000 * 5000 / 10000;
        let v4 = 5000000 * 2500 / 10000;
        0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::reward_distributor::deposit(arg2, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v2, v3, arg18));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v2, v4, arg18), arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v2, 5000000 * 1500 / 10000, arg18), arg0.liquidity_reserve);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v2, arg0.dev);
        if (0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg16) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg16, v0);
        } else {
            0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg16);
        };
        0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::increment_registry(arg1, arg3);
        if (0x2::table::contains<address, u64>(&arg0.wallet_mints, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.wallet_mints, v0) = v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.wallet_mints, v0, 1);
        };
        arg0.total_minted = arg0.total_minted + 1;
        let v5 = 0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::create_card(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 5000000, arg17, arg18);
        let v6 = PublicMint{
            card_id   : 0x2::object::id<0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(&v5),
            player_id : arg3,
            buyer     : v0,
            price     : 5000000,
        };
        0x2::event::emit<PublicMint>(v6);
        0x2::transfer::public_transfer<0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(v5, v0);
    }

    public fun set_destinations(arg0: &mut MintConfig, arg1: address, arg2: address, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 3);
        arg0.treasury = arg1;
        arg0.liquidity_reserve = arg2;
        arg0.dev = arg3;
    }

    public fun set_paused(arg0: &mut MintConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v7
}

