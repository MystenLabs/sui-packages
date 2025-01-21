module 0x8fa648f25043a10e0231f33f4e1389637ce65780bdbc0517143110af5163eaab::dao {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        dao_fund_id: 0x2::object::ID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct DAOSeller has key {
        id: 0x2::object::UID,
        seller: 0x2::table::Table<address, u32>,
    }

    struct DAOFund<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        total_supply: u64,
        token_type: 0x1::ascii::String,
        start_at: u64,
        dao_end_at: u64,
        fundraise_end_at: u64,
        price: u128,
        fundraise_goal: u64,
        current_raise: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        phase: 0x1::string::String,
        fundraise_status: 0x1::string::String,
        tracked_addresses: 0x2::table::Table<address, UserDAO>,
        dao_token_balance: 0x2::balance::Balance<T0>,
        min_purchase_amount: u64,
        max_purchase_amount: u64,
        is_liquidity_injected: bool,
        is_deleted: bool,
    }

    struct UserDAO has store {
        dao_type: 0x1::string::String,
        max_committable_amount: u64,
        total_committed_amount: u64,
        is_claim: bool,
        is_refund: bool,
    }

    struct DAOFundCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        total_supply: u64,
        icon_url: 0x1::string::String,
        token_type: 0x1::ascii::String,
        start_at: u64,
        dao_end_at: u64,
        fundraise_end_at: u64,
        price: u128,
        fundraise_goal: u64,
        phase: 0x1::string::String,
        fundraise_status: 0x1::string::String,
        dao_token_balance: u64,
        min_purchase_amount: u64,
        max_purchase_amount: u64,
        is_liquidity_injected: bool,
    }

    struct DAOFundUpdatedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        total_supply: u64,
        icon_url: 0x1::string::String,
        token_type: 0x1::ascii::String,
        start_at: u64,
        dao_end_at: u64,
        fundraise_end_at: u64,
        price: u128,
        fundraise_goal: u64,
        phase: 0x1::string::String,
        fundraise_status: 0x1::string::String,
        dao_token_balance: u64,
        min_purchase_amount: u64,
        max_purchase_amount: u64,
        is_liquidity_injected: bool,
    }

    struct DaoFinalizedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        cetus_pool_address: address,
        initialize_price: u128,
    }

    struct WhitelistAddressAddedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        whitelist_address: address,
        max_committable_amount: u64,
        added_at: u64,
    }

    struct WhitelistAddressRemovedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        whitelist_address: address,
        remove_at: u64,
    }

    struct CommittedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    struct WithdrawnRefundEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    struct CancelPurchaseEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        fee: u64,
    }

    struct WithdrawnTokenEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    struct PhaseChangedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        phase: 0x1::string::String,
    }

    struct FundraiseSucceededEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        fundraise_status: 0x1::string::String,
        updated_at: u64,
    }

    struct FundraiseFailedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        fundraise_status: 0x1::string::String,
        updated_at: u64,
    }

    struct OperatorWithdrawnEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    public entry fun add_seller(arg0: &OperatorCap, arg1: &mut DAOSeller, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<address, u32>(&mut arg1.seller, arg2, 0);
    }

    public entry fun add_whitelist_address<T0>(arg0: &AdminCap, arg1: address, arg2: &mut DAOFund<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dao_fund_id == 0x2::object::id<DAOFund<T0>>(arg2), 1013);
        if (!is_existed_user_dao<T0>(arg2, arg1)) {
            let v0 = UserDAO{
                dao_type               : 0x1::string::utf8(b"whitelist"),
                max_committable_amount : arg3,
                total_committed_amount : 0,
                is_claim               : false,
                is_refund              : false,
            };
            0x2::table::add<address, UserDAO>(&mut arg2.tracked_addresses, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, UserDAO>(&mut arg2.tracked_addresses, 0x2::tx_context::sender(arg5));
            v1.max_committable_amount = arg3;
        };
        let v2 = WhitelistAddressAddedEvent{
            dao_fund_id            : 0x2::object::id<DAOFund<T0>>(arg2),
            whitelist_address      : arg1,
            max_committable_amount : arg3,
            added_at               : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<WhitelistAddressAddedEvent>(v2);
    }

    public entry fun bulk_add_whitelist_addresses<T0>(arg0: &AdminCap, arg1: &mut DAOFund<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dao_fund_id == 0x2::object::id<DAOFund<T0>>(arg1), 1013);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 1014);
        let v1 = 0;
        while (v1 < v0) {
            add_whitelist_address<T0>(arg0, *0x1::vector::borrow<address>(&arg2, v1), arg1, *0x1::vector::borrow<u64>(&arg3, v1), arg4, arg5);
            v1 = v1 + 1;
        };
    }

    fun calculate_price(arg0: u64, arg1: u64) : u128 {
        (arg1 as u128) * 110 / 100 * 1000000000000000000 / (arg0 as u128) * 100 / 110
    }

    fun calculate_token_amount_base_amount_sui(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * 1000000000000000000 / arg1) as u64)
    }

    public entry fun cancel_purchase<T0>(arg0: &mut DAOFund<T0>, arg1: &mut 0x8fa648f25043a10e0231f33f4e1389637ce65780bdbc0517143110af5163eaab::dao_config::GlobalDaoFee, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        validate_coin_type<T0>(arg0);
        let v0 = arg0.current_raise;
        let v1 = get_real_fundraise_goal<T0>(arg0);
        assert!(v0 < v1, 1017);
        assert!(is_existed_user_dao<T0>(arg0, 0x2::tx_context::sender(arg3)), 1001);
        let v2 = if (0x2::clock::timestamp_ms(arg2) < arg0.fundraise_end_at) {
            let v3 = arg0.current_raise;
            let v4 = get_real_fundraise_goal<T0>(arg0);
            v3 < v4
        } else {
            false
        };
        assert!(v2, 1019);
        let v5 = 0x2::table::borrow_mut<address, UserDAO>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg3));
        assert!(v5.is_refund == false && v5.is_claim == false, 1019);
        let v6 = v5.total_committed_amount;
        let v7 = v6 / 10;
        let v8 = v6 - v7;
        v5.total_committed_amount = 0;
        arg0.current_raise = arg0.current_raise - v8;
        validate_withdraw_sui_amount<T0>(arg0, v8 + v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v8), arg3), 0x2::tx_context::sender(arg3));
        let (_, _, v11) = 0x8fa648f25043a10e0231f33f4e1389637ce65780bdbc0517143110af5163eaab::dao_config::get_dao_fee_config(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v7), arg3), v11);
        let v12 = CancelPurchaseEvent{
            dao_fund_id : 0x2::object::id<DAOFund<T0>>(arg0),
            sender      : 0x2::tx_context::sender(arg3),
            amount      : v8,
            fee         : v7,
        };
        0x2::event::emit<CancelPurchaseEvent>(v12);
    }

    public entry fun change_fund_status<T0>(arg0: &mut DAOFund<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fundraise_status == 0x1::string::utf8(b"fundraising"), 1011);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.current_raise >= ((arg0.fundraise_goal * 110 / 100) as u64)) {
            arg0.fundraise_status = 0x1::string::utf8(b"succeed");
            let v1 = FundraiseSucceededEvent{
                dao_fund_id      : 0x2::object::id<DAOFund<T0>>(arg0),
                sender           : 0x2::tx_context::sender(arg2),
                fundraise_status : arg0.fundraise_status,
                updated_at       : v0,
            };
            0x2::event::emit<FundraiseSucceededEvent>(v1);
        } else if (v0 >= arg0.fundraise_end_at) {
            arg0.fundraise_status = 0x1::string::utf8(b"failed");
            let v2 = FundraiseFailedEvent{
                dao_fund_id      : 0x2::object::id<DAOFund<T0>>(arg0),
                sender           : 0x2::tx_context::sender(arg2),
                fundraise_status : arg0.fundraise_status,
                updated_at       : v0,
            };
            0x2::event::emit<FundraiseFailedEvent>(v2);
        };
    }

    fun check_is_refund<T0>(arg0: &DAOFund<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.fundraise_end_at && arg0.current_raise < ((arg0.fundraise_goal * 110 / 100) as u64), 1009);
    }

    public entry fun claim_token_success<T0>(arg0: &mut DAOFund<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        validate_coin_type<T0>(arg0);
        let v0 = arg0.current_raise;
        let v1 = get_real_fundraise_goal<T0>(arg0);
        assert!(v0 >= v1, 1012);
        assert!(arg0.is_liquidity_injected == true, 1020);
        assert!(is_existed_user_dao<T0>(arg0, 0x2::tx_context::sender(arg2)), 1001);
        let v2 = 0x2::table::borrow_mut<address, UserDAO>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg2));
        assert!(v2.is_claim == false, 1016);
        let v3 = calculate_token_amount_base_amount_sui(v2.total_committed_amount, arg0.price);
        validate_withdraw_token_amount<T0>(arg0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.dao_token_balance, v3), arg2), 0x2::tx_context::sender(arg2));
        let v4 = WithdrawnTokenEvent{
            dao_fund_id : 0x2::object::id<DAOFund<T0>>(arg0),
            sender      : 0x2::tx_context::sender(arg2),
            amount      : v3,
        };
        0x2::event::emit<WithdrawnTokenEvent>(v4);
    }

    public entry fun commit<T0>(arg0: &mut DAOFund<T0>, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        validate_deleted<T0>(arg0);
        validate_coin_type<T0>(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1, 1005);
        validate_fundraise_time_end<T0>(arg0, arg3);
        validate_fundraise_time_start<T0>(arg0, arg3);
        assert!(arg0.fundraise_status == 0x1::string::utf8(b"fundraising"), 1011);
        validate_phase<T0>(arg0, 0x2::tx_context::sender(arg4));
        let v0 = ((arg0.fundraise_goal * 110 / 100) as u64);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v1 < v0, 1006);
        let v2 = if (v1 + arg1 > v0) {
            v0 - v1
        } else {
            arg1
        };
        if (!is_existed_user_dao<T0>(arg0, 0x2::tx_context::sender(arg4))) {
            assert!(v2 <= arg0.max_purchase_amount, 1007);
            assert!(v2 >= arg0.min_purchase_amount, 1022);
            let v3 = UserDAO{
                dao_type               : 0x1::string::utf8(b"fcfs"),
                max_committable_amount : arg0.max_purchase_amount,
                total_committed_amount : v2,
                is_claim               : false,
                is_refund              : false,
            };
            0x2::table::add<address, UserDAO>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg4), v3);
        } else {
            let v4 = 0x2::table::borrow_mut<address, UserDAO>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg4));
            let v5 = v4.max_committable_amount;
            if (v4.dao_type == 0x1::string::utf8(b"fcfs")) {
                v5 = arg0.max_purchase_amount;
            };
            assert!(v4.total_committed_amount + v2 <= v5, 1007);
            v4.total_committed_amount = v4.total_committed_amount + v2;
        };
        arg0.current_raise = arg0.current_raise + v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        let v6 = CommittedEvent{
            dao_fund_id : 0x2::object::id<DAOFund<T0>>(arg0),
            sender      : 0x2::tx_context::sender(arg4),
            amount      : v2,
        };
        0x2::event::emit<CommittedEvent>(v6);
    }

    public entry fun create_dao_fund<T0>(arg0: &DAOSeller, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(is_existed_seller_dao(arg0, 0x2::tx_context::sender(arg12)), 1021);
        assert!(0x2::coin::value<T0>(&arg6) == arg5, 1005);
        assert!(arg7 >= 0x2::clock::timestamp_ms(arg11), 1015);
        let v0 = calculate_price(arg5, arg8);
        let v1 = DAOFund<T0>{
            id                    : 0x2::object::new(arg12),
            creator               : 0x2::tx_context::sender(arg12),
            name                  : arg1,
            symbol                : arg2,
            description           : arg3,
            icon_url              : arg4,
            total_supply          : arg5,
            token_type            : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            start_at              : arg7,
            dao_end_at            : arg7 + 31536000000,
            fundraise_end_at      : arg7 + 604800000,
            price                 : v0,
            fundraise_goal        : arg8,
            current_raise         : 0,
            balance               : 0x2::balance::zero<0x2::sui::SUI>(),
            phase                 : 0x1::string::utf8(b"whitelist"),
            fundraise_status      : 0x1::string::utf8(b"fundraising"),
            tracked_addresses     : 0x2::table::new<address, UserDAO>(arg12),
            dao_token_balance     : 0x2::coin::into_balance<T0>(arg6),
            min_purchase_amount   : arg9,
            max_purchase_amount   : arg10,
            is_liquidity_injected : false,
            is_deleted            : false,
        };
        let v2 = DAOFundCreatedEvent{
            id                    : 0x2::object::id<DAOFund<T0>>(&v1),
            name                  : arg1,
            symbol                : arg2,
            description           : arg3,
            total_supply          : arg5,
            icon_url              : arg4,
            token_type            : v1.token_type,
            start_at              : v1.start_at,
            dao_end_at            : v1.dao_end_at,
            fundraise_end_at      : v1.fundraise_end_at,
            price                 : v0,
            fundraise_goal        : arg8,
            phase                 : v1.phase,
            fundraise_status      : v1.fundraise_status,
            dao_token_balance     : arg5,
            min_purchase_amount   : arg9,
            max_purchase_amount   : arg10,
            is_liquidity_injected : false,
        };
        0x2::event::emit<DAOFundCreatedEvent>(v2);
        let v3 = PhaseChangedEvent{
            dao_fund_id : 0x2::object::id<DAOFund<T0>>(&v1),
            sender      : 0x2::tx_context::sender(arg12),
            phase       : 0x1::string::utf8(b"whitelist"),
        };
        0x2::event::emit<PhaseChangedEvent>(v3);
        let v4 = AdminCap{
            id          : 0x2::object::new(arg12),
            dao_fund_id : 0x2::object::id<DAOFund<T0>>(&v1),
        };
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg12));
        0x2::transfer::share_object<DAOFund<T0>>(v1);
    }

    public entry fun delete_pool<T0>(arg0: &OperatorCap, arg1: &mut DAOFund<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.is_deleted = true;
    }

    public fun finalize_dao<T0>(arg0: &AdminCap, arg1: &mut DAOFund<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dao_fund_id == 0x2::object::id<DAOFund<T0>>(arg1), 1013);
        assert!(arg1.is_liquidity_injected == false, 1010);
        let v0 = arg1.current_raise;
        let v1 = get_real_fundraise_goal<T0>(arg1);
        assert!(v0 >= v1, 1010);
        validate_deleted<T0>(arg1);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0x1::ascii::as_bytes(&v2);
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>());
        let v5 = 0;
        let v6 = false;
        while (v5 < 0x1::vector::length<u8>(v3)) {
            let v7 = *0x1::vector::borrow<u8>(v3, v5);
            let v8 = *0x1::vector::borrow<u8>(0x1::ascii::as_bytes(&v4), v5);
            if (v8 < v7) {
                break
            };
            if (v8 > v7) {
                v6 = true;
                break
            };
            v5 = v5 + 1;
        };
        let v9 = get_real_fundraise_goal<T0>(arg1);
        let v10 = v9 - arg1.fundraise_goal - 1;
        let v11 = arg1.total_supply / 11 - 1;
        arg1.is_liquidity_injected = true;
        arg1.fundraise_status = 0x1::string::utf8(b"succeed");
        let (v12, v13, v14) = if (v6) {
            let v15 = sqrt(340282366920938463463374607431768211456 * (v11 as u256) / (v10 as u256));
            let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<0x2::sui::SUI, T0>(arg2, arg3, 60, v15, 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v10), arg7), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.dao_token_balance, v11), arg7), arg5, arg4, true, arg6, arg7);
            let v19 = v16;
            let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v19);
            0x2::balance::join<T0>(&mut arg1.dao_token_balance, 0x2::coin::into_balance<T0>(v18));
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(v17));
            (v15, 0x2::object::id_to_address(&v20), v19)
        } else {
            let v21 = sqrt(340282366920938463463374607431768211456 * (v11 as u256) / (v10 as u256));
            let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, 0x2::sui::SUI>(arg2, arg3, 60, v21, 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.dao_token_balance, v11), arg7), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v10), arg7), arg4, arg5, false, arg6, arg7);
            let v25 = v22;
            let v26 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v25);
            0x2::balance::join<T0>(&mut arg1.dao_token_balance, 0x2::coin::into_balance<T0>(v23));
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(v24));
            (v21, 0x2::object::id_to_address(&v26), v25)
        };
        let v27 = DaoFinalizedEvent{
            dao_fund_id        : 0x2::object::id<DAOFund<T0>>(arg1),
            cetus_pool_address : v13,
            initialize_price   : v12,
        };
        if (arg1.dao_end_at > 0) {
            0x8fa648f25043a10e0231f33f4e1389637ce65780bdbc0517143110af5163eaab::lock::lock_nft_to<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v14, arg1.creator, 31536000000, arg6, arg7);
        } else {
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v14, arg1.creator);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg1.fundraise_goal - 1), arg7), 0x2::tx_context::sender(arg7));
        0x2::event::emit<DaoFinalizedEvent>(v27);
    }

    fun get_real_fundraise_goal<T0>(arg0: &mut DAOFund<T0>) : u64 {
        arg0.fundraise_goal * 110 / 100
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
        0x8fa648f25043a10e0231f33f4e1389637ce65780bdbc0517143110af5163eaab::dao_config::new_global_dao_fee_and_shared(arg0);
        let v1 = DAOSeller{
            id     : 0x2::object::new(arg0),
            seller : 0x2::table::new<address, u32>(arg0),
        };
        0x2::transfer::share_object<DAOSeller>(v1);
    }

    fun is_existed_seller_dao(arg0: &DAOSeller, arg1: address) : bool {
        0x2::table::contains<address, u32>(&arg0.seller, arg1)
    }

    fun is_existed_user_dao<T0>(arg0: &DAOFund<T0>, arg1: address) : bool {
        0x2::table::contains<address, UserDAO>(&arg0.tracked_addresses, arg1)
    }

    fun is_whitelist_user_dao<T0>(arg0: &mut DAOFund<T0>, arg1: address) : bool {
        0x2::table::contains<address, UserDAO>(&arg0.tracked_addresses, arg1) && 0x2::table::borrow_mut<address, UserDAO>(&mut arg0.tracked_addresses, arg1).dao_type == 0x1::string::utf8(b"whitelist")
    }

    public entry fun remove_seller(arg0: &OperatorCap, arg1: &mut DAOSeller, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::remove<address, u32>(&mut arg1.seller, arg2);
    }

    public entry fun remove_whitelist_address<T0>(arg0: &AdminCap, arg1: address, arg2: &mut DAOFund<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_existed_user_dao<T0>(arg2, arg1), 1024);
        assert!(arg0.dao_fund_id == 0x2::object::id<DAOFund<T0>>(arg2), 1013);
        let v0 = 0x2::table::borrow_mut<address, UserDAO>(&mut arg2.tracked_addresses, 0x2::tx_context::sender(arg4));
        assert!(v0.dao_type == 0x1::string::utf8(b"whitelist"), 1025);
        v0.max_committable_amount = 0;
        let v1 = WhitelistAddressRemovedEvent{
            dao_fund_id       : 0x2::object::id<DAOFund<T0>>(arg2),
            whitelist_address : arg1,
            remove_at         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WhitelistAddressRemovedEvent>(v1);
    }

    public entry fun reopen_pool<T0>(arg0: &OperatorCap, arg1: &mut DAOFund<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.is_deleted = false;
    }

    public entry fun set_platform_fee(arg0: &OperatorCap, arg1: &mut 0x8fa648f25043a10e0231f33f4e1389637ce65780bdbc0517143110af5163eaab::dao_config::GlobalDaoFee, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        0x8fa648f25043a10e0231f33f4e1389637ce65780bdbc0517143110af5163eaab::dao_config::set_platform_fee(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun set_to_public_phase<T0>(arg0: &AdminCap, arg1: &mut DAOFund<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        validate_fundraise_time_end<T0>(arg1, arg2);
        assert!(arg0.dao_fund_id == 0x2::object::id<DAOFund<T0>>(arg1), 1013);
        assert!(arg1.phase == 0x1::string::utf8(b"whitelist"), 1002);
        arg1.phase = 0x1::string::utf8(b"public_progress");
        let v0 = PhaseChangedEvent{
            dao_fund_id : 0x2::object::uid_to_inner(&arg1.id),
            sender      : 0x2::tx_context::sender(arg3),
            phase       : 0x1::string::utf8(b"public_progress"),
        };
        0x2::event::emit<PhaseChangedEvent>(v0);
    }

    fun sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 1);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        (arg0 as u128)
    }

    public entry fun update_dao_fund<T0>(arg0: &AdminCap, arg1: &mut DAOFund<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dao_fund_id == 0x2::object::id<DAOFund<T0>>(arg1), 1013);
        assert!(arg6 >= 0x2::clock::timestamp_ms(arg10), 1015);
        let v0 = calculate_price(arg1.total_supply, arg7);
        arg1.name = arg2;
        arg1.symbol = arg3;
        arg1.description = arg4;
        arg1.icon_url = arg5;
        arg1.start_at = arg6;
        arg1.fundraise_goal = arg7;
        arg1.dao_end_at = arg6 + 31536000000;
        arg1.fundraise_end_at = arg6 + 604800000;
        arg1.price = v0;
        arg1.min_purchase_amount = arg8;
        arg1.max_purchase_amount = arg9;
        let v1 = DAOFundUpdatedEvent{
            id                    : 0x2::object::id<DAOFund<T0>>(arg1),
            name                  : arg2,
            symbol                : arg3,
            description           : arg4,
            total_supply          : arg1.total_supply,
            icon_url              : arg5,
            token_type            : arg1.token_type,
            start_at              : arg1.start_at,
            dao_end_at            : arg1.dao_end_at,
            fundraise_end_at      : arg1.fundraise_end_at,
            price                 : v0,
            fundraise_goal        : arg7,
            phase                 : arg1.phase,
            fundraise_status      : arg1.fundraise_status,
            dao_token_balance     : arg1.total_supply,
            min_purchase_amount   : arg8,
            max_purchase_amount   : arg9,
            is_liquidity_injected : false,
        };
        0x2::event::emit<DAOFundUpdatedEvent>(v1);
    }

    fun validate_coin_type<T0>(arg0: &DAOFund<T0>) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == arg0.token_type, 1004);
    }

    fun validate_deleted<T0>(arg0: &DAOFund<T0>) {
        assert!(arg0.is_deleted == false, 1023);
    }

    fun validate_fundraise_time_end<T0>(arg0: &DAOFund<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.fundraise_end_at, 1003);
    }

    fun validate_fundraise_time_start<T0>(arg0: &DAOFund<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_at, 1003);
    }

    fun validate_phase<T0>(arg0: &DAOFund<T0>, arg1: address) {
        if (arg0.phase == 0x1::string::utf8(b"whitelist")) {
            assert!(is_existed_user_dao<T0>(arg0, arg1), 1001);
            assert!(0x2::table::borrow<address, UserDAO>(&arg0.tracked_addresses, arg1).dao_type == 0x1::string::utf8(b"whitelist"), 1002);
        };
    }

    fun validate_withdraw_sui_amount<T0>(arg0: &DAOFund<T0>, arg1: u64) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 1008);
    }

    fun validate_withdraw_token_amount<T0>(arg0: &DAOFund<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(&arg0.dao_token_balance) >= arg1, 1008);
    }

    public entry fun withdraw_by_operator<T0>(arg0: &OperatorCap, arg1: &mut DAOFund<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), 0x2::tx_context::sender(arg2));
        let v1 = OperatorWithdrawnEvent{
            dao_fund_id : 0x2::object::id<DAOFund<T0>>(arg1),
            sender      : 0x2::tx_context::sender(arg2),
            amount      : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<OperatorWithdrawnEvent>(v1);
    }

    public entry fun withdraw_refund<T0>(arg0: &mut DAOFund<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        validate_coin_type<T0>(arg0);
        check_is_refund<T0>(arg0, arg1);
        assert!(is_existed_user_dao<T0>(arg0, 0x2::tx_context::sender(arg2)), 1001);
        let v0 = 0x2::table::borrow_mut<address, UserDAO>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg2));
        assert!(v0.is_refund == false, 1018);
        assert!(v0.total_committed_amount > 0, 1026);
        let v1 = v0.total_committed_amount;
        validate_withdraw_sui_amount<T0>(arg0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v1), arg2), 0x2::tx_context::sender(arg2));
        let v2 = WithdrawnRefundEvent{
            dao_fund_id : 0x2::object::id<DAOFund<T0>>(arg0),
            sender      : 0x2::tx_context::sender(arg2),
            amount      : v1,
        };
        0x2::event::emit<WithdrawnRefundEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

