module 0x334d46ed6eb6f4fe21e290425f73fbecb018e41ecfdfde810f62b60329efc440::nba_nft {
    struct NBANft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        team_id: u8,
        team_name: 0x1::string::String,
        tier: u8,
        token_id: u64,
        minted_at: u64,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        admin: address,
        reward_pool: 0x2::object::ID,
        marketing_wallet: address,
        dev_wallet: address,
        team_supply: 0x2::table::Table<u8, u64>,
        team_limits: 0x2::table::Table<u8, u64>,
        total_minted: u64,
        is_minting_enabled: bool,
        mint_price: u64,
        pool_percentage: u64,
        marketing_percentage: u64,
        dev_percentage: u64,
        max_supply: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        team_id: u8,
        tier: u8,
        token_id: u64,
        timestamp: u64,
    }

    struct PaymentDistributed has copy, drop {
        total: u64,
        to_pool: u64,
        to_marketing: u64,
        to_dev: u64,
    }

    public fun get_team_id(arg0: &NBANft) : u8 {
        arg0.team_id
    }

    public fun get_team_limit(arg0: &MintConfig, arg1: u8) : u64 {
        if (0x2::table::contains<u8, u64>(&arg0.team_limits, arg1)) {
            *0x2::table::borrow<u8, u64>(&arg0.team_limits, arg1)
        } else {
            0
        }
    }

    public fun get_team_supply(arg0: &MintConfig, arg1: u8) : u64 {
        if (0x2::table::contains<u8, u64>(&arg0.team_supply, arg1)) {
            *0x2::table::borrow<u8, u64>(&arg0.team_supply, arg1)
        } else {
            0
        }
    }

    public fun get_tier(arg0: &NBANft) : u8 {
        arg0.tier
    }

    public fun get_token_id(arg0: &NBANft) : u64 {
        arg0.token_id
    }

    public fun get_total_minted(arg0: &MintConfig) : u64 {
        arg0.total_minted
    }

    public fun initialize(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = MintConfig{
            id                   : 0x2::object::new(arg3),
            admin                : v0,
            reward_pool          : arg0,
            marketing_wallet     : arg1,
            dev_wallet           : arg2,
            team_supply          : 0x2::table::new<u8, u64>(arg3),
            team_limits          : 0x2::table::new<u8, u64>(arg3),
            total_minted         : 0,
            is_minting_enabled   : true,
            mint_price           : 10000000000,
            pool_percentage      : 80,
            marketing_percentage : 15,
            dev_percentage       : 5,
            max_supply           : 100000,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::share_object<MintConfig>(v1);
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun is_minting_enabled(arg0: &MintConfig) : bool {
        arg0.is_minting_enabled
    }

    public fun mint_nft(arg0: &mut MintConfig, arg1: &AdminCap, arg2: &mut 0x334d46ed6eb6f4fe21e290425f73fbecb018e41ecfdfde810f62b60329efc440::reward_pool::RewardPool, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u8, arg5: vector<u8>, arg6: u8, arg7: vector<u8>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.admin, 4);
        assert!(arg0.is_minting_enabled, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg0.mint_price, 1);
        assert!(arg0.total_minted < arg0.max_supply, 6);
        let v0 = get_team_supply(arg0, arg4);
        assert!(v0 < get_team_limit(arg0, arg4), 3);
        let v1 = arg0.mint_price * arg0.pool_percentage / 100;
        let v2 = arg0.mint_price * arg0.marketing_percentage / 100;
        0x334d46ed6eb6f4fe21e290425f73fbecb018e41ecfdfde810f62b60329efc440::reward_pool::add_funds(arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2, arg9), arg0.marketing_wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.dev_wallet);
        let v3 = PaymentDistributed{
            total        : arg0.mint_price,
            to_pool      : v1,
            to_marketing : v2,
            to_dev       : arg0.mint_price * arg0.dev_percentage / 100,
        };
        0x2::event::emit<PaymentDistributed>(v3);
        arg0.total_minted = arg0.total_minted + 1;
        if (0x2::table::contains<u8, u64>(&arg0.team_supply, arg4)) {
            0x2::table::remove<u8, u64>(&mut arg0.team_supply, arg4);
        };
        0x2::table::add<u8, u64>(&mut arg0.team_supply, arg4, v0 + 1);
        let v4 = arg0.total_minted;
        let v5 = 0x2::object::new(arg9);
        let v6 = NBANft{
            id          : v5,
            name        : 0x1::string::utf8(b"NBA Rewards NFT #"),
            description : 0x1::string::utf8(b"NBA 2024-2025 Season Rewards NFT"),
            url         : 0x2::url::new_unsafe_from_bytes(arg7),
            team_id     : arg4,
            team_name   : 0x1::string::utf8(arg5),
            tier        : arg6,
            token_id    : v4,
            minted_at   : 0x2::tx_context::epoch(arg9),
        };
        let v7 = NFTMinted{
            nft_id    : 0x2::object::uid_to_inner(&v5),
            owner     : arg8,
            team_id   : arg4,
            tier      : arg6,
            token_id  : v4,
            timestamp : 0x2::tx_context::epoch(arg9),
        };
        0x2::event::emit<NFTMinted>(v7);
        0x2::transfer::public_transfer<NBANft>(v6, arg8);
    }

    public fun set_dev_percentage(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.dev_percentage = arg2;
    }

    public fun set_marketing_percentage(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.marketing_percentage = arg2;
    }

    public fun set_max_supply(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.max_supply = arg2;
    }

    public fun set_mint_price(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.mint_price = arg2;
    }

    public fun set_minting_enabled(arg0: &mut MintConfig, arg1: &AdminCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.is_minting_enabled = arg2;
    }

    public fun set_pool_percentage(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.pool_percentage = arg2;
    }

    public fun set_team_limit(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 4);
        if (0x2::table::contains<u8, u64>(&arg0.team_limits, arg2)) {
            0x2::table::remove<u8, u64>(&mut arg0.team_limits, arg2);
        };
        0x2::table::add<u8, u64>(&mut arg0.team_limits, arg2, arg3);
    }

    public fun withdraw_pool_funds(arg0: &MintConfig, arg1: &AdminCap, arg2: &mut 0x334d46ed6eb6f4fe21e290425f73fbecb018e41ecfdfde810f62b60329efc440::reward_pool::RewardPool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        0x334d46ed6eb6f4fe21e290425f73fbecb018e41ecfdfde810f62b60329efc440::reward_pool::withdraw_all(arg2, arg0.admin, arg3);
    }

    // decompiled from Move bytecode v6
}

