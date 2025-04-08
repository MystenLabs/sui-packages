module 0x5974a2418e894e79264a8854dea83c9d2f5e98a36754bcb58cbad3afa931ccfd::last_alive {
    struct CoinField<phantom T0> has store {
        value: 0x2::coin::Coin<T0>,
    }

    struct NftField<T0: store + key> has store {
        value: T0,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PrizePool has key {
        id: 0x2::object::UID,
        winning_nft_id: 0x1::option::Option<0x2::object::ID>,
        admin: address,
        prize_count: u64,
        game_round: u64,
        indices: vector<u64>,
        reward_types: vector<0x1::string::String>,
        type_names: vector<0x1::string::String>,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
    }

    struct RoyaltyInfo has store {
        royalty_basis_points: u64,
        royalty_recipient: address,
    }

    struct DayChangeEvent has copy, drop {
        day_number: u64,
        alive_count: u64,
        eliminated_count: u64,
        new_image: 0x1::string::String,
        timestamp: u64,
    }

    struct GameEndEvent has copy, drop {
        winner_id: 0x2::object::ID,
        reward_amount: u64,
        final_day: u64,
        timestamp: u64,
    }

    struct AliveNFTsEvent has copy, drop {
        total_alive: u64,
        alive_nft_ids: vector<0x2::object::ID>,
        current_day: u64,
    }

    struct RewardClaimEvent has copy, drop {
        nft_id: 0x2::object::ID,
        reward_type: 0x1::string::String,
        amount: u64,
        claimer: address,
    }

    struct WinnerRecord has drop, store {
        nft_id: 0x2::object::ID,
        round: u64,
        sui_amount: u64,
    }

    struct RewardsPool has key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        sui_rewards: 0x2::table::Table<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>,
        deployer_proceeds: 0x2::table::Table<u64, 0x2::balance::Balance<0x2::sui::SUI>>,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        trait: 0x1::string::String,
        current_day: u64,
        image_url: 0x2::url::Url,
        mint_number: u64,
        game_id: 0x2::object::ID,
        game_round: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct LAST_ALIVE has drop {
        dummy_field: bool,
    }

    struct BurnCap has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        total_burned: u64,
    }

    struct NFTRegistry has drop, store {
        id: 0x2::object::ID,
        trait: 0x1::string::String,
        owner: address,
    }

    struct GameState has key {
        id: 0x2::object::UID,
        owner: address,
        mint_enabled: bool,
        mint_price: u64,
        total_supply: u64,
        total_alive: u64,
        mint_proceeds: 0x2::balance::Balance<0x2::sui::SUI>,
        last_update: u64,
        current_day: u64,
        game_started: bool,
        game_ended: bool,
        nft_registry: 0x2::table::Table<0x2::object::ID, NFTRegistry>,
        nft_ids: vector<0x2::object::ID>,
        alive_nft_ids: vector<0x2::object::ID>,
        seconds_in_day: u64,
        current_round: u64,
        burn_discount: u64,
        max_supply: u64,
        royalty_info: RoyaltyInfo,
        winners: 0x2::table::Table<u64, vector<WinnerRecord>>,
        whitelist: 0x2::table::Table<address, bool>,
        whitelist_active: bool,
        whitelist_addresses: vector<address>,
        daily_images: vector<vector<u8>>,
        dead_image: vector<u8>,
        champion_image: vector<u8>,
        scheduled_start_time: u64,
        prize_pools: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct GameCounter has key {
        id: 0x2::object::UID,
        counter: u64,
        game_state_ids: vector<0x2::object::ID>,
        rewards_pool_ids: vector<0x2::object::ID>,
        start_rounds: vector<u64>,
    }

    struct WalletMintLimit has key {
        id: 0x2::object::UID,
        wallet_mints: 0x2::table::Table<u64, 0x2::table::Table<address, u64>>,
        max_mints_per_round: 0x2::table::Table<u64, u64>,
        owner: address,
    }

    struct GamesListEvent has copy, drop {
        game_state_ids: vector<0x2::object::ID>,
        rewards_pool_ids: vector<0x2::object::ID>,
        total_games: u64,
    }

    struct PoolCounter has key {
        id: 0x2::object::UID,
        counter: u64,
        rounds: vector<u64>,
        prize_pool_ids: vector<0x2::object::ID>,
        admin_cap_ids: vector<0x2::object::ID>,
        owner: address,
    }

    struct PoolsListEvent has copy, drop {
        rounds: vector<u64>,
        prize_pool_ids: vector<0x2::object::ID>,
        admin_cap_ids: vector<0x2::object::ID>,
        total_pools: u64,
    }

    struct RoyaltyPaidEvent has copy, drop {
        nft_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        sale_price: u64,
    }

    struct WinnerAnnouncementEvent has copy, drop {
        winner_nft_id: 0x2::object::ID,
        round: u64,
        timestamp: u64,
        announced_by: address,
    }

    struct RewardAddedEvent has copy, drop {
        round: u64,
        reward_type: 0x1::string::String,
        amount: u64,
        added_by: address,
    }

    struct NFTUpdateRequiredEvent has copy, drop {
        game_round: u64,
        current_day: u64,
        timestamp: u64,
    }

    struct ChampionUpdateEvent has copy, drop {
        nft_id: 0x2::object::ID,
        game_round: u64,
        owner: address,
        timestamp: u64,
    }

    struct PrizePoolInfoEvent has copy, drop {
        prize_pool_id: 0x2::object::ID,
        game_round: u64,
        nft_id: 0x2::object::ID,
    }

    struct PrizeAddedEvent has copy, drop {
        prize_pool_id: 0x2::object::ID,
        prize_type: 0x1::string::String,
        index: u64,
        type_name: 0x1::string::String,
    }

    struct PrizeListEvent has copy, drop {
        prize_pool_id: 0x2::object::ID,
        prize_types: vector<0x1::string::String>,
        indices: vector<u64>,
        type_names: vector<0x1::string::String>,
        total_prizes: u64,
    }

    struct SinglePoolInfoEvent has copy, drop {
        round: u64,
        prize_pool_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct PrizeClaimedEvent has copy, drop {
        prize_pool_id: 0x2::object::ID,
        index: u64,
        claimer: address,
    }

    public entry fun add_addresses_to_whitelist(arg0: &mut GameState, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::table::contains<address, bool>(&arg0.whitelist, v1)) {
                0x2::table::add<address, bool>(&mut arg0.whitelist, v1, true);
                0x1::vector::push_back<address>(&mut arg0.whitelist_addresses, v1);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun add_coin<T0>(arg0: &mut PrizePool, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinField<T0>{value: arg2};
        let v1 = arg0.prize_count;
        0x2::dynamic_field::add<u64, CoinField<T0>>(&mut arg0.id, v1, v0);
        0x1::vector::push_back<u64>(&mut arg0.indices, v1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.reward_types, 0x1::string::utf8(b"coin"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.type_names, arg3);
        arg0.prize_count = arg0.prize_count + 1;
        let v2 = PrizeAddedEvent{
            prize_pool_id : 0x2::object::uid_to_inner(&arg0.id),
            prize_type    : 0x1::string::utf8(b"coin"),
            index         : v1,
            type_name     : arg3,
        };
        0x2::event::emit<PrizeAddedEvent>(v2);
    }

    public entry fun add_nft<T0: store + key>(arg0: &mut PrizePool, arg1: &AdminCap, arg2: T0, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NftField<T0>{value: arg2};
        let v1 = arg0.prize_count;
        0x2::dynamic_field::add<u64, NftField<T0>>(&mut arg0.id, v1, v0);
        0x1::vector::push_back<u64>(&mut arg0.indices, v1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.reward_types, 0x1::string::utf8(b"nft"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.type_names, arg3);
        arg0.prize_count = arg0.prize_count + 1;
        let v2 = PrizeAddedEvent{
            prize_pool_id : 0x2::object::uid_to_inner(&arg0.id),
            prize_type    : 0x1::string::utf8(b"nft"),
            index         : v1,
            type_name     : arg3,
        };
        0x2::event::emit<PrizeAddedEvent>(v2);
    }

    public entry fun add_sui_reward(arg0: &GameState, arg1: &mut RewardsPool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 0);
        let v0 = arg0.current_round;
        if (!0x2::table::contains<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&arg1.sui_rewards, v0)) {
            0x2::table::add<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&mut arg1.sui_rewards, v0, 0x2::table::new<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(arg4));
        };
        let v1 = 0x2::object::id_from_address(@0xffffffffffffffffffffffffffffffff);
        let v2 = 0x2::table::borrow_mut<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&mut arg1.sui_rewards, v0);
        if (!0x2::table::contains<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(v2, v1)) {
            0x2::table::add<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(v2, v1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3, arg4)));
        } else {
            0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(v2, v1), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3, arg4)));
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v3 = RewardAddedEvent{
            round       : v0,
            reward_type : 0x1::string::utf8(b"SUI"),
            amount      : arg3,
            added_by    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RewardAddedEvent>(v3);
    }

    public entry fun announce_winner(arg0: &GameState, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        assert!(0x2::table::contains<u64, vector<WinnerRecord>>(&arg0.winners, arg2), 19);
        let v0 = 0x2::table::borrow<u64, vector<WinnerRecord>>(&arg0.winners, arg2);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<WinnerRecord>(v0) && !v1) {
            if (0x1::vector::borrow<WinnerRecord>(v0, v2).nft_id == arg1) {
                v1 = true;
            };
            v2 = v2 + 1;
        };
        assert!(v1, 4);
        let v3 = WinnerAnnouncementEvent{
            winner_nft_id : arg1,
            round         : arg2,
            timestamp     : 0,
            announced_by  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WinnerAnnouncementEvent>(v3);
    }

    fun ascii_to_string(arg0: 0x1::ascii::String) : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(arg0))
    }

    public entry fun batch_burn(arg0: &mut BurnCap, arg1: vector<NFT>) {
        let v0 = 0x1::vector::length<NFT>(&arg1);
        assert!(v0 > 0, 21);
        arg0.total_burned = arg0.total_burned + v0;
        while (!0x1::vector::is_empty<NFT>(&arg1)) {
            let NFT {
                id          : v1,
                name        : _,
                trait       : _,
                current_day : _,
                image_url   : _,
                mint_number : _,
                game_id     : _,
                game_round  : _,
                attributes  : _,
            } = 0x1::vector::pop_back<NFT>(&mut arg1);
            0x2::object::delete(v1);
        };
        0x1::vector::destroy_empty<NFT>(arg1);
    }

    public entry fun batch_burn_and_mint(arg0: &mut GameState, arg1: &mut WalletMintLimit, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_enabled, 3);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) > 0, 21);
        let v0 = arg0.max_supply - arg0.total_supply;
        let v1 = if (arg4 > v0) {
            v0
        } else {
            arg4
        };
        assert!(v1 > 0, 2);
        let v2 = 0x2::tx_context::sender(arg6);
        if (arg0.whitelist_active) {
            assert!(0x2::table::contains<address, bool>(&arg0.whitelist, v2), 4);
        };
        check_and_update_wallet_mint_limit(arg1, v2, arg0.current_round, v1, arg6);
        let v3 = arg0.mint_price * v1 * (100 - arg0.burn_discount) / 100;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.mint_proceeds, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg6)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        check_and_set_scheduled_start_time(arg0, arg5);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v5 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v4);
            if (0x2::table::contains<0x2::object::ID, NFTRegistry>(&arg0.nft_registry, v5)) {
                0x2::table::remove<0x2::object::ID, NFTRegistry>(&mut arg0.nft_registry, v5);
                let v6 = &mut arg0.nft_ids;
                let v7 = 0;
                while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v6, v7) == v5) {
                        0x1::vector::remove<0x2::object::ID>(v6, v7);
                        break
                    };
                    v7 = v7 + 1;
                };
                let v8 = &mut arg0.alive_nft_ids;
                let v9 = 0;
                while (v9 < 0x1::vector::length<0x2::object::ID>(v8)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v8, v9) == v5) {
                        0x1::vector::remove<0x2::object::ID>(v8, v9);
                        break
                    };
                    v9 = v9 + 1;
                };
            };
            v4 = v4 + 1;
        };
        mint_nfts(arg0, v1, v2, arg6);
        0x1::vector::destroy_empty<0x2::object::ID>(arg3);
    }

    public entry fun batch_mint(arg0: &mut GameState, arg1: &mut WalletMintLimit, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_enabled, 3);
        let v0 = arg0.max_supply - arg0.total_supply;
        let v1 = if (arg3 > v0) {
            v0
        } else {
            arg3
        };
        assert!(v1 > 0, 2);
        let v2 = 0x2::tx_context::sender(arg5);
        if (arg0.whitelist_active) {
            assert!(0x2::table::contains<address, bool>(&arg0.whitelist, v2), 4);
        };
        check_and_update_wallet_mint_limit(arg1, v2, arg0.current_round, v1, arg5);
        let v3 = arg0.mint_price * v1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.mint_proceeds, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        check_and_set_scheduled_start_time(arg0, arg4);
        let v4 = 0;
        while (v4 < v1) {
            arg0.total_supply = arg0.total_supply + 1;
            arg0.total_alive = arg0.total_alive + 1;
            let v5 = arg0.total_supply;
            let v6 = 0x1::string::utf8(b"SUIvivor #");
            0x1::string::append(&mut v6, number_to_string(v5));
            let v7 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"game"), number_to_string(arg0.current_round));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"round"), number_to_string(0));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"status"), 0x1::string::utf8(b"Alive"));
            let v8 = NFT{
                id          : 0x2::object::new(arg5),
                name        : v6,
                trait       : 0x1::string::utf8(b"Alive"),
                current_day : 0,
                image_url   : 0x2::url::new_unsafe(to_ascii_string(*0x1::vector::borrow<vector<u8>>(&arg0.daily_images, 0))),
                mint_number : v5,
                game_id     : 0x2::object::uid_to_inner(&arg0.id),
                game_round  : arg0.current_round,
                attributes  : v7,
            };
            let v9 = 0x2::object::uid_to_inner(&v8.id);
            let v10 = NFTRegistry{
                id    : v9,
                trait : 0x1::string::utf8(b"Alive"),
                owner : 0x2::tx_context::sender(arg5),
            };
            0x2::table::add<0x2::object::ID, NFTRegistry>(&mut arg0.nft_registry, v9, v10);
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.alive_nft_ids, v9);
            0x2::transfer::public_transfer<NFT>(v8, v2);
            let v11 = MintEvent{
                nft_id : v9,
                minter : v2,
            };
            0x2::event::emit<MintEvent>(v11);
            v4 = v4 + 1;
        };
    }

    public entry fun burn_and_replace(arg0: &mut GameState, arg1: &mut WalletMintLimit, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<NFT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_enabled, 3);
        let v0 = 0x1::vector::length<NFT>(&arg3);
        assert!(v0 > 0, 21);
        assert!(v0 <= arg0.max_supply - arg0.total_supply, 2);
        let v1 = 0x2::tx_context::sender(arg5);
        if (arg0.whitelist_active) {
            assert!(0x2::table::contains<address, bool>(&arg0.whitelist, v1), 4);
        };
        check_and_update_wallet_mint_limit(arg1, v1, arg0.current_round, v0, arg5);
        let v2 = arg0.mint_price * v0 * (100 - arg0.burn_discount) / 100;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.mint_proceeds, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        check_and_set_scheduled_start_time(arg0, arg4);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x2::object::uid_to_inner(&0x1::vector::borrow<NFT>(&arg3, v3).id);
            if (0x2::table::contains<0x2::object::ID, NFTRegistry>(&arg0.nft_registry, v4)) {
                0x2::table::remove<0x2::object::ID, NFTRegistry>(&mut arg0.nft_registry, v4);
                let v5 = &mut arg0.nft_ids;
                let v6 = 0;
                while (v6 < 0x1::vector::length<0x2::object::ID>(v5)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v5, v6) == v4) {
                        0x1::vector::remove<0x2::object::ID>(v5, v6);
                        break
                    };
                    v6 = v6 + 1;
                };
                let v7 = &mut arg0.alive_nft_ids;
                let v8 = 0;
                while (v8 < 0x1::vector::length<0x2::object::ID>(v7)) {
                    if (*0x1::vector::borrow<0x2::object::ID>(v7, v8) == v4) {
                        0x1::vector::remove<0x2::object::ID>(v7, v8);
                        break
                    };
                    v8 = v8 + 1;
                };
            };
            v3 = v3 + 1;
        };
        mint_nfts(arg0, v0, v1, arg5);
        while (!0x1::vector::is_empty<NFT>(&arg3)) {
            let NFT {
                id          : v9,
                name        : _,
                trait       : _,
                current_day : _,
                image_url   : _,
                mint_number : _,
                game_id     : _,
                game_round  : _,
                attributes  : _,
            } = 0x1::vector::pop_back<NFT>(&mut arg3);
            0x2::object::delete(v9);
        };
        0x1::vector::destroy_empty<NFT>(arg3);
    }

    public entry fun burn_game_nfts(arg0: &BurnCap, arg1: NFT) {
        burn_nft(arg0, arg1);
    }

    public fun burn_nft(arg0: &BurnCap, arg1: NFT) {
        assert!(arg1.game_id == arg0.game_id, 4);
        let NFT {
            id          : v0,
            name        : _,
            trait       : _,
            current_day : _,
            image_url   : _,
            mint_number : _,
            game_id     : _,
            game_round  : _,
            attributes  : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun calculate_eliminations(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= 2) {
            return 1
        };
        arg0 / 2
    }

    fun calculate_royalty(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    fun check_and_set_scheduled_start_time(arg0: &mut GameState, arg1: &0x2::clock::Clock) {
        if (arg0.scheduled_start_time == 0 && !arg0.game_started) {
            if (0x2::balance::value<0x2::sui::SUI>(&arg0.mint_proceeds) >= 100000000000) {
                arg0.scheduled_start_time = 0x2::clock::timestamp_ms(arg1) + 86400000;
            };
        };
    }

    fun check_and_update_wallet_mint_limit(arg0: &mut WalletMintLimit, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<u64, u64>(&arg0.max_mints_per_round, arg2)) {
            return
        };
        if (!0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&arg0.wallet_mints, arg2)) {
            0x2::table::add<u64, 0x2::table::Table<address, u64>>(&mut arg0.wallet_mints, arg2, 0x2::table::new<address, u64>(arg4));
        };
        let v0 = 0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg0.wallet_mints, arg2);
        let v1 = if (0x2::table::contains<address, u64>(v0, arg1)) {
            *0x2::table::borrow<address, u64>(v0, arg1)
        } else {
            0x2::table::add<address, u64>(v0, arg1, 0);
            0
        };
        assert!(v1 + arg3 <= *0x2::table::borrow<u64, u64>(&arg0.max_mints_per_round, arg2), 3);
        *0x2::table::borrow_mut<address, u64>(v0, arg1) = v1 + arg3;
    }

    public fun check_nft_registry_status(arg0: &GameState, arg1: 0x2::object::ID) : (bool, 0x1::string::String) {
        assert!(0x2::table::contains<0x2::object::ID, NFTRegistry>(&arg0.nft_registry, arg1), 13);
        let v0 = 0x2::table::borrow<0x2::object::ID, NFTRegistry>(&arg0.nft_registry, arg1);
        (v0.trait == 0x1::string::utf8(b"Alive"), v0.trait)
    }

    public entry fun claim_coin<T0>(arg0: &mut PrizePool, arg1: &GameState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.winning_nft_id), 22);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::borrow<0x2::object::ID, NFTRegistry>(&arg1.nft_registry, *0x1::option::borrow<0x2::object::ID>(&arg0.winning_nft_id)).owner == v0, 26);
        if (0x2::dynamic_field::exists_<u64>(&arg0.id, arg2)) {
            let CoinField { value: v1 } = 0x2::dynamic_field::remove<u64, CoinField<T0>>(&mut arg0.id, arg2);
            let v2 = 0x1::vector::length<u64>(&arg0.indices);
            let v3 = 0;
            let v4 = v2;
            while (v3 < v2) {
                if (*0x1::vector::borrow<u64>(&arg0.indices, v3) == arg2) {
                    v4 = v3;
                    break
                };
                v3 = v3 + 1;
            };
            if (v4 < v2) {
                0x1::vector::remove<u64>(&mut arg0.indices, v4);
                0x1::vector::remove<0x1::string::String>(&mut arg0.reward_types, v4);
                0x1::vector::remove<0x1::string::String>(&mut arg0.type_names, v4);
            };
            arg0.prize_count = arg0.prize_count - 1;
            let v5 = PrizeClaimedEvent{
                prize_pool_id : 0x2::object::uid_to_inner(&arg0.id),
                index         : arg2,
                claimer       : v0,
            };
            0x2::event::emit<PrizeClaimedEvent>(v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        };
    }

    public entry fun claim_deployer_proceeds(arg0: &mut RewardsPool, arg1: &GameState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 4);
        assert!(is_round_ended(arg1, arg2), 11);
        assert!(0x2::table::contains<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.deployer_proceeds, arg2), 19);
        let v0 = 0x2::table::borrow_mut<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.deployer_proceeds, arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(v0);
        assert!(v1 > 0, 18);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v0, v1), arg3), arg1.owner);
    }

    public entry fun claim_nft<T0: store + key>(arg0: &mut PrizePool, arg1: &GameState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.winning_nft_id), 22);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::borrow<0x2::object::ID, NFTRegistry>(&arg1.nft_registry, *0x1::option::borrow<0x2::object::ID>(&arg0.winning_nft_id)).owner == v0, 26);
        if (0x2::dynamic_field::exists_<u64>(&arg0.id, arg2)) {
            let NftField { value: v1 } = 0x2::dynamic_field::remove<u64, NftField<T0>>(&mut arg0.id, arg2);
            let v2 = 0x1::vector::length<u64>(&arg0.indices);
            let v3 = 0;
            let v4 = v2;
            while (v3 < v2) {
                if (*0x1::vector::borrow<u64>(&arg0.indices, v3) == arg2) {
                    v4 = v3;
                    break
                };
                v3 = v3 + 1;
            };
            if (v4 < v2) {
                0x1::vector::remove<u64>(&mut arg0.indices, v4);
                0x1::vector::remove<0x1::string::String>(&mut arg0.reward_types, v4);
                0x1::vector::remove<0x1::string::String>(&mut arg0.type_names, v4);
            };
            arg0.prize_count = arg0.prize_count - 1;
            let v5 = PrizeClaimedEvent{
                prize_pool_id : 0x2::object::uid_to_inner(&arg0.id),
                index         : arg2,
                claimer       : v0,
            };
            0x2::event::emit<PrizeClaimedEvent>(v5);
            0x2::transfer::public_transfer<T0>(v1, v0);
        };
    }

    public entry fun claim_sui_and_check_prizepool(arg0: &mut RewardsPool, arg1: &GameState, arg2: &mut NFT, arg3: &mut 0x2::tx_context::TxContext) {
        claim_sui_rewards(arg0, arg1, arg2, arg3);
        let v0 = PrizePoolInfoEvent{
            prize_pool_id : get_prize_pool_by_round(arg1, arg2.game_round),
            game_round    : arg2.game_round,
            nft_id        : 0x2::object::uid_to_inner(&arg2.id),
        };
        0x2::event::emit<PrizePoolInfoEvent>(v0);
    }

    public entry fun claim_sui_rewards(arg0: &mut RewardsPool, arg1: &GameState, arg2: &mut NFT, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg2.id);
        let v1 = arg2.game_round;
        let v2 = 0x2::tx_context::sender(arg3);
        assert!(is_round_ended(arg1, v1), 11);
        assert!(0x2::table::contains<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&arg0.sui_rewards, v1) && 0x2::table::contains<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(0x2::table::borrow<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&arg0.sui_rewards, v1), v0), 19);
        arg2.trait = 0x1::string::utf8(b"Champion");
        arg2.image_url = 0x2::url::new_unsafe(to_ascii_string(arg1.champion_image));
        arg2.current_day = arg1.current_day;
        let v3 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"game"), number_to_string(arg2.game_round));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"round"), number_to_string(arg2.current_day));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"status"), arg2.trait);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"champion"), 0x1::string::utf8(b"true"));
        arg2.attributes = v3;
        let v4 = 0x2::table::remove<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(0x2::table::borrow_mut<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&mut arg0.sui_rewards, v1), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg3), v2);
        let v5 = RewardClaimEvent{
            nft_id      : v0,
            reward_type : 0x1::string::utf8(b"SUI"),
            amount      : 0x2::balance::value<0x2::sui::SUI>(&v4),
            claimer     : v2,
        };
        0x2::event::emit<RewardClaimEvent>(v5);
        let v6 = ChampionUpdateEvent{
            nft_id     : v0,
            game_round : arg2.game_round,
            owner      : v2,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<ChampionUpdateEvent>(v6);
    }

    public entry fun clear_all_whitelist(arg0: &mut GameState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4);
        clear_all_whitelist_entries(arg0);
    }

    fun clear_all_whitelist_entries(arg0: &mut GameState) {
        while (!0x1::vector::is_empty<address>(&arg0.whitelist_addresses)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg0.whitelist_addresses);
            if (0x2::table::contains<address, bool>(&arg0.whitelist, v0)) {
                0x2::table::remove<address, bool>(&mut arg0.whitelist, v0);
            };
        };
        0x1::vector::destroy_empty<address>(0x1::vector::empty<address>());
    }

    public entry fun create_prize_pool(arg0: &mut GameState, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 4);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = PrizePool{
            id             : 0x2::object::new(arg1),
            winning_nft_id : 0x1::option::none<0x2::object::ID>(),
            admin          : v0,
            prize_count    : 0,
            game_round     : arg0.current_round,
            indices        : 0x1::vector::empty<u64>(),
            reward_types   : 0x1::vector::empty<0x1::string::String>(),
            type_names     : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.prize_pools, arg0.current_round, 0x2::object::uid_to_inner(&v2.id));
        0x2::transfer::share_object<PrizePool>(v2);
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    public fun current_day(arg0: &GameState) : u64 {
        arg0.current_day
    }

    public fun days_until_completion(arg0: &GameState) : u64 {
        if (arg0.game_ended) {
            0
        } else if (!arg0.game_started) {
            11
        } else {
            11 - arg0.current_day
        }
    }

    public entry fun enable_mint(arg0: &mut GameState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4);
        arg0.mint_enabled = true;
    }

    public fun estimate_next_elimination(arg0: &GameState) : u64 {
        let v0 = if (arg0.game_ended) {
            true
        } else if (!arg0.game_started) {
            true
        } else {
            arg0.current_day >= 11 - 1
        };
        if (v0) {
            0
        } else {
            calculate_eliminations(arg0.total_alive, 0)
        }
    }

    public entry fun finish_game(arg0: &mut GameState, arg1: &mut RewardsPool, arg2: &mut PrizePool, arg3: &AdminCap, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 4);
        assert!(0x2::tx_context::sender(arg6) == arg2.admin, 24);
        assert!(arg0.game_started, 5);
        assert!(!arg0.game_ended, 7);
        assert!(arg0.current_day == 11 || arg0.total_alive <= 1, 6);
        let v0 = arg0.current_round;
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = false;
        let v3 = get_alive_nfts(arg0);
        let v4 = 0x1::vector::length<0x2::object::ID>(&v3);
        if (v4 > 1) {
            let v5 = 0x2::random::new_generator(arg5, arg6);
            let v6 = 0x2::random::generate_u64_in_range(&mut v5, 0, v4 - 1);
            v1 = *0x1::vector::borrow<0x2::object::ID>(&v3, v6);
            let v7 = 0;
            while (v7 < v4) {
                if (v7 != v6) {
                    mark_nft_as_dead(arg0, *0x1::vector::borrow<0x2::object::ID>(&v3, v7));
                };
                v7 = v7 + 1;
            };
            v2 = true;
            arg0.total_alive = 1;
        } else if (v4 == 1) {
            v1 = *0x1::vector::borrow<0x2::object::ID>(&v3, 0);
            v2 = true;
        } else {
            let v8 = 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids);
            if (v8 > 0) {
                let v9 = 0x2::random::new_generator(arg5, arg6);
                let v10 = *0x1::vector::borrow<0x2::object::ID>(&arg0.nft_ids, 0x2::random::generate_u64_in_range(&mut v9, 0, v8 - 1));
                v1 = v10;
                0x2::table::borrow_mut<0x2::object::ID, NFTRegistry>(&mut arg0.nft_registry, v10).trait = 0x1::string::utf8(b"Champion");
                v2 = true;
                arg0.total_alive = 1;
            };
        };
        assert!(v2, 6);
        arg2.winning_nft_id = 0x1::option::some<0x2::object::ID>(v1);
        0x2::table::borrow_mut<0x2::object::ID, NFTRegistry>(&mut arg0.nft_registry, v1).trait = 0x1::string::utf8(b"Champion");
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&arg0.mint_proceeds);
        if (!0x2::table::contains<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&arg1.sui_rewards, v0)) {
            0x2::table::add<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&mut arg1.sui_rewards, v0, 0x2::table::new<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(arg6));
        };
        let v12 = v11 * 80 / 100;
        let v13 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.mint_proceeds, v12);
        let v14 = 0x2::table::borrow_mut<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&mut arg1.sui_rewards, v0);
        let v15 = 0x2::object::id_from_address(@0xffffffffffffffffffffffffffffffff);
        if (0x2::table::contains<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(v14, v15)) {
            0x2::balance::join<0x2::sui::SUI>(&mut v13, 0x2::table::remove<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(v14, v15));
        };
        0x2::table::add<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(v14, v1, v13);
        if (!0x2::table::contains<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.deployer_proceeds, v0)) {
            0x2::table::add<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.deployer_proceeds, v0, 0x2::balance::zero<0x2::sui::SUI>());
        };
        0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.deployer_proceeds, v0), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.mint_proceeds, v11 - v12));
        let v16 = WinnerRecord{
            nft_id     : v1,
            round      : v0,
            sui_amount : v12,
        };
        if (!0x2::table::contains<u64, vector<WinnerRecord>>(&arg0.winners, v0)) {
            0x2::table::add<u64, vector<WinnerRecord>>(&mut arg0.winners, v0, 0x1::vector::empty<WinnerRecord>());
        };
        0x1::vector::push_back<WinnerRecord>(0x2::table::borrow_mut<u64, vector<WinnerRecord>>(&mut arg0.winners, v0), v16);
        let v17 = GameEndEvent{
            winner_id     : v1,
            reward_amount : v12,
            final_day     : arg0.current_day,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<GameEndEvent>(v17);
        arg0.game_ended = true;
    }

    fun get_alive_nfts(arg0: &GameState) : vector<0x2::object::ID> {
        arg0.alive_nft_ids
    }

    public fun get_all_whitelisted_addresses(arg0: &GameState) : vector<address> {
        arg0.whitelist_addresses
    }

    public fun get_available_rewards(arg0: &RewardsPool, arg1: &GameState, arg2: 0x2::object::ID, arg3: u64) : (bool, u64) {
        assert!(is_round_ended(arg1, arg3), 11);
        let v0 = 0x2::table::contains<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&arg0.sui_rewards, arg3) && 0x2::table::contains<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(0x2::table::borrow<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&arg0.sui_rewards, arg3), arg2);
        let v1 = if (v0) {
            0x2::balance::value<0x2::sui::SUI>(0x2::table::borrow<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(0x2::table::borrow<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&arg0.sui_rewards, arg3), arg2))
        } else {
            0
        };
        (v0, v1)
    }

    public fun get_burn_discount(arg0: &GameState) : u64 {
        arg0.burn_discount
    }

    public fun get_current_day(arg0: &NFT) : u64 {
        arg0.current_day
    }

    public fun get_game_by_index(arg0: &GameCounter, arg1: u64) : (0x2::object::ID, 0x2::object::ID, u64) {
        assert!(arg1 < 0x1::vector::length<0x2::object::ID>(&arg0.game_state_ids), 6);
        (*0x1::vector::borrow<0x2::object::ID>(&arg0.game_state_ids, arg1), *0x1::vector::borrow<0x2::object::ID>(&arg0.rewards_pool_ids, arg1), *0x1::vector::borrow<u64>(&arg0.start_rounds, arg1))
    }

    public fun get_game_status(arg0: &GameState, arg1: &0x2::clock::Clock) : 0x1::string::String {
        if (arg0.game_ended) {
            return 0x1::string::utf8(b"Ended")
        };
        if (arg0.game_started) {
            return 0x1::string::utf8(b"In Progress")
        };
        if (arg0.scheduled_start_time == 0) {
            return 0x1::string::utf8(b"Not Scheduled")
        };
        if (should_start_game(arg0, arg1)) {
            return 0x1::string::utf8(b"Ready to Start")
        };
        0x1::string::utf8(b"Scheduled")
    }

    public fun get_games_count(arg0: &GameCounter) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.game_state_ids)
    }

    public fun get_image_url(arg0: &NFT) : 0x1::string::String {
        ascii_to_string(0x2::url::inner_url(&arg0.image_url))
    }

    public fun get_max_mints_per_wallet(arg0: &WalletMintLimit, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, u64>(&arg0.max_mints_per_round, arg1)) {
            return 0
        };
        *0x2::table::borrow<u64, u64>(&arg0.max_mints_per_round, arg1)
    }

    public fun get_max_supply(arg0: &GameState) : u64 {
        arg0.max_supply
    }

    public fun get_mint_price(arg0: &GameState) : u64 {
        arg0.mint_price
    }

    public fun get_nft_registry_status(arg0: &GameState, arg1: 0x2::object::ID) : 0x1::string::String {
        0x2::table::borrow<0x2::object::ID, NFTRegistry>(&arg0.nft_registry, arg1).trait
    }

    public fun get_pool_by_index(arg0: &PoolCounter, arg1: u64) : (u64, 0x2::object::ID, 0x2::object::ID) {
        assert!(arg1 < 0x1::vector::length<u64>(&arg0.rounds), 19);
        (*0x1::vector::borrow<u64>(&arg0.rounds, arg1), *0x1::vector::borrow<0x2::object::ID>(&arg0.prize_pool_ids, arg1), *0x1::vector::borrow<0x2::object::ID>(&arg0.admin_cap_ids, arg1))
    }

    public entry fun get_pool_by_round(arg0: &PoolCounter, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.rounds) && !v0) {
            if (*0x1::vector::borrow<u64>(&arg0.rounds, v1) == arg1) {
                v0 = true;
                continue
            };
            v1 = v1 + 1;
        };
        assert!(v0, 19);
        let v2 = SinglePoolInfoEvent{
            round         : arg1,
            prize_pool_id : *0x1::vector::borrow<0x2::object::ID>(&arg0.prize_pool_ids, v1),
            admin_cap_id  : *0x1::vector::borrow<0x2::object::ID>(&arg0.admin_cap_ids, v1),
        };
        0x2::event::emit<SinglePoolInfoEvent>(v2);
    }

    public fun get_pools_count(arg0: &PoolCounter) : u64 {
        arg0.counter
    }

    public fun get_prize_count(arg0: &PrizePool) : u64 {
        arg0.prize_count
    }

    public fun get_prize_info(arg0: &PrizePool) : (vector<u64>, vector<0x1::string::String>, vector<0x1::string::String>) {
        (arg0.indices, arg0.reward_types, arg0.type_names)
    }

    public fun get_prize_pool_by_round(arg0: &GameState, arg1: u64) : 0x2::object::ID {
        assert!(0x2::table::contains<u64, 0x2::object::ID>(&arg0.prize_pools, arg1), 19);
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.prize_pools, arg1)
    }

    public fun get_royalty_info(arg0: &GameState) : (address, u64) {
        (arg0.royalty_info.royalty_recipient, arg0.royalty_info.royalty_basis_points)
    }

    public fun get_scheduled_start_time(arg0: &GameState) : u64 {
        arg0.scheduled_start_time
    }

    public fun get_time_until_start(arg0: &GameState, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.scheduled_start_time == 0) {
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.scheduled_start_time) {
            return 0
        };
        arg0.scheduled_start_time - v0
    }

    public fun get_trait(arg0: &NFT) : 0x1::string::String {
        arg0.trait
    }

    public fun get_type_name_by_index(arg0: &PrizePool, arg1: u64) : (0x1::string::String, 0x1::string::String) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.indices)) {
            if (*0x1::vector::borrow<u64>(&arg0.indices, v0) == arg1) {
                return (*0x1::vector::borrow<0x1::string::String>(&arg0.reward_types, v0), *0x1::vector::borrow<0x1::string::String>(&arg0.type_names, v0))
            };
            v0 = v0 + 1;
        };
        (0x1::string::utf8(b""), 0x1::string::utf8(b""))
    }

    public fun get_wallet_mint_count(arg0: &WalletMintLimit, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&arg0.wallet_mints, arg2)) {
            return 0
        };
        let v0 = 0x2::table::borrow<u64, 0x2::table::Table<address, u64>>(&arg0.wallet_mints, arg2);
        if (!0x2::table::contains<address, u64>(v0, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(v0, arg1)
    }

    public fun get_winners(arg0: &GameState, arg1: u64) : &vector<WinnerRecord> {
        assert!(0x2::table::contains<u64, vector<WinnerRecord>>(&arg0.winners, arg1), 19);
        0x2::table::borrow<u64, vector<WinnerRecord>>(&arg0.winners, arg1)
    }

    public fun get_winning_nft_id(arg0: &PrizePool) : 0x1::option::Option<0x2::object::ID> {
        arg0.winning_nft_id
    }

    fun init(arg0: LAST_ALIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<LAST_ALIVE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"status"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"game_round"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"current_day"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A survivor in the SUIvivor game"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{trait}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Round {game_round}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Day {current_day}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        let v5 = 0x2::display::new_with_fields<NFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = RoyaltyInfo{
            royalty_basis_points : 333,
            royalty_recipient    : 0x2::tx_context::sender(arg1),
        };
        let v7 = GameState{
            id                   : 0x2::object::new(arg1),
            owner                : 0x2::tx_context::sender(arg1),
            mint_enabled         : false,
            mint_price           : 1000000000,
            total_supply         : 0,
            total_alive          : 0,
            mint_proceeds        : 0x2::balance::zero<0x2::sui::SUI>(),
            last_update          : 0,
            current_day          : 0,
            game_started         : false,
            game_ended           : false,
            nft_registry         : 0x2::table::new<0x2::object::ID, NFTRegistry>(arg1),
            nft_ids              : 0x1::vector::empty<0x2::object::ID>(),
            alive_nft_ids        : 0x1::vector::empty<0x2::object::ID>(),
            seconds_in_day       : 86400,
            current_round        : 0,
            burn_discount        : 5,
            max_supply           : 1000,
            royalty_info         : v6,
            winners              : 0x2::table::new<u64, vector<WinnerRecord>>(arg1),
            whitelist            : 0x2::table::new<address, bool>(arg1),
            whitelist_active     : false,
            whitelist_addresses  : 0x1::vector::empty<address>(),
            daily_images         : vector[b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4"],
            dead_image           : b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4",
            champion_image       : b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4",
            scheduled_start_time : 0,
            prize_pools          : 0x2::table::new<u64, 0x2::object::ID>(arg1),
        };
        let v8 = RewardsPool{
            id                : 0x2::object::new(arg1),
            game_id           : 0x2::object::uid_to_inner(&v7.id),
            sui_rewards       : 0x2::table::new<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(arg1),
            deployer_proceeds : 0x2::table::new<u64, 0x2::balance::Balance<0x2::sui::SUI>>(arg1),
        };
        0x2::table::add<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&mut v8.sui_rewards, 0, 0x2::table::new<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(arg1));
        0x2::table::add<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v8.deployer_proceeds, 0, 0x2::balance::zero<0x2::sui::SUI>());
        let v9 = AdminCap{id: 0x2::object::new(arg1)};
        let v10 = PrizePool{
            id             : 0x2::object::new(arg1),
            winning_nft_id : 0x1::option::none<0x2::object::ID>(),
            admin          : 0x2::tx_context::sender(arg1),
            prize_count    : 0,
            game_round     : 0,
            indices        : 0x1::vector::empty<u64>(),
            reward_types   : 0x1::vector::empty<0x1::string::String>(),
            type_names     : 0x1::vector::empty<0x1::string::String>(),
        };
        let v11 = 0x2::object::uid_to_inner(&v10.id);
        0x2::table::add<u64, 0x2::object::ID>(&mut v7.prize_pools, 0, v11);
        0x2::transfer::share_object<GameState>(v7);
        0x2::transfer::share_object<RewardsPool>(v8);
        0x2::transfer::share_object<PrizePool>(v10);
        0x2::transfer::transfer<AdminCap>(v9, 0x2::tx_context::sender(arg1));
        let v12 = GameCounter{
            id               : 0x2::object::new(arg1),
            counter          : 0,
            game_state_ids   : 0x1::vector::singleton<0x2::object::ID>(0x2::object::uid_to_inner(&v7.id)),
            rewards_pool_ids : 0x1::vector::singleton<0x2::object::ID>(0x2::object::uid_to_inner(&v8.id)),
            start_rounds     : 0x1::vector::singleton<u64>(0),
        };
        let v13 = WalletMintLimit{
            id                  : 0x2::object::new(arg1),
            wallet_mints        : 0x2::table::new<u64, 0x2::table::Table<address, u64>>(arg1),
            max_mints_per_round : 0x2::table::new<u64, u64>(arg1),
            owner               : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<GameCounter>(v12);
        0x2::transfer::share_object<WalletMintLimit>(v13);
        let v14 = PoolCounter{
            id             : 0x2::object::new(arg1),
            counter        : 0,
            rounds         : 0x1::vector::empty<u64>(),
            prize_pool_ids : 0x1::vector::empty<0x2::object::ID>(),
            admin_cap_ids  : 0x1::vector::empty<0x2::object::ID>(),
            owner          : 0x2::tx_context::sender(arg1),
        };
        0x1::vector::push_back<u64>(&mut v14.rounds, 0);
        0x1::vector::push_back<0x2::object::ID>(&mut v14.prize_pool_ids, v11);
        0x1::vector::push_back<0x2::object::ID>(&mut v14.admin_cap_ids, 0x2::object::uid_to_inner(&v9.id));
        0x2::transfer::share_object<PoolCounter>(v14);
    }

    public fun is_game_ready_to_start(arg0: &GameState, arg1: &0x2::clock::Clock) : bool {
        if (arg0.game_started) {
            return false
        };
        if (arg0.scheduled_start_time == 0) {
            return false
        };
        should_start_game(arg0, arg1)
    }

    public fun is_mint_enabled(arg0: &GameState) : bool {
        arg0.mint_enabled
    }

    public fun is_owner_of_nft(arg0: 0x2::object::ID, arg1: address) : bool {
        true
    }

    public fun is_round_ended(arg0: &GameState, arg1: u64) : bool {
        0x2::table::contains<u64, vector<WinnerRecord>>(&arg0.winners, arg1) && !0x1::vector::is_empty<WinnerRecord>(0x2::table::borrow<u64, vector<WinnerRecord>>(&arg0.winners, arg1))
    }

    public fun is_whitelisted(arg0: &GameState, arg1: address) : bool {
        if (!arg0.whitelist_active) {
            return true
        };
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public entry fun launch_new_game(arg0: &mut GameCounter, arg1: &mut PoolCounter, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.counter = arg0.counter + 1;
        let v0 = arg0.counter * 10000;
        let v1 = RoyaltyInfo{
            royalty_basis_points : 333,
            royalty_recipient    : 0x2::tx_context::sender(arg2),
        };
        let v2 = GameState{
            id                   : 0x2::object::new(arg2),
            owner                : 0x2::tx_context::sender(arg2),
            mint_enabled         : false,
            mint_price           : 1000000000,
            total_supply         : 0,
            total_alive          : 0,
            mint_proceeds        : 0x2::balance::zero<0x2::sui::SUI>(),
            last_update          : 0,
            current_day          : 0,
            game_started         : false,
            game_ended           : false,
            nft_registry         : 0x2::table::new<0x2::object::ID, NFTRegistry>(arg2),
            nft_ids              : 0x1::vector::empty<0x2::object::ID>(),
            alive_nft_ids        : 0x1::vector::empty<0x2::object::ID>(),
            seconds_in_day       : 86400,
            current_round        : v0,
            burn_discount        : 5,
            max_supply           : 1000,
            royalty_info         : v1,
            winners              : 0x2::table::new<u64, vector<WinnerRecord>>(arg2),
            whitelist            : 0x2::table::new<address, bool>(arg2),
            whitelist_active     : false,
            whitelist_addresses  : 0x1::vector::empty<address>(),
            daily_images         : vector[b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4", b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4"],
            dead_image           : b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4",
            champion_image       : b"https://ipfs.io/ipfs/bafkreibgfjsp72cyjag3t6wapqzskya3bvdq3az2oxpwqsqvvwno42swx4",
            scheduled_start_time : 0,
            prize_pools          : 0x2::table::new<u64, 0x2::object::ID>(arg2),
        };
        let v3 = RewardsPool{
            id                : 0x2::object::new(arg2),
            game_id           : 0x2::object::uid_to_inner(&v2.id),
            sui_rewards       : 0x2::table::new<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(arg2),
            deployer_proceeds : 0x2::table::new<u64, 0x2::balance::Balance<0x2::sui::SUI>>(arg2),
        };
        0x2::table::add<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&mut v3.sui_rewards, v0, 0x2::table::new<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(arg2));
        0x2::table::add<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v3.deployer_proceeds, v0, 0x2::balance::zero<0x2::sui::SUI>());
        let v4 = AdminCap{id: 0x2::object::new(arg2)};
        let v5 = PrizePool{
            id             : 0x2::object::new(arg2),
            winning_nft_id : 0x1::option::none<0x2::object::ID>(),
            admin          : 0x2::tx_context::sender(arg2),
            prize_count    : 0,
            game_round     : v0,
            indices        : 0x1::vector::empty<u64>(),
            reward_types   : 0x1::vector::empty<0x1::string::String>(),
            type_names     : 0x1::vector::empty<0x1::string::String>(),
        };
        let v6 = 0x2::object::uid_to_inner(&v5.id);
        arg1.counter = arg1.counter + 1;
        0x1::vector::push_back<u64>(&mut arg1.rounds, v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.prize_pool_ids, v6);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.admin_cap_ids, 0x2::object::uid_to_inner(&v4.id));
        0x2::table::add<u64, 0x2::object::ID>(&mut v2.prize_pools, v0, v6);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.game_state_ids, 0x2::object::uid_to_inner(&v2.id));
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.rewards_pool_ids, 0x2::object::uid_to_inner(&v3.id));
        0x1::vector::push_back<u64>(&mut arg0.start_rounds, v0);
        0x2::transfer::share_object<GameState>(v2);
        0x2::transfer::share_object<RewardsPool>(v3);
        0x2::transfer::share_object<PrizePool>(v5);
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg2));
    }

    public fun list_alive_nfts(arg0: &GameState) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg0.nft_ids, v1);
            if (0x2::table::borrow<0x2::object::ID, NFTRegistry>(&arg0.nft_registry, v2).trait == 0x1::string::utf8(b"Alive")) {
                0x1::vector::push_back<0x2::object::ID>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun list_alive_nfts_with_details(arg0: &GameState) {
        let v0 = arg0.alive_nft_ids;
        let v1 = AliveNFTsEvent{
            total_alive   : 0x1::vector::length<0x2::object::ID>(&v0),
            alive_nft_ids : v0,
            current_day   : arg0.current_day,
        };
        0x2::event::emit<AliveNFTsEvent>(v1);
    }

    public entry fun list_games(arg0: &GameCounter) {
        let v0 = GamesListEvent{
            game_state_ids   : arg0.game_state_ids,
            rewards_pool_ids : arg0.rewards_pool_ids,
            total_games      : arg0.counter + 1,
        };
        0x2::event::emit<GamesListEvent>(v0);
    }

    public entry fun list_pools(arg0: &PoolCounter) {
        let v0 = PoolsListEvent{
            rounds         : arg0.rounds,
            prize_pool_ids : arg0.prize_pool_ids,
            admin_cap_ids  : arg0.admin_cap_ids,
            total_pools    : arg0.counter + 1,
        };
        0x2::event::emit<PoolsListEvent>(v0);
    }

    public entry fun list_prizes(arg0: &PrizePool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PrizeListEvent{
            prize_pool_id : 0x2::object::uid_to_inner(&arg0.id),
            prize_types   : arg0.reward_types,
            indices       : arg0.indices,
            type_names    : arg0.type_names,
            total_prizes  : arg0.prize_count,
        };
        0x2::event::emit<PrizeListEvent>(v0);
    }

    fun mark_nft_as_dead(arg0: &mut GameState, arg1: 0x2::object::ID) {
        0x2::table::borrow_mut<0x2::object::ID, NFTRegistry>(&mut arg0.nft_registry, arg1).trait = 0x1::string::utf8(b"Dead");
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg0.alive_nft_ids);
        let v1 = 0;
        let v2 = v0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.alive_nft_ids, v1) == arg1) {
                v2 = v1;
                break
            };
            v1 = v1 + 1;
        };
        if (v2 < v0) {
            0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.alive_nft_ids, v2);
            arg0.total_alive = arg0.total_alive - 1;
        };
    }

    fun mint_nfts(arg0: &mut GameState, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            arg0.total_supply = arg0.total_supply + 1;
            arg0.total_alive = arg0.total_alive + 1;
            let v1 = arg0.total_supply;
            let v2 = 0x1::string::utf8(b"SUIvivor #");
            0x1::string::append(&mut v2, number_to_string(v1));
            let v3 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"game"), number_to_string(arg0.current_round));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"round"), number_to_string(0));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"status"), 0x1::string::utf8(b"Alive"));
            let v4 = NFT{
                id          : 0x2::object::new(arg3),
                name        : v2,
                trait       : 0x1::string::utf8(b"Alive"),
                current_day : 0,
                image_url   : 0x2::url::new_unsafe(to_ascii_string(*0x1::vector::borrow<vector<u8>>(&arg0.daily_images, 0))),
                mint_number : v1,
                game_id     : 0x2::object::uid_to_inner(&arg0.id),
                game_round  : arg0.current_round,
                attributes  : v3,
            };
            let v5 = 0x2::object::uid_to_inner(&v4.id);
            let v6 = NFTRegistry{
                id    : v5,
                trait : 0x1::string::utf8(b"Alive"),
                owner : arg2,
            };
            0x2::table::add<0x2::object::ID, NFTRegistry>(&mut arg0.nft_registry, v5, v6);
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.alive_nft_ids, v5);
            0x2::transfer::public_transfer<NFT>(v4, arg2);
            let v7 = MintEvent{
                nft_id : v5,
                minter : arg2,
            };
            0x2::event::emit<MintEvent>(v7);
            v0 = v0 + 1;
        };
    }

    public entry fun notify_nft_update_required(arg0: &GameState, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTUpdateRequiredEvent{
            game_round  : arg0.current_round,
            current_day : arg0.current_day,
            timestamp   : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<NFTUpdateRequiredEvent>(v0);
    }

    fun number_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun prize_exists(arg0: &PrizePool, arg1: u64) : bool {
        0x2::dynamic_field::exists_<u64>(&arg0.id, arg1)
    }

    public entry fun process_royalty_payment(arg0: &GameState, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg2);
        let v1 = calculate_royalty(v0, arg0.royalty_info.royalty_basis_points);
        assert!(v1 > 0, 18);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg3), arg0.royalty_info.royalty_recipient);
        let v2 = RoyaltyPaidEvent{
            nft_id     : arg1,
            amount     : v1,
            recipient  : arg0.royalty_info.royalty_recipient,
            sale_price : v0,
        };
        0x2::event::emit<RoyaltyPaidEvent>(v2);
    }

    public entry fun remove_addresses_from_whitelist(arg0: &mut GameState, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::table::contains<address, bool>(&arg0.whitelist, v1)) {
                0x2::table::remove<address, bool>(&mut arg0.whitelist, v1);
                let v2 = 0x1::vector::length<address>(&arg0.whitelist_addresses);
                let v3 = 0;
                let v4 = v2;
                while (v3 < v2) {
                    if (*0x1::vector::borrow<address>(&arg0.whitelist_addresses, v3) == v1) {
                        v4 = v3;
                        break
                    };
                    v3 = v3 + 1;
                };
                if (v4 < v2) {
                    0x1::vector::swap_remove<address>(&mut arg0.whitelist_addresses, v4);
                };
            };
            v0 = v0 + 1;
        };
    }

    public entry fun reset_game(arg0: &mut GameState, arg1: &mut RewardsPool, arg2: &mut PoolCounter, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        assert!(arg0.game_ended, 11);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.mint_proceeds);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.mint_proceeds, v0), arg3), arg0.owner);
        };
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg0.nft_ids)) {
            0x2::table::remove<0x2::object::ID, NFTRegistry>(&mut arg0.nft_registry, 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.nft_ids));
        };
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg0.alive_nft_ids)) {
            0x1::vector::pop_back<0x2::object::ID>(&mut arg0.alive_nft_ids);
        };
        let v1 = arg0.current_round + 1;
        0x2::table::add<u64, 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>>(&mut arg1.sui_rewards, v1, 0x2::table::new<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(arg3));
        0x2::table::add<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.deployer_proceeds, v1, 0x2::balance::zero<0x2::sui::SUI>());
        let v2 = AdminCap{id: 0x2::object::new(arg3)};
        let v3 = PrizePool{
            id             : 0x2::object::new(arg3),
            winning_nft_id : 0x1::option::none<0x2::object::ID>(),
            admin          : 0x2::tx_context::sender(arg3),
            prize_count    : 0,
            game_round     : v1,
            indices        : 0x1::vector::empty<u64>(),
            reward_types   : 0x1::vector::empty<0x1::string::String>(),
            type_names     : 0x1::vector::empty<0x1::string::String>(),
        };
        let v4 = 0x2::object::uid_to_inner(&v3.id);
        arg2.counter = arg2.counter + 1;
        0x1::vector::push_back<u64>(&mut arg2.rounds, v1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.prize_pool_ids, v4);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.admin_cap_ids, 0x2::object::uid_to_inner(&v2.id));
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.prize_pools, v1, v4);
        0x2::transfer::share_object<PrizePool>(v3);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg3));
        arg0.total_supply = 0;
        arg0.total_alive = 0;
        arg0.last_update = 0;
        arg0.current_day = 0;
        arg0.game_started = false;
        arg0.game_ended = false;
        arg0.current_round = v1;
        arg0.scheduled_start_time = 0;
        clear_all_whitelist_entries(arg0);
        arg0.whitelist_active = false;
    }

    public entry fun set_burn_discount(arg0: &mut GameState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        assert!(arg1 <= 100, 12);
        arg0.burn_discount = arg1;
    }

    public entry fun set_day_length(arg0: &mut GameState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        assert!(!arg0.game_started, 5);
        assert!(arg1 >= 60, 9);
        arg0.seconds_in_day = arg1;
    }

    public entry fun set_max_mints_per_wallet(arg0: &mut WalletMintLimit, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        if (0x2::table::contains<u64, u64>(&arg0.max_mints_per_round, arg1)) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.max_mints_per_round, arg1) = arg2;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.max_mints_per_round, arg1, arg2);
        };
    }

    public entry fun set_max_supply(arg0: &mut GameState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        assert!(!arg0.game_started, 5);
        assert!(arg1 >= arg0.total_supply, 0);
        arg0.max_supply = arg1;
    }

    public entry fun set_mint_price(arg0: &mut GameState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        assert!(!arg0.game_started, 5);
        arg0.mint_price = arg1;
    }

    public entry fun set_scheduled_start_time(arg0: &mut GameState, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        assert!(!arg0.game_started, 5);
        arg0.scheduled_start_time = 0x2::clock::timestamp_ms(arg1) + arg2 * 3600 * 1000;
    }

    public entry fun set_winner(arg0: &mut PrizePool, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 24);
        arg0.winning_nft_id = 0x1::option::some<0x2::object::ID>(arg2);
    }

    public fun should_start_game(arg0: &GameState, arg1: &0x2::clock::Clock) : bool {
        if (arg0.scheduled_start_time == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= arg0.scheduled_start_time
    }

    fun to_ascii_string(arg0: vector<u8>) : 0x1::ascii::String {
        0x1::ascii::string(arg0)
    }

    public entry fun toggle_mint(arg0: &mut GameState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.mint_enabled = !arg0.mint_enabled;
        if (!arg0.mint_enabled) {
            arg0.game_started = true;
            arg0.last_update = 0x2::clock::timestamp_ms(arg1);
        };
    }

    public entry fun toggle_whitelist(arg0: &mut GameState, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.whitelist_active = arg1;
    }

    public fun total_alive(arg0: &GameState) : u64 {
        arg0.total_alive
    }

    public fun total_supply(arg0: &GameState) : u64 {
        arg0.total_supply
    }

    public entry fun transfer_nft(arg0: &mut GameState, arg1: &mut NFT, arg2: address) {
        0x2::table::borrow_mut<0x2::object::ID, NFTRegistry>(&mut arg0.nft_registry, 0x2::object::uid_to_inner(&arg1.id)).owner = arg2;
    }

    public entry fun update_champion_image(arg0: &mut GameState, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        assert!(!arg0.mint_enabled, 3);
        assert!(!arg0.game_started || arg0.game_ended, 5);
        arg0.champion_image = arg1;
    }

    public entry fun update_champion_nft(arg0: &GameState, arg1: &mut NFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.game_id == 0x2::object::uid_to_inner(&arg0.id), 4);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::table::contains<0x2::object::ID, NFTRegistry>(&arg0.nft_registry, v0), 13);
        assert!(0x2::table::borrow<0x2::object::ID, NFTRegistry>(&arg0.nft_registry, v0).trait == 0x1::string::utf8(b"Champion"), 4);
        arg1.trait = 0x1::string::utf8(b"Champion");
        arg1.image_url = 0x2::url::new_unsafe(to_ascii_string(arg0.champion_image));
        arg1.current_day = arg0.current_day;
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"game"), number_to_string(arg1.game_round));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"round"), number_to_string(arg1.current_day));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"status"), arg1.trait);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"champion"), 0x1::string::utf8(b"true"));
        arg1.attributes = v1;
        let v2 = ChampionUpdateEvent{
            nft_id     : v0,
            game_round : arg1.game_round,
            owner      : 0x2::tx_context::sender(arg2),
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<ChampionUpdateEvent>(v2);
    }

    public entry fun update_daily_images(arg0: &mut GameState, arg1: vector<vector<u8>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        assert!(0x1::vector::length<vector<u8>>(&arg1) >= 11, 20);
        assert!(!arg0.mint_enabled, 3);
        assert!(!arg0.game_started || arg0.game_ended, 5);
        arg0.daily_images = arg1;
    }

    public entry fun update_day_image(arg0: &mut GameState, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        assert!(arg1 <= 11, 8);
        assert!(!arg0.mint_enabled, 3);
        assert!(!arg0.game_started || arg0.game_ended, 5);
        assert!(0x1::vector::length<vector<u8>>(&arg0.daily_images) > arg1, 20);
        *0x1::vector::borrow_mut<vector<u8>>(&mut arg0.daily_images, arg1) = arg2;
    }

    public entry fun update_dead_image(arg0: &mut GameState, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        assert!(!arg0.mint_enabled, 3);
        assert!(!arg0.game_started || arg0.game_ended, 5);
        arg0.dead_image = arg1;
    }

    public entry fun update_game_images(arg0: &mut GameState, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 4);
        assert!(0x1::vector::length<vector<u8>>(&arg1) >= 11, 20);
        assert!(!arg0.mint_enabled, 3);
        assert!(!arg0.game_started || arg0.game_ended, 5);
        arg0.daily_images = arg1;
        arg0.dead_image = arg2;
        arg0.champion_image = arg3;
    }

    public entry fun update_game_state(arg0: &mut GameState, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        assert!(arg0.game_started, 5);
        assert!(!arg0.game_ended, 7);
        assert!(arg0.current_day < 11, 8);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.last_update + arg0.seconds_in_day, 6);
        arg0.current_day = arg0.current_day + 1;
        let v1 = &arg0.daily_images;
        let v2 = if (arg0.current_day < 0x1::vector::length<vector<u8>>(v1)) {
            arg0.current_day
        } else {
            0x1::vector::length<vector<u8>>(v1) - 1
        };
        let v3 = *0x1::vector::borrow<vector<u8>>(v1, v2);
        let v4 = 0;
        let v5 = get_alive_nfts(arg0);
        let v6 = 0x2::random::new_generator(arg1, arg3);
        if (0x1::vector::length<0x2::object::ID>(&v5) <= 1) {
            let v7 = 0;
            let v8 = *0x1::vector::borrow<0x2::object::ID>(&v5, 0x2::random::generate_u64_in_range(&mut v6, 0, 0x1::vector::length<0x2::object::ID>(&v5) - 1));
            arg0.alive_nft_ids = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.alive_nft_ids, v8);
            while (v7 < 0x1::vector::length<0x2::object::ID>(&v5)) {
                let v9 = *0x1::vector::borrow<0x2::object::ID>(&v5, v7);
                if (v9 != v8) {
                    mark_nft_as_dead(arg0, v9);
                    v4 = v4 + 1;
                };
                v7 = v7 + 1;
            };
            arg0.total_alive = 1;
        } else {
            let v10 = 0;
            let v11 = 0x1::vector::length<0x2::object::ID>(&v5);
            while (v10 < calculate_eliminations(0x1::vector::length<0x2::object::ID>(&v5), 0) && v11 > 0) {
                let v12 = 0x2::random::generate_u64_in_range(&mut v6, 0, v11 - 1);
                if (v12 < v11 - 1) {
                    *0x1::vector::borrow_mut<0x2::object::ID>(&mut v5, v12) = *0x1::vector::borrow<0x2::object::ID>(&v5, v11 - 1);
                };
                mark_nft_as_dead(arg0, *0x1::vector::borrow<0x2::object::ID>(&v5, v12));
                v11 = v11 - 1;
                v10 = v10 + 1;
            };
            v4 = v10;
        };
        if (arg0.current_day == 11 && arg0.total_alive > 1) {
            arg0.alive_nft_ids = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.alive_nft_ids, *0x1::vector::borrow<0x2::object::ID>(&arg0.alive_nft_ids, 0x2::random::generate_u64_in_range(&mut v6, 0, arg0.total_alive - 1)));
            v4 = arg0.total_alive - 1;
            arg0.total_alive = 1;
        };
        let v13 = DayChangeEvent{
            day_number       : arg0.current_day,
            alive_count      : arg0.total_alive,
            eliminated_count : v4,
            new_image        : 0x1::string::utf8(v3),
            timestamp        : v0,
        };
        0x2::event::emit<DayChangeEvent>(v13);
        arg0.last_update = v0;
    }

    public entry fun update_nft_status(arg0: &GameState, arg1: &mut NFT) {
        assert!(arg1.game_id == 0x2::object::uid_to_inner(&arg0.id), 4);
        assert!(arg1.game_round == arg0.current_round, 4);
        verify_status_update(arg0, arg1);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"game"), number_to_string(arg1.game_round));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"round"), number_to_string(arg1.current_day));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"status"), arg1.trait);
        if (arg1.trait == 0x1::string::utf8(b"Champion")) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"champion"), 0x1::string::utf8(b"true"));
        };
        arg1.attributes = v0;
    }

    public entry fun update_nfts_with_attributes(arg0: &GameState, arg1: vector<NFT>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::length<NFT>(&arg1);
        while (v0 < v1) {
            let v2 = 0x1::vector::borrow_mut<NFT>(&mut arg1, v0);
            assert!(v2.game_id == 0x2::object::uid_to_inner(&arg0.id), 4);
            assert!(v2.game_round == arg0.current_round, 4);
            verify_status_update(arg0, v2);
            let v3 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"game"), number_to_string(v2.game_round));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"round"), number_to_string(v2.current_day));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"status"), v2.trait);
            if (v2.trait == 0x1::string::utf8(b"Champion")) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"champion"), 0x1::string::utf8(b"true"));
            };
            v2.attributes = v3;
            v0 = v0 + 1;
        };
        let v4 = 0;
        while (v4 < v1) {
            0x2::transfer::public_transfer<NFT>(0x1::vector::pop_back<NFT>(&mut arg1), 0x2::tx_context::sender(arg2));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<NFT>(arg1);
    }

    public entry fun update_royalty_percentage(arg0: &mut GameState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        assert!(arg1 <= 1000, 17);
        arg0.royalty_info.royalty_basis_points = arg1;
    }

    public entry fun update_royalty_recipient(arg0: &mut GameState, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.royalty_info.royalty_recipient = arg1;
    }

    public entry fun update_wallet_nfts(arg0: &GameState, arg1: vector<NFT>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::length<NFT>(&arg1);
        while (v0 < v1) {
            let v2 = 0x1::vector::borrow_mut<NFT>(&mut arg1, v0);
            assert!(v2.game_id == 0x2::object::uid_to_inner(&arg0.id), 4);
            assert!(v2.game_round == arg0.current_round, 4);
            verify_status_update(arg0, v2);
            let v3 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"game"), number_to_string(v2.game_round));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"round"), number_to_string(v2.current_day));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"status"), v2.trait);
            if (v2.trait == 0x1::string::utf8(b"Champion")) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"champion"), 0x1::string::utf8(b"true"));
            };
            v2.attributes = v3;
            v0 = v0 + 1;
        };
        let v4 = 0;
        while (v4 < v1) {
            0x2::transfer::public_transfer<NFT>(0x1::vector::pop_back<NFT>(&mut arg1), 0x2::tx_context::sender(arg2));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<NFT>(arg1);
    }

    fun verify_status_update(arg0: &GameState, arg1: &mut NFT) {
        let (v0, v1) = check_nft_registry_status(arg0, 0x2::object::uid_to_inner(&arg1.id));
        arg1.trait = v1;
        assert!(arg1.trait == v1, 14);
        if (v1 == 0x1::string::utf8(b"Champion")) {
            let v2 = to_ascii_string(arg0.champion_image);
            arg1.image_url = 0x2::url::new_unsafe(v2);
            assert!(0x2::url::inner_url(&arg1.image_url) == v2, 15);
        } else if (!v0) {
            let v3 = to_ascii_string(arg0.dead_image);
            arg1.image_url = 0x2::url::new_unsafe(v3);
            assert!(0x2::url::inner_url(&arg1.image_url) == v3, 15);
        } else {
            let v4 = &arg0.daily_images;
            let v5 = if (arg0.current_day < 0x1::vector::length<vector<u8>>(v4)) {
                arg0.current_day
            } else {
                0x1::vector::length<vector<u8>>(v4) - 1
            };
            let v6 = to_ascii_string(*0x1::vector::borrow<vector<u8>>(v4, v5));
            arg1.image_url = 0x2::url::new_unsafe(v6);
            assert!(0x2::url::inner_url(&arg1.image_url) == v6, 15);
        };
        arg1.current_day = arg0.current_day;
    }

    // decompiled from Move bytecode v6
}

