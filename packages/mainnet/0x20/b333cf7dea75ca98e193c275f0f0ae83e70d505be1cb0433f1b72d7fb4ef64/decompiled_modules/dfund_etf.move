module 0x20b333cf7dea75ca98e193c275f0f0ae83e70d505be1cb0433f1b72d7fb4ef64::dfund_etf {
    struct UserFundShare has store, key {
        id: 0x2::object::UID,
        fund_id: 0x2::object::ID,
        shares: vector<FundShareEntry>,
    }

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

    struct FundETF has store, key {
        id: 0x2::object::UID,
        creator: address,
        initalized: bool,
        positions: 0x2::bag::Bag,
        assets_metadata: vector<FundAssetMetadata>,
        description: 0x1::ascii::String,
        title: 0x1::ascii::String,
        ticker: 0x1::ascii::String,
        image_url: 0x1::ascii::String,
        in_fee: u64,
        out_fee: u64,
        paused: bool,
    }

    struct FundShareEntry has copy, drop, store {
        coin_type: 0x1::ascii::String,
        amount: u64,
        sui_amount: u64,
        weight: u64,
        decimals: u8,
    }

    struct HotPotatoContributionTransaction {
        fund_id: 0x2::object::ID,
        swaps_to_execute: u64,
        swaps_executed: u64,
        swaps_types: vector<0x1::type_name::TypeName>,
        shares: vector<FundShareEntry>,
        sui_amount: u64,
    }

    struct HotPotatoWithdrawalTransaction {
        fund_id: 0x2::object::ID,
        swaps_to_execute: u64,
        swaps_executed: u64,
        swaps_types: vector<0x1::type_name::TypeName>,
        sui_amount: u64,
    }

    struct FundCreationEvent has copy, drop {
        fund_id: 0x2::object::ID,
        creator: address,
        title: 0x1::ascii::String,
        ticker: 0x1::ascii::String,
        image_url: 0x1::ascii::String,
        description: 0x1::ascii::String,
        in_fee: u64,
        out_fee: u64,
        assets_metadata: vector<FundAssetMetadata>,
    }

    struct WithdrawalEvent has copy, drop {
        fund_id: 0x2::object::ID,
        user_address: address,
        shares: vector<FundShareEntry>,
        sui_amount: u64,
        position_id: 0x2::object::ID,
    }

    struct ContributionEvent has copy, drop {
        fund_id: 0x2::object::ID,
        user_address: address,
        shares: vector<FundShareEntry>,
        sui_amount: u64,
        position_id: 0x2::object::ID,
    }

    struct FeeEvent has copy, drop {
        creator: address,
        affiliate: address,
        creator_fee: u64,
        affiliate_fee: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun activate_fund(arg0: FundETF, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(!arg0.initalized, 0);
        assert!(0x1::vector::length<FundAssetMetadata>(&arg0.assets_metadata) > 0, 10);
        assert!(0x2::tx_context::sender(arg1) == @0x370bddfc0e95594ad580f508572c7595aae705f08f2d5fc383e49ca95067a522, 11);
        assert!(get_total_weight(get_coin_weights(&arg0)) == 1000, 3);
        arg0.initalized = true;
        emit_fund_creation_event(&arg0);
        0x2::transfer::public_share_object<FundETF>(arg0);
    }

    public fun add_coin_type<T0>(arg0: FundETF, arg1: u64, arg2: u8, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : FundETF {
        assert!(!arg0.initalized, 0);
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!is_coin_type_in_fund(get_coin_types_in_fund(&arg0), v0), 2);
        let v1 = FundAssetMetadata{
            decimals  : arg2,
            weight    : arg1,
            coin_type : v0,
            pool_id   : arg3,
        };
        0x1::vector::push_back<FundAssetMetadata>(&mut arg0.assets_metadata, v1);
        arg0
    }

    public fun add_position_to_fund<T0>(arg0: &mut FundETF, arg1: 0x1::type_name::TypeName, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
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

    public fun contribute_sui_to_fund(arg0: &mut FundETF, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::option::Option<HotPotatoContributionTransaction>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<HotPotatoContributionTransaction> {
        assert!(arg0.initalized, 4);
        assert!(!arg0.paused, 9);
        let v0 = 0x1::type_name::get<0x2::sui::SUI>();
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = &mut arg1;
        take_fee<0x2::sui::SUI>(v2, arg0.creator, arg3, arg0.in_fee, arg4);
        let (v3, v4) = find_metadata_index_from_coin_type(arg0, v0);
        assert!(v3, 2);
        let v5 = 0x1::vector::borrow<FundAssetMetadata>(&arg0.assets_metadata, v4).weight;
        add_position_to_fund<0x2::sui::SUI>(arg0, v0, arg1, arg4);
        update_contribution_transaction(arg0, arg2, v0, v1, v1, v5, v4)
    }

    public fun contribute_to_fund<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut FundETF, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::option::Option<address>, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<HotPotatoContributionTransaction>, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<HotPotatoContributionTransaction> {
        assert!(!arg2.paused, 9);
        assert!(arg2.initalized, 4);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &mut arg3;
        take_fee<0x2::sui::SUI>(v1, arg2.creator, arg4, arg2.in_fee, arg7);
        let (v2, v3) = find_metadata_index_from_coin_type(arg2, v0);
        assert!(v2, 2);
        let v4 = 0x1::vector::borrow<FundAssetMetadata>(&arg2.assets_metadata, v3);
        let v5 = v4.weight;
        assert!(v4.pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1), 5);
        let (v6, v7) = swap_and_add_position<T0>(arg0, arg1, arg2, arg3, arg5, arg7);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v6);
        };
        update_contribution_transaction(arg2, arg6, v0, v7, 0x2::coin::value<0x2::sui::SUI>(&arg3), v5, v3)
    }

    public fun create_fund(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : FundETF {
        FundETF{
            id              : 0x2::object::new(arg7),
            creator         : arg4,
            initalized      : false,
            positions       : 0x2::bag::new(arg7),
            assets_metadata : 0x1::vector::empty<FundAssetMetadata>(),
            description     : 0x1::ascii::string(arg3),
            title           : 0x1::ascii::string(arg0),
            ticker          : 0x1::ascii::string(arg1),
            image_url       : 0x1::ascii::string(arg2),
            in_fee          : arg5,
            out_fee         : arg6,
            paused          : false,
        }
    }

    public fun destroy_contribution_transaction(arg0: &mut FundETF, arg1: 0x1::option::Option<HotPotatoContributionTransaction>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.initalized, 4);
        assert!(!arg0.paused, 9);
        if (0x1::option::is_some<HotPotatoContributionTransaction>(&arg1)) {
            let HotPotatoContributionTransaction {
                fund_id          : v0,
                swaps_to_execute : v1,
                swaps_executed   : v2,
                swaps_types      : _,
                shares           : v4,
                sui_amount       : v5,
            } = 0x1::option::destroy_some<HotPotatoContributionTransaction>(arg1);
            assert!(v2 == v1, 8);
            assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 6);
            let v6 = UserFundShare{
                id      : 0x2::object::new(arg2),
                fund_id : v0,
                shares  : v4,
            };
            emit_contribution_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg2), v4, v5, 0x2::object::uid_to_inner(&v6.id));
            0x2::transfer::public_transfer<UserFundShare>(v6, 0x2::tx_context::sender(arg2));
        } else {
            0x1::option::destroy_none<HotPotatoContributionTransaction>(arg1);
        };
    }

    public fun destroy_fund_share(arg0: UserFundShare, arg1: 0x1::option::Option<HotPotatoWithdrawalTransaction>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<HotPotatoWithdrawalTransaction>(&arg1)) {
            let HotPotatoWithdrawalTransaction {
                fund_id          : v0,
                swaps_to_execute : v1,
                swaps_executed   : v2,
                swaps_types      : _,
                sui_amount       : v4,
            } = 0x1::option::destroy_some<HotPotatoWithdrawalTransaction>(arg1);
            assert!(v2 == v1, 8);
            assert!(v0 == arg0.fund_id, 6);
            let UserFundShare {
                id      : v5,
                fund_id : v6,
                shares  : v7,
            } = arg0;
            let v8 = v5;
            emit_withdrawal_event(v6, 0x2::tx_context::sender(arg2), v7, v4, 0x2::object::uid_to_inner(&v8));
            0x2::object::delete(v8);
        } else {
            0x2::transfer::public_transfer<UserFundShare>(arg0, 0x2::tx_context::sender(arg2));
            0x1::option::destroy_none<HotPotatoWithdrawalTransaction>(arg1);
        };
    }

    public fun emergency_withdraw<T0>(arg0: &mut FundETF, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x4b0d62f8d195e018fc43a47ae9b493bef6ff6ec06c50dcc5219e14f249b3e65a, 1);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.positions, v0)) {
            let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, FundPosition<T0>>(&mut arg0.positions, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.balance, 0x2::balance::value<T0>(&v1.balance)), arg1), @0x4b0d62f8d195e018fc43a47ae9b493bef6ff6ec06c50dcc5219e14f249b3e65a);
        };
    }

    fun emit_contribution_event(arg0: 0x2::object::ID, arg1: address, arg2: vector<FundShareEntry>, arg3: u64, arg4: 0x2::object::ID) {
        let v0 = ContributionEvent{
            fund_id      : arg0,
            user_address : arg1,
            shares       : arg2,
            sui_amount   : arg3,
            position_id  : arg4,
        };
        0x2::event::emit<ContributionEvent>(v0);
    }

    public(friend) fun emit_fee_event(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: 0x1::type_name::TypeName) {
        let v0 = FeeEvent{
            creator       : arg0,
            affiliate     : arg1,
            creator_fee   : arg2,
            affiliate_fee : arg3,
            coin_type     : arg4,
        };
        0x2::event::emit<FeeEvent>(v0);
    }

    fun emit_fund_creation_event(arg0: &FundETF) {
        let v0 = FundCreationEvent{
            fund_id         : 0x2::object::uid_to_inner(&arg0.id),
            creator         : arg0.creator,
            title           : arg0.title,
            ticker          : arg0.ticker,
            image_url       : arg0.image_url,
            description     : arg0.description,
            in_fee          : arg0.in_fee,
            out_fee         : arg0.out_fee,
            assets_metadata : arg0.assets_metadata,
        };
        0x2::event::emit<FundCreationEvent>(v0);
    }

    fun emit_withdrawal_event(arg0: 0x2::object::ID, arg1: address, arg2: vector<FundShareEntry>, arg3: u64, arg4: 0x2::object::ID) {
        let v0 = WithdrawalEvent{
            fund_id      : arg0,
            user_address : arg1,
            shares       : arg2,
            sui_amount   : arg3,
            position_id  : arg4,
        };
        0x2::event::emit<WithdrawalEvent>(v0);
    }

    fun find_metadata_index_from_coin_type(arg0: &FundETF, arg1: 0x1::type_name::TypeName) : (bool, u64) {
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

    fun find_share_entry_by_coin_type(arg0: &vector<FundShareEntry>, arg1: 0x1::ascii::String) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FundShareEntry>(arg0)) {
            if (&0x1::vector::borrow<FundShareEntry>(arg0, v0).coin_type == &arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun get_asset_balance<T0>(arg0: &FundETF) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.positions, v0)) {
            0x2::balance::value<T0>(&0x2::bag::borrow<0x1::type_name::TypeName, FundPosition<T0>>(&arg0.positions, v0).balance)
        } else {
            0
        }
    }

    public fun get_assets_metadata(arg0: &FundETF) : &vector<FundAssetMetadata> {
        &arg0.assets_metadata
    }

    public fun get_coin_type(arg0: &FundAssetMetadata) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun get_coin_types_in_fund(arg0: &FundETF) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = get_assets_metadata(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<FundAssetMetadata>(v1)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, get_coin_type(0x1::vector::borrow<FundAssetMetadata>(v1, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_coin_weights(arg0: &FundETF) : vector<u64> {
        let v0 = get_assets_metadata(arg0);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<FundAssetMetadata>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<FundAssetMetadata>(v0, v2).weight);
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_total_weight(arg0: vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun is_coin_type_in_fund(arg0: vector<0x1::type_name::TypeName>, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(&arg0, v0) == &arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun pause_fund(arg0: &mut FundETF, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x4b0d62f8d195e018fc43a47ae9b493bef6ff6ec06c50dcc5219e14f249b3e65a, 1);
        arg0.paused = true;
    }

    public fun resume_fund(arg0: &mut FundETF, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x4b0d62f8d195e018fc43a47ae9b493bef6ff6ec06c50dcc5219e14f249b3e65a, 1);
        arg0.paused = false;
    }

    public fun swap_and_add_position<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut FundETF, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, _) = find_metadata_index_from_coin_type(arg2, v0);
        assert!(v1, 2);
        let (v3, v4) = 0x20b333cf7dea75ca98e193c275f0f0ae83e70d505be1cb0433f1b72d7fb4ef64::swapper::cetus_swap_b2a<T0, 0x2::sui::SUI>(arg3, arg1, arg0, arg4, arg5);
        let v5 = v3;
        add_position_to_fund<T0>(arg2, v0, v5, arg5);
        (v4, 0x2::coin::value<T0>(&v5))
    }

    fun swap_position_to_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &FundETF, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let (v0, _) = find_metadata_index_from_coin_type(arg2, 0x1::type_name::get<T0>());
        assert!(v0, 2);
        let (v2, v3) = 0x20b333cf7dea75ca98e193c275f0f0ae83e70d505be1cb0433f1b72d7fb4ef64::swapper::cetus_swap_a2b<T0, 0x2::sui::SUI>(arg3, arg1, arg0, arg4, arg5);
        let v4 = v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg5));
        (v2, 0x2::coin::value<T0>(&v4))
    }

    public fun take_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::option::Option<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3 == 0) {
            return
        };
        let v0 = 0x2::coin::value<T0>(arg0) * arg3 / 1000;
        if (v0 == 0) {
            return
        };
        if (0x1::option::is_some<address>(&arg2)) {
            if (v0 / 3 == 0) {
                return
            };
            let v1 = 0x2::coin::split<T0>(arg0, v0, arg4);
            let v2 = 0x1::option::borrow<address>(&arg2);
            let v3 = 0x2::coin::value<T0>(&v1) / 3;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, v3, arg4), *v2);
            emit_fee_event(arg1, *v2, v0, v3, 0x1::type_name::get<T0>());
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v0, arg4), arg1);
            emit_fee_event(arg1, arg1, v0, 0, 0x1::type_name::get<T0>());
        };
    }

    fun update_contribution_transaction(arg0: &FundETF, arg1: 0x1::option::Option<HotPotatoContributionTransaction>, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x1::option::Option<HotPotatoContributionTransaction> {
        if (0x1::option::is_some<HotPotatoContributionTransaction>(&arg1)) {
            let v1 = 0x1::option::borrow_mut<HotPotatoContributionTransaction>(&mut arg1);
            assert!(v1.fund_id == 0x2::object::uid_to_inner(&arg0.id), 6);
            v1.swaps_executed = v1.swaps_executed + 1;
            v1.sui_amount = v1.sui_amount + arg4;
            assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v1.swaps_types, &arg2), 7);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1.swaps_types, arg2);
            let v2 = FundShareEntry{
                coin_type  : 0x1::type_name::into_string(arg2),
                amount     : arg3,
                sui_amount : arg4,
                weight     : arg5,
                decimals   : 0x1::vector::borrow<FundAssetMetadata>(&arg0.assets_metadata, arg6).decimals,
            };
            0x1::vector::push_back<FundShareEntry>(&mut v1.shares, v2);
            arg1
        } else {
            let v3 = FundShareEntry{
                coin_type  : 0x1::type_name::into_string(arg2),
                amount     : arg3,
                sui_amount : arg4,
                weight     : arg5,
                decimals   : 0x1::vector::borrow<FundAssetMetadata>(&arg0.assets_metadata, arg6).decimals,
            };
            let v4 = HotPotatoContributionTransaction{
                fund_id          : 0x2::object::uid_to_inner(&arg0.id),
                swaps_to_execute : 0x1::vector::length<FundAssetMetadata>(&arg0.assets_metadata),
                swaps_executed   : 1,
                swaps_types      : 0x1::vector::singleton<0x1::type_name::TypeName>(arg2),
                shares           : 0x1::vector::singleton<FundShareEntry>(v3),
                sui_amount       : arg4,
            };
            0x1::option::destroy_none<HotPotatoContributionTransaction>(arg1);
            0x1::option::some<HotPotatoContributionTransaction>(v4)
        }
    }

    public fun withdraw_from_fund<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut FundETF, arg3: &0x2::clock::Clock, arg4: &UserFundShare, arg5: 0x1::option::Option<HotPotatoWithdrawalTransaction>, arg6: 0x1::option::Option<address>, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<HotPotatoWithdrawalTransaction> {
        assert!(arg2.initalized, 4);
        assert!(!arg2.paused, 9);
        assert!(arg4.fund_id == 0x2::object::uid_to_inner(&arg2.id), 6);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg2.positions, v0), 2);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, FundPosition<T0>>(&mut arg2.positions, v0);
        let (v2, v3) = find_share_entry_by_coin_type(&arg4.shares, 0x1::type_name::into_string(v0));
        assert!(v2, 2);
        let v4 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.balance, 0x1::vector::borrow<FundShareEntry>(&arg4.shares, v3).amount), arg7);
        let (v5, _) = swap_position_to_sui<T0>(arg0, arg1, arg2, v4, arg3, arg7);
        let v7 = v5;
        let v8 = &mut v7;
        take_fee<0x2::sui::SUI>(v8, arg2.creator, arg6, arg2.out_fee, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, 0x2::tx_context::sender(arg7));
        if (0x1::option::is_some<HotPotatoWithdrawalTransaction>(&arg5)) {
            let v10 = 0x1::option::borrow_mut<HotPotatoWithdrawalTransaction>(&mut arg5);
            assert!(v10.fund_id == 0x2::object::uid_to_inner(&arg2.id), 6);
            v10.swaps_executed = v10.swaps_executed + 1;
            v10.sui_amount = v10.sui_amount + 0x2::coin::value<0x2::sui::SUI>(&v7);
            assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v10.swaps_types, &v0), 7);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v10.swaps_types, v0);
            arg5
        } else {
            let v11 = HotPotatoWithdrawalTransaction{
                fund_id          : 0x2::object::uid_to_inner(&arg2.id),
                swaps_to_execute : 0x1::vector::length<FundAssetMetadata>(&arg2.assets_metadata),
                swaps_executed   : 1,
                swaps_types      : 0x1::vector::singleton<0x1::type_name::TypeName>(v0),
                sui_amount       : 0x2::coin::value<0x2::sui::SUI>(&v7),
            };
            0x1::option::destroy_none<HotPotatoWithdrawalTransaction>(arg5);
            0x1::option::some<HotPotatoWithdrawalTransaction>(v11)
        }
    }

    public fun withdraw_sui_from_fund<T0>(arg0: &mut FundETF, arg1: &UserFundShare, arg2: 0x1::option::Option<HotPotatoWithdrawalTransaction>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<HotPotatoWithdrawalTransaction> {
        assert!(arg0.initalized, 4);
        assert!(!arg0.paused, 9);
        assert!(arg1.fund_id == 0x2::object::uid_to_inner(&arg0.id), 6);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.positions, v0), 2);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, FundPosition<T0>>(&mut arg0.positions, v0);
        let (v2, v3) = find_share_entry_by_coin_type(&arg1.shares, 0x1::type_name::into_string(v0));
        assert!(v2, 2);
        let v4 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.balance, 0x1::vector::borrow<FundShareEntry>(&arg1.shares, v3).amount), arg4);
        let v5 = &mut v4;
        take_fee<T0>(v5, arg0.creator, arg3, arg0.out_fee, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg4));
        if (0x1::option::is_some<HotPotatoWithdrawalTransaction>(&arg2)) {
            let v7 = 0x1::option::borrow_mut<HotPotatoWithdrawalTransaction>(&mut arg2);
            assert!(v7.fund_id == 0x2::object::uid_to_inner(&arg0.id), 6);
            v7.swaps_executed = v7.swaps_executed + 1;
            v7.sui_amount = v7.sui_amount + 0x2::coin::value<T0>(&v4);
            assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v7.swaps_types, &v0), 7);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v7.swaps_types, v0);
            arg2
        } else {
            let v8 = HotPotatoWithdrawalTransaction{
                fund_id          : 0x2::object::uid_to_inner(&arg0.id),
                swaps_to_execute : 0x1::vector::length<FundAssetMetadata>(&arg0.assets_metadata),
                swaps_executed   : 1,
                swaps_types      : 0x1::vector::singleton<0x1::type_name::TypeName>(v0),
                sui_amount       : 0x2::coin::value<T0>(&v4),
            };
            0x1::option::destroy_none<HotPotatoWithdrawalTransaction>(arg2);
            0x1::option::some<HotPotatoWithdrawalTransaction>(v8)
        }
    }

    // decompiled from Move bytecode v6
}

