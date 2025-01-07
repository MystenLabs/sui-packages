module 0x8214b0df9921c724b2ce15b5a30dcbe8d557cc8edd750af432b877f28c8f555a::wave_auction {
    struct App has key {
        id: 0x2::object::UID,
        events: 0x2::table_vec::TableVec<AuctionEvent>,
        operator_pk: vector<u8>,
        version: u8,
    }

    struct AuctionEvent has store {
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        ocean_balance: 0x2::balance::Balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>,
        coin_type: u8,
        base_deposit: u64,
        min_each_deposit: u64,
        current_slot: u64,
        max_slot: u64,
        start_time: u64,
        end_time: u64,
        total_volume_withdraw: u64,
        total_ocean_reward: u64,
        balance_reward: 0x2::balance::Balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>,
        status: u8,
    }

    struct UserAuctionInfo has store, key {
        id: 0x2::object::UID,
        total_deposit: u64,
        status: u8,
        ocean_reward: u64,
    }

    struct CoinDeposited has copy, drop, store {
        event_id: u64,
        sender: address,
        coin_type: u8,
        amount: u64,
        user_auction_key: 0x1::string::String,
    }

    struct CoinWithdraw has copy, drop, store {
        event_id: u64,
        receiver: address,
        coin_type: u8,
        amount: u64,
        reward_amount: u64,
    }

    struct NftClaimed has copy, drop, store {
        event_id: u64,
        receiver: address,
    }

    struct AuctionOwnerCap has key {
        id: 0x2::object::UID,
    }

    entry fun authorize_nft(arg0: &0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NftOwnerCap, arg1: &mut App) {
        0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::authorize_app(arg0, &mut arg1.id, 0);
    }

    entry fun claim_nft(arg0: &mut App, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u16, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg1 < 0x2::table_vec::length<AuctionEvent>(&arg0.events), 1);
        let v0 = 0x2::table_vec::borrow_mut<AuctionEvent>(&mut arg0.events, arg1);
        assert!(0x2::clock::timestamp_ms(arg7) > v0.end_time, 9);
        assert!(v0.status == 1, 15);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0x1::string::utf8(b"AUCTION_CLAIM:");
        let v3 = 0x2::bcs::to_bytes<0x1::string::String>(&v2);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v1));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg1));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<vector<u8>>(&arg2));
        let v6 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v6));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<vector<u8>>(&arg3));
        let v7 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v7));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<vector<u8>>(&arg4));
        let v8 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v8));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u16>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0.operator_pk, &v3) == true, 12);
        assert!(v0.current_slot < v0.max_slot, 13);
        v0.current_slot = v0.current_slot + 1;
        let v9 = 0x2::address::to_string(v1);
        0x1::string::append_utf8(&mut v9, b"-");
        0x1::string::append(&mut v9, u64_to_string(arg1));
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v9), 10);
        let v10 = 0x2::dynamic_field::borrow_mut<0x1::string::String, UserAuctionInfo>(&mut arg0.id, v9);
        assert!(v10.status == 0, 11);
        v10.status = 1;
        inner_claim_nft(arg0, arg2, arg3, arg4, arg5, v1, arg8);
        let v11 = NftClaimed{
            event_id : arg1,
            receiver : v1,
        };
        0x2::event::emit<NftClaimed>(v11);
    }

    entry fun deposit_ocean(arg0: &mut App, arg1: u64, arg2: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1 < 0x2::table_vec::length<AuctionEvent>(&arg0.events), 1);
        let v1 = 0x2::table_vec::borrow_mut<AuctionEvent>(&mut arg0.events, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 > v1.start_time, 3);
        assert!(v2 < v1.end_time, 4);
        assert!(v1.coin_type == 1, 5);
        let v3 = 0x2::coin::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&arg2);
        assert!(v3 >= v1.min_each_deposit, 6);
        let v4 = 0x2::address::to_string(v0);
        0x1::string::append_utf8(&mut v4, b"-");
        0x1::string::append(&mut v4, u64_to_string(arg1));
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v4)) {
            assert!(v3 >= v1.base_deposit, 7);
            let v5 = UserAuctionInfo{
                id            : 0x2::object::new(arg4),
                total_deposit : v3,
                status        : 0,
                ocean_reward  : 0,
            };
            0x2::dynamic_field::add<0x1::string::String, UserAuctionInfo>(&mut arg0.id, v4, v5);
        } else {
            let v6 = 0x2::dynamic_field::borrow_mut<0x1::string::String, UserAuctionInfo>(&mut arg0.id, v4);
            let v7 = v6.total_deposit + v3;
            assert!(v7 >= v1.base_deposit, 7);
            v6.total_deposit = v7;
        };
        0x2::balance::join<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut v1.ocean_balance, 0x2::coin::into_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg2));
        let v8 = CoinDeposited{
            event_id         : arg1,
            sender           : v0,
            coin_type        : 1,
            amount           : v3,
            user_auction_key : v4,
        };
        0x2::event::emit<CoinDeposited>(v8);
    }

    entry fun deposit_ocean_reward(arg0: &AuctionOwnerCap, arg1: &mut App, arg2: u64, arg3: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>) {
        assert!(arg2 < 0x2::table_vec::length<AuctionEvent>(&arg1.events), 1);
        0x2::balance::join<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut 0x2::table_vec::borrow_mut<AuctionEvent>(&mut arg1.events, arg2).balance_reward, 0x2::coin::into_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg3));
    }

    entry fun deposit_sui(arg0: &mut App, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1 < 0x2::table_vec::length<AuctionEvent>(&arg0.events), 1);
        let v1 = 0x2::table_vec::borrow_mut<AuctionEvent>(&mut arg0.events, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 > v1.start_time, 3);
        assert!(v2 < v1.end_time, 4);
        assert!(v1.coin_type == 0, 5);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v3 >= v1.min_each_deposit, 6);
        let v4 = 0x2::address::to_string(v0);
        0x1::string::append_utf8(&mut v4, b"-");
        0x1::string::append(&mut v4, u64_to_string(arg1));
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v4)) {
            assert!(v3 >= v1.base_deposit, 7);
            let v5 = UserAuctionInfo{
                id            : 0x2::object::new(arg4),
                total_deposit : v3,
                status        : 0,
                ocean_reward  : 0,
            };
            0x2::dynamic_field::add<0x1::string::String, UserAuctionInfo>(&mut arg0.id, v4, v5);
        } else {
            let v6 = 0x2::dynamic_field::borrow_mut<0x1::string::String, UserAuctionInfo>(&mut arg0.id, v4);
            let v7 = v6.total_deposit + v3;
            assert!(v7 >= v1.base_deposit, 7);
            v6.total_deposit = v7;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v8 = CoinDeposited{
            event_id         : arg1,
            sender           : v0,
            coin_type        : 0,
            amount           : v3,
            user_auction_key : v4,
        };
        0x2::event::emit<CoinDeposited>(v8);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v1 = App{
            id          : 0x2::object::new(arg0),
            events      : 0x2::table_vec::empty<AuctionEvent>(arg0),
            operator_pk : 0x2::bcs::to_bytes<address>(&v0),
            version     : 1,
        };
        0x2::transfer::share_object<App>(v1);
        let v2 = AuctionOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AuctionOwnerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun inner_claim_nft(arg0: &mut App, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u16, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NFT>(0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::mint(&mut arg0.id, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    entry fun migrate(arg0: &AuctionOwnerCap, arg1: &mut App) {
        assert!(arg1.version < 1, 14);
        arg1.version = 1;
    }

    fun send_ocean_from_event(arg0: &mut App, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 0x2::table_vec::length<AuctionEvent>(&arg0.events), 1);
        let v0 = 0x2::table_vec::borrow_mut<AuctionEvent>(&mut arg0.events, arg1);
        assert!(v0.coin_type == 1, 5);
        let v1 = 0x2::balance::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&v0.ocean_balance);
        assert!(v1 >= arg3, 8);
        if (v1 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::from_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::balance::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut v0.ocean_balance, arg3), arg4), arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::from_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::balance::withdraw_all<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut v0.ocean_balance), arg4), arg2);
        };
    }

    fun send_ocean_reward_from_event(arg0: &mut App, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 0x2::table_vec::length<AuctionEvent>(&arg0.events), 1);
        let v0 = 0x2::table_vec::borrow_mut<AuctionEvent>(&mut arg0.events, arg1);
        let v1 = 0x2::balance::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&v0.balance_reward);
        assert!(v1 >= arg3, 8);
        if (v1 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::from_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::balance::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut v0.balance_reward, arg3), arg4), arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::from_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::balance::withdraw_all<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut v0.balance_reward), arg4), arg2);
        };
    }

    fun send_sui_from_event(arg0: &mut App, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 0x2::table_vec::length<AuctionEvent>(&arg0.events), 1);
        let v0 = 0x2::table_vec::borrow_mut<AuctionEvent>(&mut arg0.events, arg1);
        assert!(v0.coin_type == 0, 5);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0.sui_balance);
        assert!(v1 >= arg3, 8);
        if (v1 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.sui_balance, arg3), arg4), arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0.sui_balance), arg4), arg2);
        };
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    entry fun update_event_result(arg0: &AuctionOwnerCap, arg1: &mut App, arg2: u64, arg3: u64, arg4: u64, arg5: u8) {
        assert!(arg2 < 0x2::table_vec::length<AuctionEvent>(&arg1.events), 1);
        let v0 = 0x2::table_vec::borrow_mut<AuctionEvent>(&mut arg1.events, arg2);
        v0.total_volume_withdraw = arg3;
        v0.total_ocean_reward = arg4;
        v0.status = arg5;
    }

    entry fun update_events(arg0: &AuctionOwnerCap, arg1: &mut App, arg2: vector<u64>, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg4) && v0 == 0x1::vector::length<u8>(&arg3) && v0 == 0x1::vector::length<u64>(&arg5) && v0 == 0x1::vector::length<u64>(&arg6) && v0 == 0x1::vector::length<u64>(&arg7) && v0 == 0x1::vector::length<u64>(&arg8), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            if (v2 < 0x2::table_vec::length<AuctionEvent>(&arg1.events)) {
                let v3 = 0x2::table_vec::borrow_mut<AuctionEvent>(&mut arg1.events, v2);
                v3.start_time = *0x1::vector::borrow<u64>(&arg4, v1);
                v3.end_time = *0x1::vector::borrow<u64>(&arg5, v1);
                v3.max_slot = *0x1::vector::borrow<u64>(&arg6, v1);
                v3.base_deposit = *0x1::vector::borrow<u64>(&arg7, v1);
                v3.min_each_deposit = *0x1::vector::borrow<u64>(&arg8, v1);
                v3.coin_type = *0x1::vector::borrow<u8>(&arg3, v1);
            } else {
                let v4 = AuctionEvent{
                    sui_balance           : 0x2::balance::zero<0x2::sui::SUI>(),
                    ocean_balance         : 0x2::balance::zero<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(),
                    coin_type             : *0x1::vector::borrow<u8>(&arg3, v1),
                    base_deposit          : *0x1::vector::borrow<u64>(&arg7, v1),
                    min_each_deposit      : *0x1::vector::borrow<u64>(&arg8, v1),
                    current_slot          : 0,
                    max_slot              : *0x1::vector::borrow<u64>(&arg6, v1),
                    start_time            : *0x1::vector::borrow<u64>(&arg4, v1),
                    end_time              : *0x1::vector::borrow<u64>(&arg5, v1),
                    total_volume_withdraw : 0,
                    total_ocean_reward    : 0,
                    balance_reward        : 0x2::balance::zero<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(),
                    status                : 0,
                };
                0x2::table_vec::push_back<AuctionEvent>(&mut arg1.events, v4);
            };
            v1 = v1 + 1;
        };
    }

    entry fun update_operator(arg0: &AuctionOwnerCap, arg1: &mut App, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    entry fun withdraw_from_event(arg0: &mut App, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg1 < 0x2::table_vec::length<AuctionEvent>(&arg0.events), 1);
        let v0 = 0x2::table_vec::borrow_mut<AuctionEvent>(&mut arg0.events, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) > v0.end_time, 9);
        assert!(v0.status == 1, 15);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1::string::utf8(b"AUCTION_WITHDRAW:");
        let v3 = 0x2::bcs::to_bytes<0x1::string::String>(&v2);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v1));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg1));
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.operator_pk, &v3) == true, 12);
        let v5 = 0x2::address::to_string(v1);
        0x1::string::append_utf8(&mut v5, b"-");
        0x1::string::append(&mut v5, u64_to_string(arg1));
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v5), 10);
        let v6 = 0x2::dynamic_field::borrow_mut<0x1::string::String, UserAuctionInfo>(&mut arg0.id, v5);
        assert!(v6.status == 0, 11);
        v6.status = 2;
        let v7 = v6.total_deposit;
        let v8 = v0.total_ocean_reward;
        let v9 = v0.total_volume_withdraw;
        let v10 = v0.coin_type;
        if (v10 == 0) {
            send_sui_from_event(arg0, arg1, v1, v7, arg4);
        };
        if (v10 == 1) {
            send_ocean_from_event(arg0, arg1, v1, v7, arg4);
        };
        let v11 = 0;
        if (v8 > 0 && v9 > 0) {
            let v12 = 10000 * v7 / v9 * v8 / 10000;
            v11 = v12;
            if (v12 < 1000000000) {
                v11 = 1000000000;
            };
            send_ocean_reward_from_event(arg0, arg1, v1, v11, arg4);
        };
        let v13 = CoinWithdraw{
            event_id      : arg1,
            receiver      : v1,
            coin_type     : v10,
            amount        : v7,
            reward_amount : v11,
        };
        0x2::event::emit<CoinWithdraw>(v13);
    }

    entry fun withdraw_ocean(arg0: &AuctionOwnerCap, arg1: &mut App, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        send_ocean_from_event(arg1, arg2, v0, arg3, arg4);
    }

    entry fun withdraw_ocean_reward(arg0: &AuctionOwnerCap, arg1: &mut App, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        send_ocean_reward_from_event(arg1, arg2, v0, arg3, arg4);
    }

    entry fun withdraw_sui(arg0: &AuctionOwnerCap, arg1: &mut App, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        send_sui_from_event(arg1, arg2, v0, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

