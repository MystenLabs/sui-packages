module 0x7f8ad597e589e66606c4f5f484cb5a3e808701483dd43afe61cec10b97961745::core {
    struct Nfts has store, key {
        id: 0x2::object::UID,
        price_usd: 0x2::vec_map::VecMap<u8, u64>,
        name: 0x2::vec_map::VecMap<u8, 0x1::string::String>,
        description: 0x2::vec_map::VecMap<u8, 0x1::string::String>,
        uri: 0x2::vec_map::VecMap<u8, 0x1::ascii::String>,
        percent_grow: 0x2::vec_map::VecMap<u8, u64>,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct KExt has drop {
        dummy_field: bool,
    }

    struct Motodex has key {
        id: 0x2::object::UID,
        token_owner: 0x2::vec_map::VecMap<u256, address>,
        owners: vector<address>,
        game_servers: vector<address>,
        minimal_fee: u64,
        epoch_minimal_interval: u64,
        min_game_session_duration: u64,
        max_moto_per_session: u64,
        token_types: 0x2::vec_map::VecMap<address, u8>,
        token_health: 0x2::vec_map::VecMap<address, u64>,
        percent_for_track: 0x2::vec_map::VecMap<address, u64>,
        price_main_coin_usd: u64,
        one_main_coin: u64,
        game_sessions: 0x2::vec_map::VecMap<address, GameSession>,
        game_bids: 0x2::vec_map::VecMap<address, TrackGameBid>,
        nft_owners: 0x2::vec_map::VecMap<address, TokenInfo>,
        latest_epoch_update: u64,
        counter: u256,
        total_supply: u256,
        nfts: Nfts,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TokenInfo has copy, drop, store {
        owner_id: address,
        token_type: u8,
        active_session: 0x1::option::Option<address>,
        collected_fee: u64,
    }

    struct GameBid has copy, drop, store {
        amount: u64,
        moto: address,
        timestamp: u64,
        bidder: address,
    }

    struct TrackGameBid has copy, drop, store {
        game_bids: vector<GameBid>,
    }

    struct GameSessionMoto has copy, drop, store {
        moto_owner: address,
        moto_nft: address,
        last_track_time_result: u64,
    }

    struct EpochPayment has copy, drop, store {
        track_token: address,
        moto_token: 0x1::option::Option<address>,
        receiver_type: u8,
        amount: u64,
        receiver_id: address,
    }

    struct GameSession has copy, drop, store {
        init_time: u64,
        track_token: address,
        moto: vector<GameSessionMoto>,
        latest_update_time: u64,
        latest_track_time_result: u64,
        attempts: u64,
        game_bids_sum: u64,
        game_fees_sum: u64,
        current_winner_moto: 0x1::option::Option<GameSessionMoto>,
        epoch_payment: vector<EpochPayment>,
        max_moto_per_session: u64,
    }

    struct FinalGameSessionView has copy, drop {
        finished_at: u64,
        track_token: address,
        winner_account: address,
        winner_nft: address,
        winner_result: u64,
        total_attempts: u64,
        total_balance: u64,
        payments: vector<EpochPayment>,
    }

    struct MotodexNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        owner: address,
        type_final: u8,
        health: u64,
        price: u64,
    }

    struct MintEvent has copy, drop {
        from: address,
        nft: address,
        type_nft: u8,
        timestamp: u64,
    }

    struct PurchaseEvent has copy, drop {
        from: address,
        nft: address,
        type_nft: u8,
        timestamp: u64,
        value: u64,
    }

    struct AddNFTEvent has copy, drop {
        from: address,
        to: address,
        nft: address,
        type_nft: u8,
        timestamp: u64,
        value: u64,
    }

    struct ReturnNFTEvent has copy, drop {
        from: address,
        nft: address,
        type_nft: u8,
        timestamp: u64,
    }

    struct AddHealthMoney has copy, drop {
        from: address,
        nft: address,
        type_nft: u8,
        timestamp: u64,
        value: u64,
    }

    struct AddHealthNFT has copy, drop {
        from: address,
        nft: address,
        type_nft: u8,
        timestamp: u64,
        health_pill: address,
    }

    struct CreateOrUpdateGameSession has copy, drop {
        from: address,
        track: address,
        moto: address,
        timestamp: u64,
        last_track_time_result: u64,
    }

    struct AddBid has copy, drop {
        bidder: address,
        track: address,
        moto: address,
        timestamp: u64,
        amount: u64,
    }

    struct RemoveBidNFTEvent has copy, drop {
        bidder: address,
        track: address,
        moto: address,
        timestamp: u64,
        amount: u64,
    }

    struct AfterSyncSession has copy, drop {
        final_game_session_view: FinalGameSessionView,
    }

    struct UpdateCounterEvent has copy, drop {
        from: address,
        timestamp: u64,
    }

    struct CORE has drop {
        dummy_field: bool,
    }

    public entry fun add_bid(arg0: &mut Motodex, arg1: &MotodexNFT, arg2: &MotodexNFT, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= arg3, 17);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        let v0 = GameBid{
            amount    : arg3,
            moto      : 0x2::object::id_address<MotodexNFT>(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg4),
            bidder    : 0x2::tx_context::sender(arg6),
        };
        let v1 = 0x2::object::id_address<MotodexNFT>(arg1);
        if (0x2::vec_map::contains<address, TrackGameBid>(&arg0.game_bids, &v1)) {
            let v2 = 0x2::object::id_address<MotodexNFT>(arg1);
            let (_, v4) = 0x2::vec_map::remove<address, TrackGameBid>(&mut arg0.game_bids, &v2);
            let v5 = v4;
            let v6 = v5.game_bids;
            let v7 = 0x1::vector::length<GameBid>(&v6) - 1;
            let v8 = false;
            while (v7 > 0) {
                let v9 = 0x1::vector::borrow<GameBid>(&v6, v7);
                v7 = v7 - 1;
                if (v9.moto == 0x2::object::id_address<MotodexNFT>(arg2) && v9.bidder == 0x2::tx_context::sender(arg6)) {
                    v8 = true;
                    break
                };
            };
            if (v8) {
                v0.amount = v0.amount + 0x1::vector::borrow_mut<GameBid>(&mut v6, v7).amount;
                0x1::vector::remove<GameBid>(&mut v6, v7);
                0x1::vector::push_back<GameBid>(&mut v6, v0);
            } else {
                0x1::vector::push_back<GameBid>(&mut v6, v0);
            };
            let v10 = TrackGameBid{game_bids: v6};
            0x2::vec_map::insert<address, TrackGameBid>(&mut arg0.game_bids, 0x2::object::id_address<MotodexNFT>(arg1), v10);
        } else {
            let v11 = 0x1::vector::empty<GameBid>();
            0x1::vector::push_back<GameBid>(&mut v11, v0);
            let v12 = TrackGameBid{game_bids: v11};
            0x2::vec_map::insert<address, TrackGameBid>(&mut arg0.game_bids, 0x2::object::id_address<MotodexNFT>(arg1), v12);
        };
        let v13 = 0x2::object::id_address<MotodexNFT>(arg1);
        let (_, v15) = 0x2::vec_map::remove<address, GameSession>(&mut arg0.game_sessions, &v13);
        let v16 = v15;
        v16.game_bids_sum = v16.game_bids_sum + arg3;
        0x2::vec_map::insert<address, GameSession>(&mut arg0.game_sessions, 0x2::object::id_address<MotodexNFT>(arg1), v16);
        let v17 = AddBid{
            bidder    : 0x2::tx_context::sender(arg6),
            track     : 0x2::object::id_address<MotodexNFT>(arg1),
            moto      : 0x2::object::id_address<MotodexNFT>(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg4),
            amount    : arg3,
        };
        0x2::event::emit<AddBid>(v17);
    }

    public entry fun add_health_money(arg0: &mut Motodex, arg1: &MotodexNFT, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_address<MotodexNFT>(arg1);
        let v1 = 0x2::object::id_address<MotodexNFT>(arg1);
        let (_, v3) = 0x2::vec_map::remove<address, u64>(&mut arg0.token_health, &v1);
        let v4 = internal_get_price_for_type(*0x2::vec_map::get<address, u8>(&arg0.token_types, &v0), arg0);
        assert!(v4 > 0, 1);
        let v5 = v4 - v3;
        assert!(v5 > 0, 18);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v4, 17);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v6 = AddHealthMoney{
            from      : 0x2::tx_context::sender(arg4),
            nft       : 0x2::object::id_address<MotodexNFT>(arg1),
            type_nft  : internal_get_type_for(0x2::object::id_address<MotodexNFT>(arg1), arg0),
            timestamp : 0x2::clock::timestamp_ms(arg2),
            value     : v5,
        };
        0x2::event::emit<AddHealthMoney>(v6);
        0x2::vec_map::insert<address, u64>(&mut arg0.token_health, 0x2::object::id_address<MotodexNFT>(arg1), v4);
    }

    public entry fun add_health_nft(arg0: &mut Motodex, arg1: &MotodexNFT, arg2: MotodexNFT, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_address<MotodexNFT>(arg1);
        let v1 = 0x2::vec_map::get<address, u8>(&arg0.token_types, &v0);
        let v2 = 0x2::object::id_address<MotodexNFT>(&arg2);
        let v3 = 0x2::vec_map::get<address, u8>(&arg0.token_types, &v2);
        assert!(*v3 == 7 || *v3 == 8 || *v3 == 9 || *v3 == 10, 3);
        let v4 = 0x2::object::id_address<MotodexNFT>(arg1);
        let (_, v6) = 0x2::vec_map::remove<address, u64>(&mut arg0.token_health, &v4);
        let v7 = internal_get_price_for_type(*v1, arg0);
        assert!(v7 > 0, 1);
        assert!(v7 - v6 > 0, 18);
        let v8 = AddHealthNFT{
            from        : 0x2::tx_context::sender(arg4),
            nft         : 0x2::object::id_address<MotodexNFT>(arg1),
            type_nft    : internal_get_type_for(0x2::object::id_address<MotodexNFT>(arg1), arg0),
            timestamp   : 0x2::clock::timestamp_ms(arg3),
            health_pill : 0x2::object::id_address<MotodexNFT>(&arg2),
        };
        0x2::event::emit<AddHealthNFT>(v8);
        0x2::vec_map::insert<address, u64>(&mut arg0.token_health, 0x2::object::id_address<MotodexNFT>(arg1), v7);
        let MotodexNFT {
            id          : v9,
            name        : _,
            description : _,
            url         : _,
            owner       : _,
            type_final  : _,
            health      : _,
            price       : _,
        } = arg2;
        0x2::object::delete(v9);
    }

    public entry fun add_nft(arg0: &mut Motodex, arg1: &MotodexNFT, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        internal_add_nft(arg3, arg1, arg0, arg2, arg4);
    }

    public entry fun admin_add_game_server(arg0: &mut Motodex, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        0x1::vector::push_back<address>(&mut arg0.game_servers, arg1);
    }

    public entry fun admin_add_owner(arg0: &mut Motodex, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        0x1::vector::push_back<address>(&mut arg0.owners, arg1);
    }

    public fun admin_collect_profits(arg0: &OwnerCap, arg1: &mut Motodex, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun admin_mint_nft(arg0: &mut Motodex, arg1: u8, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg4);
        internal_mint_nft(arg2, arg1, arg0, arg3, arg4);
    }

    public entry fun admin_mint_nft_batch(arg0: &mut Motodex, arg1: vector<u8>, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg4);
        let v0 = 0x1::vector::length<u8>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            internal_mint_nft(*0x1::vector::borrow<address>(&arg2, v0), *0x1::vector::borrow<u8>(&arg1, v0), arg0, arg3, arg4);
        };
    }

    public entry fun admin_remove_game_server(arg0: &mut Motodex, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.game_servers, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.game_servers, v1);
        };
    }

    public entry fun admin_remove_game_session(arg0: &mut Motodex, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        let (_, _) = 0x2::vec_map::remove<address, GameSession>(&mut arg0.game_sessions, &arg1);
    }

    public entry fun admin_remove_owner(arg0: &mut Motodex, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.owners, &arg1);
        if (v0 && 0x1::vector::length<address>(&arg0.owners) > 1) {
            0x1::vector::remove<address>(&mut arg0.owners, v1);
        };
    }

    public entry fun admin_set_description_for_type(arg0: &mut Motodex, arg1: u8, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg3);
        let (_, _) = 0x2::vec_map::remove<u8, 0x1::string::String>(&mut arg0.nfts.description, &arg1);
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut arg0.nfts.description, arg1, arg2);
    }

    public entry fun admin_set_epoch_minimal_interval(arg0: &mut Motodex, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        arg0.epoch_minimal_interval = arg1;
    }

    public entry fun admin_set_health_for(arg0: &mut Motodex, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg3);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.token_health, &arg1);
        0x2::vec_map::insert<address, u64>(&mut arg0.token_health, arg1, arg2);
    }

    public entry fun admin_set_min_game_session_duration(arg0: &mut Motodex, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        arg0.min_game_session_duration = arg1;
    }

    public entry fun admin_set_minimal_fee(arg0: &mut Motodex, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        arg0.minimal_fee = arg1;
    }

    public entry fun admin_set_name_for_type(arg0: &mut Motodex, arg1: u8, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg3);
        let (_, _) = 0x2::vec_map::remove<u8, 0x1::string::String>(&mut arg0.nfts.name, &arg1);
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut arg0.nfts.name, arg1, arg2);
    }

    public entry fun admin_set_percent_for_track_owner(arg0: &mut Motodex, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg3);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.percent_for_track, &arg1);
        0x2::vec_map::insert<address, u64>(&mut arg0.percent_for_track, arg1, arg2);
    }

    public entry fun admin_set_percent_grow(arg0: &mut Motodex, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg3);
        let (_, _) = 0x2::vec_map::remove<u8, u64>(&mut arg0.nfts.percent_grow, &arg1);
        0x2::vec_map::insert<u8, u64>(&mut arg0.nfts.percent_grow, arg1, arg2);
    }

    public entry fun admin_set_price_for_type(arg0: &mut Motodex, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg3);
        let (_, _) = 0x2::vec_map::remove<u8, u64>(&mut arg0.nfts.price_usd, &arg1);
        0x2::vec_map::insert<u8, u64>(&mut arg0.nfts.price_usd, arg1, arg2);
    }

    public entry fun admin_set_price_main_coin_usd(arg0: &mut Motodex, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        arg0.price_main_coin_usd = arg1;
    }

    public entry fun admin_set_uri_for_type(arg0: &mut Motodex, arg1: u8, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg3);
        let (_, _) = 0x2::vec_map::remove<u8, 0x1::ascii::String>(&mut arg0.nfts.uri, &arg1);
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut arg0.nfts.uri, arg1, arg2);
    }

    fun check_game_server(arg0: &Motodex, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg0.game_servers)) {
            if (*0x1::vector::borrow<address>(&arg0.game_servers, v0) == 0x2::tx_context::sender(arg1)) {
                v1 = true;
            };
            v0 = v0 + 1;
        };
        assert!(v1 == true, 0);
    }

    fun check_owner(arg0: &Motodex, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg0.owners)) {
            if (*0x1::vector::borrow<address>(&arg0.owners, v0) == 0x2::tx_context::sender(arg1)) {
                v1 = true;
            };
            v0 = v0 + 1;
        };
        assert!(v1 == true, 0);
    }

    public entry fun game_server_create_or_update_game_session_for(arg0: &mut Motodex, arg1: address, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_game_server(arg0, arg5);
        assert!(0x2::vec_map::contains<address, TokenInfo>(&arg0.nft_owners, &arg1), 5);
        assert!(0x2::vec_map::contains<address, TokenInfo>(&arg0.nft_owners, &arg2), 5);
        assert!(internal_get_health_for(arg1, arg0) > 0, 6);
        assert!(internal_get_health_for(arg2, arg0) > 0, 6);
        let (_, v1) = 0x2::vec_map::remove<address, TokenInfo>(&mut arg0.nft_owners, &arg2);
        let v2 = v1;
        let v3 = TokenInfo{
            owner_id       : 0x2::tx_context::sender(arg5),
            token_type     : v2.token_type,
            active_session : v2.active_session,
            collected_fee  : v2.collected_fee,
        };
        assert!(v3.collected_fee > 0, 15);
        let v4 = GameSessionMoto{
            moto_owner             : v3.owner_id,
            moto_nft               : arg2,
            last_track_time_result : arg3,
        };
        let v5 = if (0x2::vec_map::contains<address, GameSession>(&arg0.game_sessions, &arg1)) {
            let (_, v7) = 0x2::vec_map::remove<address, GameSession>(&mut arg0.game_sessions, &arg1);
            let v8 = v7;
            let v9 = 0x1::vector::empty<GameSessionMoto>();
            0x1::vector::push_back<GameSessionMoto>(&mut v9, v4);
            let v10 = v8.moto;
            let v11 = 0x1::vector::length<GameSessionMoto>(&v10) - 1;
            while (v11 > 0) {
                let v12 = 0x1::vector::remove<GameSessionMoto>(&mut v8.moto, v11);
                if (v12.moto_nft == arg2) {
                    continue
                };
                0x1::vector::push_back<GameSessionMoto>(&mut v9, v12);
                v11 = v11 - 1;
            };
            v8.game_fees_sum = v8.game_fees_sum + v3.collected_fee;
            v3.collected_fee = 0;
            GameSession{init_time: v8.init_time, track_token: v8.track_token, moto: v9, latest_update_time: v8.latest_update_time, latest_track_time_result: v8.latest_track_time_result, attempts: v8.attempts, game_bids_sum: v8.game_bids_sum, game_fees_sum: v8.game_fees_sum, current_winner_moto: v8.current_winner_moto, epoch_payment: v8.epoch_payment, max_moto_per_session: v8.max_moto_per_session}
        } else {
            let v13 = 0x1::vector::empty<GameSessionMoto>();
            0x1::vector::push_back<GameSessionMoto>(&mut v13, v4);
            GameSession{init_time: 0x2::clock::timestamp_ms(arg4), track_token: arg1, moto: v13, latest_update_time: 0, latest_track_time_result: 0, attempts: 0, game_bids_sum: 0, game_fees_sum: v3.collected_fee, current_winner_moto: 0x1::option::none<GameSessionMoto>(), epoch_payment: 0x1::vector::empty<EpochPayment>(), max_moto_per_session: 1}
        };
        if (arg3 > 0) {
            v5.attempts = v5.attempts + 1;
            v5.latest_track_time_result = arg3;
        };
        v5.latest_update_time = 0x2::clock::timestamp_ms(arg4);
        let v14 = v4;
        let v15 = 0x1::vector::length<GameSessionMoto>(&v5.moto) - 1;
        while (v15 > 0) {
            let v16 = 0x1::vector::remove<GameSessionMoto>(&mut v5.moto, v15);
            if (v16.last_track_time_result < v14.last_track_time_result) {
                v14 = v16;
            };
            0x1::vector::insert<GameSessionMoto>(&mut v5.moto, v16, v15);
            v15 = v15 - 1;
        };
        v5.current_winner_moto = 0x1::option::some<GameSessionMoto>(v14);
        0x2::vec_map::insert<address, GameSession>(&mut arg0.game_sessions, arg1, v5);
        let v17 = CreateOrUpdateGameSession{
            from                   : 0x2::tx_context::sender(arg5),
            track                  : arg1,
            moto                   : arg2,
            timestamp              : 0x2::clock::timestamp_ms(arg4),
            last_track_time_result : arg3,
        };
        0x2::event::emit<CreateOrUpdateGameSession>(v17);
        0x2::vec_map::insert<address, TokenInfo>(&mut arg0.nft_owners, arg2, v2);
    }

    public entry fun game_server_sync_epoch(arg0: &OwnerCap, arg1: &mut Motodex, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_game_server(arg1, arg4);
        internal_sync_epoch_game_session(arg2, arg1, arg3, arg4);
    }

    public fun get_counter(arg0: &Motodex) : u256 {
        arg0.counter
    }

    public fun get_game_bids(arg0: &Motodex) : 0x2::vec_map::VecMap<address, TrackGameBid> {
        arg0.game_bids
    }

    public fun get_game_servers(arg0: &Motodex) : vector<address> {
        arg0.game_servers
    }

    public fun get_game_sessions(arg0: &Motodex) : 0x2::vec_map::VecMap<address, GameSession> {
        arg0.game_sessions
    }

    public fun get_health_for(arg0: &Motodex, arg1: address) : u64 {
        internal_get_health_for(arg1, arg0)
    }

    public fun get_latest_epoch_update(arg0: &Motodex) : u64 {
        arg0.latest_epoch_update
    }

    public fun get_minimal_fee(arg0: &Motodex) : u64 {
        arg0.minimal_fee
    }

    public fun get_nft_owners(arg0: &Motodex) : 0x2::vec_map::VecMap<address, TokenInfo> {
        arg0.nft_owners
    }

    public fun get_owners(arg0: &Motodex) : vector<address> {
        arg0.owners
    }

    public fun get_percent_for_track_owner(arg0: &Motodex, arg1: address) : u64 {
        *0x2::vec_map::get<address, u64>(&arg0.percent_for_track, &arg1)
    }

    public fun get_price_for_type(arg0: &Motodex, arg1: u8) : u64 {
        internal_get_price_for_type(arg1, arg0)
    }

    public fun get_price_for_type_usd(arg0: &Motodex, arg1: u8) : u64 {
        internal_get_price_for_type_usd(arg1, arg0)
    }

    public fun get_price_main_coin_usd(arg0: &Motodex) : u64 {
        arg0.price_main_coin_usd
    }

    public fun get_total_supply(arg0: &Motodex) : u256 {
        arg0.total_supply
    }

    public fun get_type_for(arg0: &Motodex, arg1: address) : u8 {
        internal_get_type_for(arg1, arg0)
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CORE>(arg0, arg1);
        internal_init_module(arg1);
    }

    fun internal_add_nft(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &MotodexNFT, arg2: &mut Motodex, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = arg2.minimal_fee;
        assert!(v0 > 0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 17);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v1 = TokenInfo{
            owner_id       : arg1.owner,
            token_type     : internal_get_type_for(0x2::object::id_address<MotodexNFT>(arg1), arg2),
            active_session : 0x1::option::none<address>(),
            collected_fee  : v0,
        };
        0x2::vec_map::insert<address, TokenInfo>(&mut arg2.nft_owners, 0x2::object::id_address<MotodexNFT>(arg1), v1);
        let v2 = AddNFTEvent{
            from      : 0x2::tx_context::sender(arg4),
            to        : @0x0,
            nft       : 0x2::object::id_address<MotodexNFT>(arg1),
            type_nft  : internal_get_type_for(0x2::object::id_address<MotodexNFT>(arg1), arg2),
            timestamp : 0x2::clock::timestamp_ms(arg3),
            value     : v0,
        };
        0x2::event::emit<AddNFTEvent>(v2);
    }

    fun internal_get_health_for(arg0: address, arg1: &Motodex) : u64 {
        *0x2::vec_map::get<address, u64>(&arg1.token_health, &arg0)
    }

    fun internal_get_price_for_type(arg0: u8, arg1: &Motodex) : u64 {
        internal_get_price_for_type_usd(arg0, arg1) * arg1.one_main_coin / arg1.price_main_coin_usd
    }

    fun internal_get_price_for_type_usd(arg0: u8, arg1: &Motodex) : u64 {
        let v0 = arg1.nfts.price_usd;
        *0x2::vec_map::get<u8, u64>(&v0, &arg0)
    }

    fun internal_get_type_for(arg0: address, arg1: &Motodex) : u8 {
        *0x2::vec_map::get<address, u8>(&arg1.token_types, &arg0)
    }

    fun internal_init_module(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg0));
        let v2 = 100000000;
        let v3 = 0x2::vec_map::empty<u8, u64>();
        0x2::vec_map::insert<u8, u64>(&mut v3, 0, v2 * 1);
        0x2::vec_map::insert<u8, u64>(&mut v3, 1, v2 * 6);
        0x2::vec_map::insert<u8, u64>(&mut v3, 2, v2 * 7);
        0x2::vec_map::insert<u8, u64>(&mut v3, 3, v2 * 8);
        0x2::vec_map::insert<u8, u64>(&mut v3, 4, v2 * 9);
        0x2::vec_map::insert<u8, u64>(&mut v3, 5, v2 * 10);
        0x2::vec_map::insert<u8, u64>(&mut v3, 6, v2 * 7);
        0x2::vec_map::insert<u8, u64>(&mut v3, 7, v2 * 1);
        0x2::vec_map::insert<u8, u64>(&mut v3, 8, v2 * 3);
        0x2::vec_map::insert<u8, u64>(&mut v3, 9, v2 * 5);
        0x2::vec_map::insert<u8, u64>(&mut v3, 10, v2 * 10);
        0x2::vec_map::insert<u8, u64>(&mut v3, 100, v2 * 1);
        0x2::vec_map::insert<u8, u64>(&mut v3, 101, v2 * 50);
        0x2::vec_map::insert<u8, u64>(&mut v3, 102, v2 * 50);
        0x2::vec_map::insert<u8, u64>(&mut v3, 103, v2 * 50);
        0x2::vec_map::insert<u8, u64>(&mut v3, 104, v2 * 50);
        0x2::vec_map::insert<u8, u64>(&mut v3, 105, v2 * 50);
        0x2::vec_map::insert<u8, u64>(&mut v3, 106, v2 * 50);
        0x2::vec_map::insert<u8, u64>(&mut v3, 107, v2 * 50);
        0x2::vec_map::insert<u8, u64>(&mut v3, 108, v2 * 50);
        0x2::vec_map::insert<u8, u64>(&mut v3, 109, v2 * 50);
        let v4 = 0x2::vec_map::empty<u8, 0x1::string::String>();
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 0, 0x1::string::utf8(b"Red Bulller"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 1, 0x1::string::utf8(b"Zebra Grrrr"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 2, 0x1::string::utf8(b"Robo Horse"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 3, 0x1::string::utf8(b"Metal Eyes"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 4, 0x1::string::utf8(b"Brown Killer"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 5, 0x1::string::utf8(b"Crazy Line"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 6, 0x1::string::utf8(b"Magic box"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 7, 0x1::string::utf8(b"Health Capsule 5"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 8, 0x1::string::utf8(b"Health Capsule 10"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 9, 0x1::string::utf8(b"Health Capsule 30"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 10, 0x1::string::utf8(b"Health Capsule 50"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 100, 0x1::string::utf8(b"London"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 101, 0x1::string::utf8(b"Dubai"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 102, 0x1::string::utf8(b"Abu Dhabi"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 103, 0x1::string::utf8(b"Beijing"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 104, 0x1::string::utf8(b"Moscow"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 105, 0x1::string::utf8(b"Melbourne"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 106, 0x1::string::utf8(b"Petersburg"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 107, 0x1::string::utf8(b"Taipei"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 108, 0x1::string::utf8(b"Pisa"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v4, 109, 0x1::string::utf8(b"Islamabad"));
        let v5 = 0x2::vec_map::empty<u8, 0x1::string::String>();
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 0, 0x1::string::utf8(x"496e74726f647563696e672074686520616472656e616c696e652d6675656c656420776f726c64206f66205265642042756c6c6572206d6f746f4445582c2077686572652073706565642c20736b696c6c2c20616e64207374726174656779206d65657420696e206120686967682d7374616b657320626174746c6520666f7220766963746f72792e20416e64206e6f772c20796f752063616e206f776e2061207069656365206f662074686520616374696f6e2077697468206f7572206578636c7573697665204e46542067616d652061737365747320666561747572696e672074686520686967686c7920636f7665746564206865616c746820626f7820666976652076616c75652e0a54686573652061737365747320617265206d6f7265207468616e206a75737420706978656c73206f6e20612073637265656e2e205468657920726570726573656e742074686520756c74696d61746520696e2067616d696e672070726f776573732c20612074657374616d656e7420746f20796f7572206162696c69747920746f20646f6d696e6174652074686520636f6d7065746974696f6e20616e642073746179206f6e652073746570206168656164206f6620746865207061636b2e20416e64207769746820746865206865616c746820626f7820666976652076616c75652c20796f75276c6c206861766520746865206564676520796f75206e65656420746f207075736820796f757273656c6620746f20746865206c696d697420616e6420636f6d65206f7574206f6e20746f702e"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 1, 0x1::string::utf8(x"47657420726561647920746f20756e6c6561736820796f75722077696c6420736964652077697468205a656272612047727272722c2074686520686f7474657374206e6577204e46542067616d6520617373657473206f6e20746865206d61726b65742e2054686573652061737365747320617265206e6f7420666f7220746865206661696e74206f66206865617274202d207468657920726570726573656e742074686520756c74696d61746520696e2073706565642c20737472656e6774682c20616e64206167696c6974792c20616c6c207772617070656420757020696e20612066696572636520616e6420666561726c6573732064657369676e2e0a416e6420776974682074686520686967686c7920636f7665746564206865616c746820626f782076616c7565206f6620372c20746865736520617373657473206172652074686520756c74696d61746520706f7765722d757020666f7220616e7920736572696f75732067616d65722e20596f75276c6c2062652061626c6520746f206f75746c61737420796f7572206f70706f6e656e74732c207368727567206f66662061747461636b732c20616e6420636861726765206168656164207769746820756e627269646c656420656e6572677920616e642064657465726d696e6174696f6e2e"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 2, 0x1::string::utf8(x"5374657020696e746f2074686520667574757265206f662067616d696e67207769746820526f626f20486f7273652c2074686520756c74696d617465204e46542067616d6520617373657473207468617420636f6d62696e6520616476616e63656420746563686e6f6c6f6779207769746820736c65656b20616e6420706f77657266756c2064657369676e2e2054686573652061737365747320726570726573656e74207468652070696e6e61636c65206f662067616d696e6720706572666f726d616e63652c2064656c69766572696e67206c696768746e696e672d666173742073706565642c20756e6d61746368656420737472656e6774682c20616e6420756e706172616c6c656c656420656e647572616e63652e0a416e6420776974682074686520686967686c7920736f756768742d6166746572206865616c746820626f782076616c7565206f662031302c2074686573652061737365747320617265207669727475616c6c7920696e646573747275637469626c652e20596f75276c6c2062652061626c6520746f207765617468657220616e792073746f726d2c206f75746c61737420616e79206368616c6c656e67652c20616e6420656d6572676520766963746f72696f75732074696d6520616e642074696d6520616761696e2e"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 3, 0x1::string::utf8(x"47657420726561647920746f2074616b65206f6e2074686520636f6d7065746974696f6e2077697468204d6574616c20457965732c2074686520756c74696d617465204e46542067616d65206173736574732074686174206172652061732066696572636520617320746865792061726520666f726d696461626c652e2054686573652061737365747320726570726573656e742074686520756c74696d61746520636f6d62696e6174696f6e206f6620737472656e6774682c2073706565642c20616e64207374796c652c2077697468206120736c65656b206d6574616c6c69632064657369676e20746861742773207375726520746f2063617463682074686520657965206f6620616e792067616d696e6720656e74687573696173742e0a416e6420776974682074686520686967686c7920636f7665746564206865616c746820626f782076616c7565206f662032302c2074686573652061737365747320617265207669727475616c6c7920696e646573747275637469626c652e20596f75276c6c2062652061626c6520746f20776974687374616e64206576656e2074686520746f756768657374206368616c6c656e6765732c206f75746c61737420796f7572206f70706f6e656e74732c20616e6420656d6572676520766963746f72696f75732074696d6520616e642074696d6520616761696e2e"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 4, 0x1::string::utf8(x"5374657020696e746f2074686520776f726c64206f662042726f776e204b696c6c65722c2074686520756c74696d617465204e46542067616d6520617373657473207468617420656d626f64792074686520737069726974206f6620737472656e6774682c2073706565642c20616e6420706f7765722e205769746820746865697220736c65656b2064657369676e20616e6420756e6265617461626c6520706572666f726d616e63652c20746865736520617373657473206172652074686520756c74696d61746520746f6f6c20666f7220616e7920736572696f75732067616d6572206c6f6f6b696e6720746f20646f6d696e6174652074686520636f6d7065746974696f6e2e0a416e6420776974682074686520686967686c7920636f7665746564206865616c746820626f782076616c7565206f662033302c2042726f776e204b696c6c6572206973207669727475616c6c7920756e73746f707061626c652e20596f75276c6c2062652061626c6520746f207368727567206f66662061747461636b732c206f75746c61737420796f7572206f70706f6e656e74732c20616e6420656d6572676520766963746f72696f75732074696d6520616e642074696d6520616761696e2e"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 5, 0x1::string::utf8(x"41726520796f7520726561647920746f20676f206265796f6e6420746865206c696d6974732077697468204372617a79204c696e652c2074686520756c74696d617465204e46542067616d65206173736574732074686174206465667920636f6e76656e74696f6e20616e6420707573682074686520626f756e646172696573206f662067616d696e6720657863656c6c656e63653f205769746820746865697220626f6c6420616e642064796e616d69632064657369676e2c2074686573652061737365747320726570726573656e742074686520756c74696d61746520696e2073706565642c206167696c6974792c20616e6420737472617465676963207468696e6b696e672e0a416e6420776974682074686520686967686c7920636f7665746564206865616c746820626f782076616c7565206f662035302c204372617a79204c696e65206973207669727475616c6c7920696e646573747275637469626c652e20596f75276c6c2062652061626c6520746f206f75746c61737420616e79206368616c6c656e67652c206f766572636f6d6520616e79206f62737461636c652c20616e6420656d6572676520766963746f72696f75732074696d6520616e642074696d6520616761696e2e"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 6, 0x1::string::utf8(x"556e6c6f636b20746865206d797374657279206f662067616d696e672077697468204d6167696320426f782c2074686520756c74696d617465204e46542067616d6520617373657473207468617420617265207368726f7564656420696e207365637265637920616e642066756c6c206f66207375727072697365732e20576974682074686569722072616e646f6d6c792073656c6563746564206368617261637465722064657369676e2c20746865736520617373657473206172652074686520756c74696d6174652074657374206f6620796f75722067616d696e6720736b696c6c7320616e6420737472617465676963207468696e6b696e672e0a416e6420776974682074686520706f74656e7469616c20746f207265636569766520616e79206f662074686520686967686c7920636f766574656420636861726163746572732c204d6167696320426f78206973207472756c7920612067616d652d6368616e6765722e20596f75276c6c206861766520746865206f70706f7274756e69747920746f206578706c6f726520646966666572656e742067616d696e67207374796c657320616e6420737472617465676965732c20756e6c6f636b696e67206e6577206c6576656c73206f6620706572666f726d616e636520616e6420637265617469766974792e"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 7, 0x1::string::utf8(b"Used to replenish the lives of the player. Capsules add 5,10,30,50 lives. The starting price of items is 0.5 /1/3/5 dollars, respectively. The price of items increases by 0.1% after each new sale."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 8, 0x1::string::utf8(b"Used to replenish the lives of the player. Capsules add 5,10,30,50 lives. The starting price of items is 0.5 /1/3/5 dollars, respectively. The price of items increases by 0.1% after each new sale."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 9, 0x1::string::utf8(b"Used to replenish the lives of the player. Capsules add 5,10,30,50 lives. The starting price of items is 0.5 /1/3/5 dollars, respectively. The price of items increases by 0.1% after each new sale."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 10, 0x1::string::utf8(b"Used to replenish the lives of the player. Capsules add 5,10,30,50 lives. The starting price of items is 0.5 /1/3/5 dollars, respectively. The price of items increases by 0.1% after each new sale."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 100, 0x1::string::utf8(b"A ride through the expanses of the capital of Great Britain reveals to the racers all the beauty of the Palace of Westminster and its main attraction - the Big Ben clock tower."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 101, 0x1::string::utf8(b"The Dubai track is located in the heart of the elite metropolis of the UAE. Landscape with luxurious skyscrapers and the tourist gem of the city - the hotel Parus."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 102, 0x1::string::utf8(b"The Abu Dhabi Circuit takes racers into a world of sandy desert and urban oasis in the form of buildings made of glass and concrete."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 103, 0x1::string::utf8(b"Endless green fields and the world-famous Great Wall of China are the scenery enjoyed by racers on the Beijing circuit."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 104, 0x1::string::utf8(b"The bewitching Kremlin, the famous clock tower and the Patriarch's Ponds make a textbook landscape that opens up to riders on the Moscow track."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 105, 0x1::string::utf8(b"The Melbourne circuit is a mix of all the most striking sights of Australia - its delightful business centers and the famous Sydney Opera House."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 106, 0x1::string::utf8(b"Petersburg highway is a track with a view of the urban glass forest of multi-storey business centers of the St. Petersburg Plaza business complex."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 107, 0x1::string::utf8(b"Landscape on the highway Taipei is a classic modern Asian city with luxurious multi-storey brick buildings and a famous skyscraper - in our case, Taipei."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 108, 0x1::string::utf8(b"The track in the city of Pisa is a unique Italian flavor and one of the most famous sights of Italy - the Leaning Tower of Pisa."));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v5, 109, 0x1::string::utf8(b"The race track in the capital of Pakistan is a virtual tour of the picturesque streets of the city and acquaintance with the luxurious red mosque."));
        let v6 = 0x2::vec_map::empty<u8, 0x1::ascii::String>();
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 0, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/red%20buller.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 1, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/zebra%20grr.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 2, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/robo%20horse.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 3, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/metal%20eyes.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 4, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/brown%20killer.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 5, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/crazy%20line.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 6, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/magic%20box.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 7, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/health5.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 8, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/health10.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 9, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/health30.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 10, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/health50.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 100, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/lonfon_optimized.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 101, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/dubai.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 102, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/abu%20dhabi.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 103, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/beijin.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 104, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/moscow.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 105, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/melburn_optimized.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 106, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/peterburg.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 107, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/taipei_optimized.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 108, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/pisa.gif"));
        0x2::vec_map::insert<u8, 0x1::ascii::String>(&mut v6, 109, 0x1::ascii::string(b"https://openbisea.mypinata.cloud/ipfs/QmQWJNzPhyMSpaE6Wwaxry46AuAG1bpWrQoG3PpotLbjzY/islamabad.gif"));
        let v7 = 0x2::vec_map::empty<u8, u64>();
        0x2::vec_map::insert<u8, u64>(&mut v7, 0, 1);
        0x2::vec_map::insert<u8, u64>(&mut v7, 1, 1);
        0x2::vec_map::insert<u8, u64>(&mut v7, 2, 1);
        0x2::vec_map::insert<u8, u64>(&mut v7, 3, 1);
        0x2::vec_map::insert<u8, u64>(&mut v7, 4, 1);
        0x2::vec_map::insert<u8, u64>(&mut v7, 5, 1);
        0x2::vec_map::insert<u8, u64>(&mut v7, 6, 1);
        0x2::vec_map::insert<u8, u64>(&mut v7, 7, 1);
        0x2::vec_map::insert<u8, u64>(&mut v7, 8, 1);
        0x2::vec_map::insert<u8, u64>(&mut v7, 9, 1);
        0x2::vec_map::insert<u8, u64>(&mut v7, 10, 1);
        0x2::vec_map::insert<u8, u64>(&mut v7, 100, 10);
        0x2::vec_map::insert<u8, u64>(&mut v7, 101, 10);
        0x2::vec_map::insert<u8, u64>(&mut v7, 102, 10);
        0x2::vec_map::insert<u8, u64>(&mut v7, 103, 10);
        0x2::vec_map::insert<u8, u64>(&mut v7, 104, 10);
        0x2::vec_map::insert<u8, u64>(&mut v7, 105, 10);
        0x2::vec_map::insert<u8, u64>(&mut v7, 106, 10);
        0x2::vec_map::insert<u8, u64>(&mut v7, 107, 10);
        0x2::vec_map::insert<u8, u64>(&mut v7, 108, 10);
        0x2::vec_map::insert<u8, u64>(&mut v7, 109, 10);
        let v8 = Nfts{
            id           : 0x2::object::new(arg0),
            price_usd    : v3,
            name         : v4,
            description  : v5,
            uri          : v6,
            percent_grow : v7,
        };
        let v9 = Motodex{
            id                        : 0x2::object::new(arg0),
            token_owner               : 0x2::vec_map::empty<u256, address>(),
            owners                    : v1,
            game_servers              : v1,
            minimal_fee               : 1000,
            epoch_minimal_interval    : 1,
            min_game_session_duration : 1,
            max_moto_per_session      : 1000,
            token_types               : 0x2::vec_map::empty<address, u8>(),
            token_health              : 0x2::vec_map::empty<address, u64>(),
            percent_for_track         : 0x2::vec_map::empty<address, u64>(),
            price_main_coin_usd       : v2 * 7,
            one_main_coin             : v2,
            game_sessions             : 0x2::vec_map::empty<address, GameSession>(),
            game_bids                 : 0x2::vec_map::empty<address, TrackGameBid>(),
            nft_owners                : 0x2::vec_map::empty<address, TokenInfo>(),
            latest_epoch_update       : 0,
            counter                   : 0,
            total_supply              : 0,
            nfts                      : v8,
            balance                   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Motodex>(v9);
    }

    fun internal_mint_nft(arg0: address, arg1: u8, arg2: &mut Motodex, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : address {
        let v0 = arg1;
        if (arg1 == 6) {
            v0 = 3;
        };
        let v1 = internal_get_price_for_type(v0, arg2);
        let v2 = MotodexNFT{
            id          : 0x2::object::new(arg4),
            name        : *0x2::vec_map::get<u8, 0x1::string::String>(&arg2.nfts.name, &v0),
            description : *0x2::vec_map::get<u8, 0x1::string::String>(&arg2.nfts.description, &v0),
            url         : 0x2::url::new_unsafe(*0x2::vec_map::get<u8, 0x1::ascii::String>(&arg2.nfts.uri, &v0)),
            owner       : arg0,
            type_final  : v0,
            health      : v1,
            price       : v1,
        };
        0x2::vec_map::insert<address, u8>(&mut arg2.token_types, 0x2::object::id_address<MotodexNFT>(&v2), v0);
        0x2::vec_map::insert<address, u64>(&mut arg2.token_health, 0x2::object::id_address<MotodexNFT>(&v2), v1);
        if (v0 > 99) {
            0x2::vec_map::insert<address, u64>(&mut arg2.percent_for_track, 0x2::object::id_address<MotodexNFT>(&v2), 3000);
        };
        arg2.total_supply = arg2.total_supply + 1;
        let (v3, v4) = 0x2::vec_map::remove<u8, u64>(&mut arg2.nfts.price_usd, &v0);
        let v5 = v3;
        0x2::vec_map::insert<u8, u64>(&mut arg2.nfts.price_usd, v5, v4 * (100 + *0x2::vec_map::get_mut<u8, u64>(&mut arg2.nfts.percent_grow, &v5)) / 100);
        let v6 = 0x2::object::id_address<MotodexNFT>(&v2);
        0x2::transfer::transfer<MotodexNFT>(v2, arg0);
        let v7 = PurchaseEvent{
            from      : 0x2::tx_context::sender(arg4),
            nft       : v6,
            type_nft  : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
            value     : v1,
        };
        0x2::event::emit<PurchaseEvent>(v7);
        v6
    }

    fun internal_ping_session(arg0: GameSession, arg1: &Motodex) : GameSession {
        let v0 = GameSession{
            init_time                : arg0.init_time,
            track_token              : arg0.track_token,
            moto                     : arg0.moto,
            latest_update_time       : arg0.latest_update_time,
            latest_track_time_result : arg0.latest_track_time_result,
            attempts                 : arg0.attempts,
            game_bids_sum            : arg0.game_bids_sum,
            game_fees_sum            : arg0.game_fees_sum,
            current_winner_moto      : arg0.current_winner_moto,
            epoch_payment            : arg0.epoch_payment,
            max_moto_per_session     : arg0.max_moto_per_session,
        };
        if (!0x1::option::is_none<GameSessionMoto>(&v0.current_winner_moto)) {
            let v1 = v0.game_bids_sum;
            let v2 = v0.game_fees_sum;
            assert!(v2 > 0, 9);
            let v3 = 0x2::vec_map::get<address, TokenInfo>(&arg1.nft_owners, &v0.track_token);
            let v4 = v2 / 6000 * 10000;
            let v5 = v2 * *0x2::vec_map::get<address, u64>(&arg1.percent_for_track, &v0.track_token) / 10000;
            let v6 = v2 - v4 - v5;
            assert!(v6 > 0, 10);
            let v7 = 0x1::option::borrow<GameSessionMoto>(&v0.current_winner_moto);
            let v8 = EpochPayment{
                track_token   : v0.track_token,
                moto_token    : 0x1::option::some<address>(v7.moto_nft),
                receiver_type : 1,
                amount        : v4,
                receiver_id   : v7.moto_owner,
            };
            let v9 = EpochPayment{
                track_token   : v0.track_token,
                moto_token    : 0x1::option::none<address>(),
                receiver_type : 0,
                amount        : v5,
                receiver_id   : v3.owner_id,
            };
            let v10 = EpochPayment{
                track_token   : v0.track_token,
                moto_token    : 0x1::option::none<address>(),
                receiver_type : 3,
                amount        : v6,
                receiver_id   : *0x1::vector::borrow<address>(&arg1.owners, 0),
            };
            if (v1 > 0) {
                let v11 = v1 * 1000 / 10000;
                v9.amount = v9.amount + v11;
                v8.amount = v8.amount + v11;
                v10.amount = v10.amount + v11;
                let v12 = 0x2::vec_map::get<address, TrackGameBid>(&arg1.game_bids, &v0.track_token);
                let v13 = 0x1::vector::empty<GameBid>();
                let v14 = 0;
                let v15 = 0x1::vector::length<GameBid>(&v12.game_bids);
                while (v15 > 0) {
                    let v16 = v15 - 1;
                    v15 = v16;
                    let v17 = 0x1::vector::borrow<GameBid>(&v12.game_bids, v16);
                    if (v17.moto == v7.moto_nft) {
                        0x1::vector::push_back<GameBid>(&mut v13, *v17);
                        v14 = v14 + v17.amount;
                        continue
                    };
                };
                let v18 = 0x1::vector::empty<EpochPayment>();
                v15 = 0x1::vector::length<GameBid>(&v13);
                while (v15 > 0) {
                    let v19 = v15 - 1;
                    v15 = v19;
                    let v20 = 0x1::vector::borrow<GameBid>(&v13, v19);
                    let v21 = EpochPayment{
                        track_token   : v0.track_token,
                        moto_token    : 0x1::option::some<address>(v7.moto_nft),
                        receiver_type : 2,
                        amount        : v1 * 7000 / 10000 * v20.amount / v14,
                        receiver_id   : v20.bidder,
                    };
                    0x1::vector::push_back<EpochPayment>(&mut v18, v21);
                };
                if (0x1::vector::length<EpochPayment>(&v18) > 0) {
                    0x1::vector::append<EpochPayment>(&mut v0.epoch_payment, v18);
                };
            };
            if (v4 > 0) {
                0x1::vector::push_back<EpochPayment>(&mut v0.epoch_payment, v8);
            };
            if (v5 > 0) {
                0x1::vector::push_back<EpochPayment>(&mut v0.epoch_payment, v9);
            };
            if (v6 > 0) {
                0x1::vector::push_back<EpochPayment>(&mut v0.epoch_payment, v10);
            };
        } else {
            let v22 = v0.game_fees_sum + v0.game_bids_sum;
            let v23 = v22 * *0x2::vec_map::get<address, u64>(&arg1.percent_for_track, &v0.track_token) / 10000;
            let v24 = v22 - v23;
            let v25 = EpochPayment{
                track_token   : v0.track_token,
                moto_token    : 0x1::option::none<address>(),
                receiver_type : 0,
                amount        : v23,
                receiver_id   : 0x2::vec_map::get<address, TokenInfo>(&arg1.nft_owners, &v0.track_token).owner_id,
            };
            let v26 = EpochPayment{
                track_token   : v0.track_token,
                moto_token    : 0x1::option::none<address>(),
                receiver_type : 3,
                amount        : v24,
                receiver_id   : *0x1::vector::borrow<address>(&arg1.owners, 0),
            };
            if (v23 > 0) {
                0x1::vector::push_back<EpochPayment>(&mut v0.epoch_payment, v25);
            };
            if (v24 > 0) {
                0x1::vector::push_back<EpochPayment>(&mut v0.epoch_payment, v26);
            };
        };
        v0
    }

    fun internal_purchase(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: &mut Motodex, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = internal_get_price_for_type(arg1, arg2);
        assert!(v1 > 0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v1, 17);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v2 = internal_mint_nft(v0, arg1, arg2, arg3, arg4);
        let v3 = PurchaseEvent{
            from      : v0,
            nft       : v2,
            type_nft  : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
            value     : v1,
        };
        0x2::event::emit<PurchaseEvent>(v3);
        v2
    }

    fun internal_remove_game_session(arg0: GameSession, arg1: &0x2::clock::Clock, arg2: &mut Motodex) {
        let v0 = 0x1::vector::length<GameSessionMoto>(&arg0.moto);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = 0x1::vector::borrow<GameSessionMoto>(&arg0.moto, v0).moto_nft;
            let v2 = ReturnNFTEvent{
                from      : v1,
                nft       : v1,
                type_nft  : internal_get_type_for(v1, arg2),
                timestamp : 0x2::clock::timestamp_ms(arg1),
            };
            0x2::event::emit<ReturnNFTEvent>(v2);
            let (_, _) = 0x2::vec_map::remove<address, TokenInfo>(&mut arg2.nft_owners, &v1);
        };
        0x2::vec_map::get_mut<address, TokenInfo>(&mut arg2.nft_owners, &arg0.track_token).active_session = 0x1::option::none<address>();
    }

    fun internal_sync_epoch_game_session(arg0: address, arg1: &mut Motodex, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : FinalGameSessionView {
        assert!(0x2::vec_map::contains<address, TokenInfo>(&arg1.nft_owners, &arg0), 5);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg1.latest_epoch_update >= arg1.epoch_minimal_interval, 11);
        let (_, v2) = 0x2::vec_map::remove<address, GameSession>(&mut arg1.game_sessions, &arg0);
        let v3 = v2;
        assert!(v0 - v3.init_time >= arg1.min_game_session_duration, 11);
        let v4 = internal_ping_session(v3, arg1);
        assert!(0x1::vector::length<EpochPayment>(&v4.epoch_payment) > 0, 14);
        let v5 = 0;
        let v6 = 0x1::vector::length<EpochPayment>(&v4.epoch_payment);
        while (v6 > 0) {
            let v7 = v6 - 1;
            v6 = v7;
            v5 = v5 + 0x1::vector::borrow<EpochPayment>(&v4.epoch_payment, v7).amount;
        };
        assert!(v5 <= v4.game_bids_sum + v4.game_fees_sum, 13);
        v6 = 0x1::vector::length<EpochPayment>(&v4.epoch_payment);
        while (v6 > 0) {
            let v8 = v6 - 1;
            v6 = v8;
            let v9 = 0x1::vector::borrow_mut<EpochPayment>(&mut v4.epoch_payment, v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v9.amount, arg3), v9.receiver_id);
        };
        let v10 = 0x2::vec_map::keys<address, GameSession>(&arg1.game_sessions);
        if (0x1::vector::length<address>(&v10) == 1) {
            arg1.latest_epoch_update = v0;
        };
        internal_remove_game_session(v3, arg2, arg1);
        let v11 = FinalGameSessionView{
            finished_at    : v0,
            track_token    : arg0,
            winner_account : 0x1::option::borrow<GameSessionMoto>(&v4.current_winner_moto).moto_owner,
            winner_nft     : 0x1::option::borrow<GameSessionMoto>(&v4.current_winner_moto).moto_nft,
            winner_result  : 0x1::option::borrow<GameSessionMoto>(&v4.current_winner_moto).last_track_time_result,
            total_attempts : v4.attempts,
            total_balance  : v4.game_fees_sum + v4.game_bids_sum,
            payments       : v4.epoch_payment,
        };
        let v12 = AfterSyncSession{final_game_session_view: v11};
        0x2::event::emit<AfterSyncSession>(v12);
        v11
    }

    public entry fun purchase(arg0: &mut Motodex, arg1: u8, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        internal_purchase(arg3, arg1, arg0, arg2, arg4);
    }

    public entry fun return_nft(arg0: &mut Motodex, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::get<address, TokenInfo>(&mut arg0.nft_owners, &arg1).owner_id == 0x2::tx_context::sender(arg3), 0);
        let (_, _) = 0x2::vec_map::remove<address, TokenInfo>(&mut arg0.nft_owners, &arg1);
        let v2 = ReturnNFTEvent{
            from      : 0x2::tx_context::sender(arg3),
            nft       : arg1,
            type_nft  : internal_get_type_for(arg1, arg0),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ReturnNFTEvent>(v2);
    }

    public entry fun update_counter(arg0: &mut Motodex, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateCounterEvent{
            from      : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<UpdateCounterEvent>(v0);
        arg0.counter = arg0.counter + 1;
    }

    // decompiled from Move bytecode v6
}

