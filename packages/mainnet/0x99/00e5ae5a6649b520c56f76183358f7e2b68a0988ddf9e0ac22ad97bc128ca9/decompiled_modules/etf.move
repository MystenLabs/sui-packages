module 0x9900e5ae5a6649b520c56f76183358f7e2b68a0988ddf9e0ac22ad97bc128ca9::etf {
    struct FundPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct FundAssetMetadata has copy, drop, store {
        decimals: u8,
        weight: u64,
        coin_type: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
    }

    struct Fund has store, key {
        id: 0x2::object::UID,
        creator: address,
        initalized: bool,
        positions: 0x2::bag::Bag,
        assets_metadata: vector<FundAssetMetadata>,
        description: 0x1::ascii::String,
        title: 0x1::ascii::String,
        ticker: 0x1::ascii::String,
        image_url: 0x1::ascii::String,
        treasury: 0x2::coin::TreasuryCap<ETF>,
        in_fee: u64,
        out_fee: u64,
    }

    struct FundActivationEvent has copy, drop {
        fund_id: 0x2::object::ID,
        assets_metadata: vector<FundAssetMetadata>,
        creator: address,
        title: 0x1::ascii::String,
        ticker: 0x1::ascii::String,
        image_url: 0x1::ascii::String,
        description: 0x1::ascii::String,
    }

    struct ETF has drop {
        dummy_field: bool,
    }

    struct FundShareEntry has copy, drop, store {
        coin_type: 0x1::ascii::String,
        amount: u64,
        sui_amount: u64,
        weight: u64,
        decimals: u8,
    }

    struct ContributionTransaction {
        fund_id: 0x2::object::ID,
        swaps_to_execute: u64,
        swaps_executed: u64,
        swaps_types: vector<0x1::type_name::TypeName>,
        shares: vector<FundShareEntry>,
    }

    struct ContributionEvent has copy, drop {
        fund_id: 0x2::object::ID,
        contributor: address,
        shares: vector<FundShareEntry>,
        coin_minted: u64,
    }

    struct BurnEvent has copy, drop {
        fund_id: 0x2::object::ID,
        burner: address,
        burn_amount: u64,
    }

    struct WithdrawalShare has copy, drop, store {
        coin_type: 0x1::ascii::String,
        etf_coin_amount: u64,
        weight: u64,
    }

    struct WithdrawalTransaction {
        fund_id: 0x2::object::ID,
        swaps_to_execute: u64,
        swaps_executed: u64,
        swaps_types: vector<0x1::type_name::TypeName>,
        shares: vector<WithdrawalShare>,
        initial_total_supply: u64,
    }

    struct WithdrawEvent has copy, drop {
        fund_id: 0x2::object::ID,
        withdrawer: address,
        withdraw_amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct DebugEvent has copy, drop {
        fund_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        fund_balance: u64,
        total_supply_value: u64,
        asset_x_amount: u64,
    }

    struct WithdrawalEvent has copy, drop {
        fund_id: 0x2::object::ID,
        withdrawer: address,
        shares: vector<WithdrawalShare>,
    }

    public fun activate_fund(arg0: &mut Fund, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 100017);
        assert!(!arg0.initalized, 100015);
        assert!(get_total_weight(arg0) == 1000, 100010);
        arg0.initalized = true;
        let v0 = FundActivationEvent{
            fund_id         : 0x2::object::uid_to_inner(&arg0.id),
            assets_metadata : arg0.assets_metadata,
            creator         : arg0.creator,
            title           : arg0.title,
            ticker          : arg0.ticker,
            image_url       : arg0.image_url,
            description     : arg0.description,
        };
        0x2::event::emit<FundActivationEvent>(v0);
    }

    public fun add_coin_type<T0>(arg0: &mut Fund, arg1: u64, arg2: u8, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.initalized, 100015);
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 100017);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!is_coin_type_in_fund(arg0, v0), 100011);
        let v1 = FundAssetMetadata{
            decimals  : arg2,
            weight    : arg1,
            coin_type : v0,
            pool_id   : arg3,
        };
        0x1::vector::push_back<FundAssetMetadata>(&mut arg0.assets_metadata, v1);
    }

    public fun add_position_to_fund<T0>(arg0: &mut Fund, arg1: 0x1::type_name::TypeName, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.positions, arg1)) {
            0x2::balance::join<T0>(&mut 0x2::bag::borrow_mut<0x1::type_name::TypeName, FundPosition<T0>>(&mut arg0.positions, arg1).balance, 0x2::coin::into_balance<T0>(arg2));
        } else {
            let v0 = FundPosition<T0>{
                id      : 0x2::object::new(arg3),
                balance : 0x2::coin::into_balance<T0>(arg2),
            };
            0x2::bag::add<0x1::type_name::TypeName, FundPosition<T0>>(&mut arg0.positions, arg1, v0);
        };
    }

    fun calculate_withdraw_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (((arg2 as u128) * (arg1 as u128) * ((1000000000 / arg0) as u128) / (arg3 as u128) / 1000000) as u64)
    }

    public fun contribute_sui_to_fund(arg0: &mut Fund, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::option::Option<ContributionTransaction>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<ContributionTransaction> {
        assert!(arg0.initalized, 100016);
        let v0 = 0x1::type_name::get<0x2::sui::SUI>();
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = &mut arg1;
        take_fee<0x2::sui::SUI>(v2, arg0.creator, arg0.in_fee, arg3);
        let (v3, v4) = find_metadata_index_from_coin_type(arg0, v0);
        assert!(v3, 100011);
        let v5 = 0x1::vector::borrow<FundAssetMetadata>(&arg0.assets_metadata, v4).weight;
        add_position_to_fund<0x2::sui::SUI>(arg0, v0, arg1, arg3);
        if (0x1::option::is_some<ContributionTransaction>(&arg2)) {
            let v7 = 0x1::option::borrow_mut<ContributionTransaction>(&mut arg2);
            assert!(v7.fund_id == 0x2::object::uid_to_inner(&arg0.id), 100014);
            v7.swaps_executed = v7.swaps_executed + 1;
            assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v7.swaps_types, &v0), 100013);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v7.swaps_types, v0);
            let v8 = FundShareEntry{
                coin_type  : 0x1::type_name::into_string(v0),
                amount     : v1,
                sui_amount : v1,
                weight     : v5,
                decimals   : 9,
            };
            0x1::vector::push_back<FundShareEntry>(&mut v7.shares, v8);
            arg2
        } else {
            let v9 = FundShareEntry{
                coin_type  : 0x1::type_name::into_string(v0),
                amount     : v1,
                sui_amount : v1,
                weight     : v5,
                decimals   : 9,
            };
            let v10 = ContributionTransaction{
                fund_id          : 0x2::object::uid_to_inner(&arg0.id),
                swaps_to_execute : 0x1::vector::length<FundAssetMetadata>(&arg0.assets_metadata),
                swaps_executed   : 1,
                swaps_types      : 0x1::vector::singleton<0x1::type_name::TypeName>(v0),
                shares           : 0x1::vector::singleton<FundShareEntry>(v9),
            };
            0x1::option::destroy_none<ContributionTransaction>(arg2);
            0x1::option::some<ContributionTransaction>(v10)
        }
    }

    public fun contribute_to_fund<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut Fund, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<ContributionTransaction>, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<ContributionTransaction> {
        assert!(arg2.initalized, 100016);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &mut arg3;
        take_fee<0x2::sui::SUI>(v1, arg2.creator, arg2.in_fee, arg6);
        let (v2, v3) = find_metadata_index_from_coin_type(arg2, v0);
        assert!(v2, 100011);
        let v4 = 0x1::vector::borrow<FundAssetMetadata>(&arg2.assets_metadata, v3).weight;
        assert!(0x1::vector::borrow<FundAssetMetadata>(&arg2.assets_metadata, v3).pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1), 100024);
        assert!(v2, 100011);
        let (v5, v6) = swap_and_add_position<T0>(arg0, arg1, arg2, arg3, arg4, arg6);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v5);
        };
        if (0x1::option::is_some<ContributionTransaction>(&arg5)) {
            let v8 = 0x1::option::borrow_mut<ContributionTransaction>(&mut arg5);
            assert!(v8.fund_id == 0x2::object::uid_to_inner(&arg2.id), 100014);
            v8.swaps_executed = v8.swaps_executed + 1;
            assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v8.swaps_types, &v0), 100013);
            let (v9, v10) = find_metadata_index_from_coin_type(arg2, v0);
            assert!(v9, 100011);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v8.swaps_types, v0);
            let v11 = FundShareEntry{
                coin_type  : 0x1::type_name::into_string(v0),
                amount     : v6,
                sui_amount : 0x2::coin::value<0x2::sui::SUI>(&arg3),
                weight     : v4,
                decimals   : 0x1::vector::borrow<FundAssetMetadata>(&arg2.assets_metadata, v10).decimals,
            };
            0x1::vector::push_back<FundShareEntry>(&mut v8.shares, v11);
            arg5
        } else {
            let v12 = FundShareEntry{
                coin_type  : 0x1::type_name::into_string(v0),
                amount     : v6,
                sui_amount : 0x2::coin::value<0x2::sui::SUI>(&arg3),
                weight     : v4,
                decimals   : 0x1::vector::borrow<FundAssetMetadata>(&arg2.assets_metadata, v3).decimals,
            };
            let v13 = ContributionTransaction{
                fund_id          : 0x2::object::uid_to_inner(&arg2.id),
                swaps_to_execute : 0x1::vector::length<FundAssetMetadata>(&arg2.assets_metadata),
                swaps_executed   : 1,
                swaps_types      : 0x1::vector::singleton<0x1::type_name::TypeName>(v0),
                shares           : 0x1::vector::singleton<FundShareEntry>(v12),
            };
            0x1::option::destroy_none<ContributionTransaction>(arg5);
            0x1::option::some<ContributionTransaction>(v13)
        }
    }

    fun create_fund(arg0: ETF, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETF>(arg0, 9, arg2, arg1, arg4, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg3)), arg6);
        let v2 = vector[1, 1];
        let v3 = vector[1, 1];
        let v4 = Fund{
            id              : 0x2::object::new(arg6),
            creator         : arg5,
            initalized      : false,
            positions       : 0x2::bag::new(arg6),
            assets_metadata : 0x1::vector::empty<FundAssetMetadata>(),
            description     : 0x1::ascii::string(arg4),
            title           : 0x1::ascii::string(arg1),
            ticker          : 0x1::ascii::string(arg2),
            image_url       : 0x1::ascii::string(arg3),
            treasury        : v0,
            in_fee          : *0x1::vector::borrow<u64>(&v2, 0),
            out_fee         : *0x1::vector::borrow<u64>(&v3, 1),
        };
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ETF>>(v1, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_share_object<Fund>(v4);
    }

    public fun destroy_fund_share(arg0: &Fund, arg1: 0x1::option::Option<WithdrawalTransaction>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<WithdrawalTransaction>(&arg1)) {
            let WithdrawalTransaction {
                fund_id              : v0,
                swaps_to_execute     : v1,
                swaps_executed       : v2,
                swaps_types          : _,
                shares               : v4,
                initial_total_supply : _,
            } = 0x1::option::destroy_some<WithdrawalTransaction>(arg1);
            let v6 = v4;
            assert!(v2 == v1, 100012);
            assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 100014);
            let v7 = 0;
            let v8 = 0;
            while (v8 < 0x1::vector::length<WithdrawalShare>(&v6)) {
                v7 = v7 + 0x1::vector::borrow<WithdrawalShare>(&v6, v8).etf_coin_amount;
                v8 = v8 + 1;
            };
            v8 = 0;
            while (v8 < 0x1::vector::length<WithdrawalShare>(&v6)) {
                let v9 = 0x1::vector::borrow<WithdrawalShare>(&v6, v8);
                let v10 = v7 * v9.weight / 1000;
                assert!(v9.etf_coin_amount >= v10 - 1 && v9.etf_coin_amount <= v10 + 1, 100018);
                v8 = v8 + 1;
            };
            let v11 = WithdrawalEvent{
                fund_id    : v0,
                withdrawer : 0x2::tx_context::sender(arg2),
                shares     : v6,
            };
            0x2::event::emit<WithdrawalEvent>(v11);
        } else {
            0x1::option::destroy_none<WithdrawalTransaction>(arg1);
        };
    }

    public fun destroy_hot_potato(arg0: &mut Fund, arg1: 0x1::option::Option<ContributionTransaction>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<ContributionTransaction>(&arg1)) {
            let ContributionTransaction {
                fund_id          : v0,
                swaps_to_execute : v1,
                swaps_executed   : v2,
                swaps_types      : _,
                shares           : v4,
            } = 0x1::option::destroy_some<ContributionTransaction>(arg1);
            let v5 = v4;
            assert!(v2 == v1, 100012);
            assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 100014);
            validate_share_weights(&v5);
            let v6 = get_coin_to_mint(&v5);
            0x2::coin::mint_and_transfer<ETF>(&mut arg0.treasury, v6, 0x2::tx_context::sender(arg2), arg2);
            let v7 = ContributionEvent{
                fund_id     : v0,
                contributor : 0x2::tx_context::sender(arg2),
                shares      : v5,
                coin_minted : v6,
            };
            0x2::event::emit<ContributionEvent>(v7);
        } else {
            0x1::option::destroy_none<ContributionTransaction>(arg1);
        };
    }

    fun find_metadata_index_from_coin_type(arg0: &Fund, arg1: 0x1::type_name::TypeName) : (bool, u64) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<FundAssetMetadata>(&arg0.assets_metadata)) {
            if (0x1::vector::borrow<FundAssetMetadata>(&arg0.assets_metadata, v0).coin_type == arg1) {
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        (v1, v0)
    }

    public fun get_asset_balance<T0>(arg0: &Fund) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.positions, v0)) {
            0x2::balance::value<T0>(&0x2::bag::borrow<0x1::type_name::TypeName, FundPosition<T0>>(&arg0.positions, v0).balance)
        } else {
            0
        }
    }

    public fun get_bag_holdings_balance<T0>(arg0: &Fund) : u64 {
        0x2::balance::value<T0>(&0x2::bag::borrow<0x1::type_name::TypeName, FundPosition<T0>>(&arg0.positions, 0x1::type_name::get<T0>()).balance)
    }

    fun get_coin_to_mint(arg0: &vector<FundShareEntry>) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 9;
        while (v0 < 0x1::vector::length<FundShareEntry>(arg0)) {
            let v3 = 0x1::vector::borrow<FundShareEntry>(arg0, v0);
            let v4 = if (v3.decimals > v2) {
                v3.decimals - v2
            } else {
                v2 - v3.decimals
            };
            let v5 = if (v3.decimals > v2) {
                v3.amount / 0x1::u64::pow(10, v4)
            } else if (v3.decimals < v2) {
                v3.amount * 0x1::u64::pow(10, v4)
            } else {
                v3.amount
            };
            let v6 = v5 * v3.weight;
            assert!(v6 / v3.weight == v5, 100023);
            let v7 = v6 / 1000;
            let v8 = v1 + v7;
            v1 = v8;
            assert!(v8 >= v7, 100023);
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_total_supply(arg0: &Fund) : u64 {
        0x2::coin::total_supply<ETF>(&arg0.treasury)
    }

    fun get_total_weight(arg0: &Fund) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FundAssetMetadata>(&arg0.assets_metadata)) {
            v0 = v0 + 0x1::vector::borrow<FundAssetMetadata>(&arg0.assets_metadata, v1).weight;
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: ETF, arg1: &mut 0x2::tx_context::TxContext) {
        create_fund(arg0, b"name", b"ticker", b"image_url", b"description", @0x370bddfc0e95594ad580f508572c7595aae705f08f2d5fc383e49ca95067a522, arg1);
    }

    fun is_coin_type_in_fund(arg0: &Fund, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FundAssetMetadata>(&arg0.assets_metadata)) {
            if (0x1::vector::borrow<FundAssetMetadata>(&arg0.assets_metadata, v0).coin_type == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun swap_and_add_position<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut Fund, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, _) = find_metadata_index_from_coin_type(arg2, v0);
        assert!(v1, 100011);
        let (v3, v4) = 0x9900e5ae5a6649b520c56f76183358f7e2b68a0988ddf9e0ac22ad97bc128ca9::swapper::cetus_swap_b2a<T0, 0x2::sui::SUI>(arg3, arg1, arg0, arg4, arg5);
        let v5 = v3;
        add_position_to_fund<T0>(arg2, v0, v5, arg5);
        (v4, 0x2::coin::value<T0>(&v5))
    }

    public fun swap_position_to_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut Fund, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, _) = find_metadata_index_from_coin_type(arg2, v0);
        assert!(v1, 100011);
        let (v3, v4) = 0x9900e5ae5a6649b520c56f76183358f7e2b68a0988ddf9e0ac22ad97bc128ca9::swapper::cetus_swap_a2b<T0, 0x2::sui::SUI>(arg3, arg1, arg0, arg4, arg5);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::coin::value<0x2::sui::SUI>(&v6);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        let v8 = WithdrawEvent{
            fund_id         : 0x2::object::uid_to_inner(&arg2.id),
            withdrawer      : 0x2::tx_context::sender(arg5),
            withdraw_amount : v7,
            coin_type       : v0,
        };
        0x2::event::emit<WithdrawEvent>(v8);
        (v6, v7)
    }

    fun take_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x2::coin::value<T0>(arg0) * arg2 / 1000;
        if (v0 == 0 || v0 / 4 == 0) {
            return
        };
        let v1 = 0x2::coin::split<T0>(arg0, v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, 0x2::coin::value<T0>(&v1) / 4, arg3), @0x4b0d62f8d195e018fc43a47ae9b493bef6ff6ec06c50dcc5219e14f249b3e65a);
    }

    fun validate_share_weights(arg0: &vector<FundShareEntry>) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FundShareEntry>(arg0)) {
            v0 = v0 + 0x1::vector::borrow<FundShareEntry>(arg0, v1).sui_amount;
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 0x1::vector::length<FundShareEntry>(arg0)) {
            let v2 = 0x1::vector::borrow<FundShareEntry>(arg0, v1);
            let v3 = v0 * v2.weight / 1000;
            assert!(v2.sui_amount >= v3 - 1 && v2.sui_amount <= v3 + 1, 100018);
            v1 = v1 + 1;
        };
    }

    public fun withdraw_from_fund<T0>(arg0: 0x2::coin::Coin<ETF>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut Fund, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<WithdrawalTransaction>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<WithdrawalTransaction> {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = find_metadata_index_from_coin_type(arg3, v0);
        assert!(v1, 100011);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg3.positions, v0), 100011);
        let v3 = get_asset_balance<T0>(arg3);
        assert!(v3 > 0, 100020);
        let v4 = 0x2::coin::supply<ETF>(&mut arg3.treasury);
        let v5 = if (0x1::option::is_some<WithdrawalTransaction>(&arg5)) {
            0x1::option::borrow<WithdrawalTransaction>(&arg5).initial_total_supply
        } else {
            0x2::balance::supply_value<ETF>(v4)
        };
        assert!(v5 > 0, 100021);
        let v6 = 0x2::coin::value<ETF>(&arg0);
        assert!(v6 > 0, 100019);
        assert!(0x1::vector::borrow<FundAssetMetadata>(&arg3.assets_metadata, v2).pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 100024);
        let v7 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, FundPosition<T0>>(&mut arg3.positions, v0);
        let v8 = 0x1::vector::borrow<FundAssetMetadata>(&arg3.assets_metadata, v2).weight;
        assert!(v8 > 0, 100010);
        let v9 = calculate_withdraw_amount(v8, v6, v3, v5);
        let v10 = DebugEvent{
            fund_id            : 0x2::object::uid_to_inner(&arg3.id),
            coin_type          : v0,
            fund_balance       : v3,
            total_supply_value : v5,
            asset_x_amount     : v9,
        };
        0x2::event::emit<DebugEvent>(v10);
        let v11 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7.balance, v9), arg7);
        let v12 = &mut v11;
        take_fee<T0>(v12, arg3.creator, arg3.out_fee, arg7);
        if (arg6) {
            let (v13, _) = swap_position_to_sui<T0>(arg1, arg2, arg3, v11, arg4, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg7));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, 0x2::tx_context::sender(arg7));
        };
        0x2::coin::burn<ETF>(&mut arg3.treasury, arg0);
        let v15 = BurnEvent{
            fund_id     : 0x2::object::uid_to_inner(&arg3.id),
            burner      : 0x2::tx_context::sender(arg7),
            burn_amount : v6,
        };
        0x2::event::emit<BurnEvent>(v15);
        let (v16, v17) = find_metadata_index_from_coin_type(arg3, v0);
        assert!(v16, 100011);
        if (0x1::option::is_some<WithdrawalTransaction>(&arg5)) {
            let v19 = 0x1::option::borrow_mut<WithdrawalTransaction>(&mut arg5);
            assert!(v19.fund_id == 0x2::object::uid_to_inner(&arg3.id), 100014);
            v19.swaps_executed = v19.swaps_executed + 1;
            assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v19.swaps_types, &v0), 100013);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v19.swaps_types, v0);
            let v20 = WithdrawalShare{
                coin_type       : 0x1::type_name::into_string(v0),
                etf_coin_amount : v6,
                weight          : 0x1::vector::borrow<FundAssetMetadata>(&arg3.assets_metadata, v17).weight,
            };
            0x1::vector::push_back<WithdrawalShare>(&mut v19.shares, v20);
            arg5
        } else {
            let v21 = WithdrawalShare{
                coin_type       : 0x1::type_name::into_string(v0),
                etf_coin_amount : v6,
                weight          : 0x1::vector::borrow<FundAssetMetadata>(&arg3.assets_metadata, v17).weight,
            };
            let v22 = WithdrawalTransaction{
                fund_id              : 0x2::object::uid_to_inner(&arg3.id),
                swaps_to_execute     : 0x1::vector::length<FundAssetMetadata>(&arg3.assets_metadata),
                swaps_executed       : 1,
                swaps_types          : 0x1::vector::singleton<0x1::type_name::TypeName>(v0),
                shares               : 0x1::vector::singleton<WithdrawalShare>(v21),
                initial_total_supply : v5,
            };
            0x1::option::destroy_none<WithdrawalTransaction>(arg5);
            0x1::option::some<WithdrawalTransaction>(v22)
        }
    }

    public fun withdraw_sui_from_fund(arg0: 0x2::coin::Coin<ETF>, arg1: &mut Fund, arg2: 0x1::option::Option<WithdrawalTransaction>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<WithdrawalTransaction> {
        let v0 = 0x1::type_name::get<0x2::sui::SUI>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.positions, v0), 100011);
        let (v1, v2) = find_metadata_index_from_coin_type(arg1, v0);
        assert!(v1, 100011);
        let v3 = 0x2::coin::supply<ETF>(&mut arg1.treasury);
        let v4 = if (0x1::option::is_some<WithdrawalTransaction>(&arg2)) {
            0x1::option::borrow<WithdrawalTransaction>(&arg2).initial_total_supply
        } else {
            0x2::balance::supply_value<ETF>(v3)
        };
        let v5 = 0x2::coin::value<ETF>(&arg0);
        let v6 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut 0x2::bag::borrow_mut<0x1::type_name::TypeName, FundPosition<0x2::sui::SUI>>(&mut arg1.positions, v0).balance, calculate_withdraw_amount(0x1::vector::borrow<FundAssetMetadata>(&arg1.assets_metadata, v2).weight, v5, get_asset_balance<0x2::sui::SUI>(arg1), v4)), arg3);
        let v7 = &mut v6;
        take_fee<0x2::sui::SUI>(v7, arg1.creator, arg1.out_fee, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, 0x2::tx_context::sender(arg3));
        let (v8, v9) = find_metadata_index_from_coin_type(arg1, v0);
        assert!(v8, 100011);
        0x2::coin::burn<ETF>(&mut arg1.treasury, arg0);
        let v10 = BurnEvent{
            fund_id     : 0x2::object::uid_to_inner(&arg1.id),
            burner      : 0x2::tx_context::sender(arg3),
            burn_amount : v5,
        };
        0x2::event::emit<BurnEvent>(v10);
        if (0x1::option::is_some<WithdrawalTransaction>(&arg2)) {
            let v12 = 0x1::option::borrow_mut<WithdrawalTransaction>(&mut arg2);
            assert!(v12.fund_id == 0x2::object::uid_to_inner(&arg1.id), 100014);
            v12.swaps_executed = v12.swaps_executed + 1;
            assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v12.swaps_types, &v0), 100013);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v12.swaps_types, v0);
            let v13 = WithdrawalShare{
                coin_type       : 0x1::type_name::into_string(v0),
                etf_coin_amount : v5,
                weight          : 0x1::vector::borrow<FundAssetMetadata>(&arg1.assets_metadata, v9).weight,
            };
            0x1::vector::push_back<WithdrawalShare>(&mut v12.shares, v13);
            arg2
        } else {
            let v14 = WithdrawalShare{
                coin_type       : 0x1::type_name::into_string(v0),
                etf_coin_amount : v5,
                weight          : 0x1::vector::borrow<FundAssetMetadata>(&arg1.assets_metadata, v9).weight,
            };
            let v15 = WithdrawalTransaction{
                fund_id              : 0x2::object::uid_to_inner(&arg1.id),
                swaps_to_execute     : 0x1::vector::length<FundAssetMetadata>(&arg1.assets_metadata),
                swaps_executed       : 1,
                swaps_types          : 0x1::vector::singleton<0x1::type_name::TypeName>(v0),
                shares               : 0x1::vector::singleton<WithdrawalShare>(v14),
                initial_total_supply : v4,
            };
            0x1::option::destroy_none<WithdrawalTransaction>(arg2);
            0x1::option::some<WithdrawalTransaction>(v15)
        }
    }

    // decompiled from Move bytecode v6
}

