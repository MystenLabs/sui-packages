module 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        dao_fund_id: 0x2::object::ID,
    }

    struct DAOFund has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        total_supply: u64,
        icon_url: 0x2::url::Url,
        decimals: u8,
        token_type: 0x1::option::Option<0x1::ascii::String>,
        created_at: u64,
        dao_end_at: u64,
        fundraise_end_at: u64,
        assign_deadline: u64,
        price: u64,
        fundraise_goal: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        current_committed: u64,
        phase: 0x1::string::String,
        fundraise_status: 0x1::string::String,
        tracked_addresses: 0x2::table::Table<address, UserDAO>,
        is_seeded: bool,
        is_finished: bool,
        pool_id: 0x1::option::Option<0x1::string::String>,
        hurdle_rate_numerator: u64,
        carried_interest_numerator: u64,
        asset_keys: vector<vector<u8>>,
        assets: 0x2::bag::Bag,
        carried_distribution: 0x2::bag::Bag,
        platform_fee: 0x2::bag::Bag,
    }

    struct UserDAO has store {
        dao_type: 0x1::string::String,
        max_committable_amount: u64,
        total_committed_amount: u64,
        total_withdrawn_amount: u64,
    }

    struct DAOFundCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        total_supply: u64,
        icon_url: 0x2::url::Url,
        decimals: u8,
        token_type: 0x1::option::Option<0x1::ascii::String>,
        created_at: u64,
        dao_end_at: u64,
        fundraise_end_at: u64,
        price: u64,
        fundraise_goal: u64,
        phase: 0x1::string::String,
        fundraise_status: 0x1::string::String,
        hurdle_rate_numerator: u64,
        carried_interest_numerator: u64,
        denominator: u64,
        current_committed: u64,
    }

    struct DAOTokenAssignedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        coin_type: 0x1::ascii::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        total_supply: u64,
        icon_url: 0x2::url::Url,
        price: u64,
    }

    struct VipAddressAddedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        vip_address: address,
        max_committable_amount: u64,
        added_at: u64,
    }

    struct WhitelistAddressAddedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        whitelist_address: address,
        max_committable_amount: u64,
        added_at: u64,
    }

    struct CommittedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        committed_at: u64,
    }

    struct WithdrawnEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        withdrawn_at: u64,
    }

    struct RedeemedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    struct PhaseChangedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        phase: 0x1::string::String,
        created_at: u64,
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

    struct DaoFeeChangedEvent has copy, drop {
        sender: address,
        hurdle_rate_numerator: u64,
        carried_interest_numerator: u64,
        denominator: u64,
    }

    struct AssetsChangedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        amount: u64,
        change_type: 0x1::string::String,
    }

    public entry fun add_vip_address(arg0: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::operator::OperatorCap, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: address, arg3: &mut DAOFund, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        assert!(!is_existed_user_dao(arg3, arg2), 1000);
        let v0 = UserDAO{
            dao_type               : 0x1::string::utf8(b"vip"),
            max_committable_amount : arg4,
            total_committed_amount : 0,
            total_withdrawn_amount : 0,
        };
        0x2::table::add<address, UserDAO>(&mut arg3.tracked_addresses, arg2, v0);
        let v1 = VipAddressAddedEvent{
            dao_fund_id            : 0x2::object::id<DAOFund>(arg3),
            vip_address            : arg2,
            max_committable_amount : arg4,
            added_at               : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<VipAddressAddedEvent>(v1);
    }

    public entry fun add_whitelist_address(arg0: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::operator::OperatorCap, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: address, arg3: &mut DAOFund, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        assert!(!is_existed_user_dao(arg3, arg2), 1000);
        let v0 = UserDAO{
            dao_type               : 0x1::string::utf8(b"whitelist"),
            max_committable_amount : arg4,
            total_committed_amount : 0,
            total_withdrawn_amount : 0,
        };
        0x2::table::add<address, UserDAO>(&mut arg3.tracked_addresses, arg2, v0);
        let v1 = WhitelistAddressAddedEvent{
            dao_fund_id            : 0x2::object::id<DAOFund>(arg3),
            whitelist_address      : arg2,
            max_committable_amount : arg4,
            added_at               : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<WhitelistAddressAddedEvent>(v1);
    }

    public entry fun assign_dao_token<T0>(arg0: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::operator::OperatorCap, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: &mut DAOFund, arg3: &0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        assert!(arg2.fundraise_status == 0x1::string::utf8(b"succeed"), 1012);
        assert!(arg2.total_supply / 110 * (110 - 30) == 0x2::coin::value<T0>(&arg5), 1014);
        let v0 = 0x2::coin::get_name<T0>(arg4);
        let v1 = 0x2::coin::get_description<T0>(arg4);
        let v2 = 0x2::coin::total_supply<T0>(arg3);
        let v3 = 0x2::coin::get_decimals<T0>(arg4);
        let v4 = 0x2::coin::get_icon_url<T0>(arg4);
        arg2.name = v0;
        arg2.description = v1;
        arg2.total_supply = v2;
        arg2.icon_url = *0x1::option::borrow<0x2::url::Url>(&v4);
        arg2.decimals = v3;
        arg2.token_type = 0x1::option::some<0x1::ascii::String>(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v5 = ((((v2 / 110 * 100) as u64) / arg2.fundraise_goal * 110 / 100 * (v3 as u64) / 9) as u64);
        arg2.price = v5;
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg2.id, 0x1::string::utf8(b"dao_token_balance"), 0x2::coin::into_balance<T0>(arg5));
        let v6 = 0x2::balance::split<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::value<0x2::sui::SUI>(&arg2.balance) / 110 * (110 - 30));
        join_or_insert<0x2::sui::SUI>(arg2, v6);
        set_is_seeded(arg2);
        let v7 = DAOTokenAssignedEvent{
            dao_fund_id  : 0x2::object::id<DAOFund>(arg2),
            sender       : 0x2::tx_context::sender(arg6),
            coin_type    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            name         : v0,
            description  : v1,
            total_supply : v2,
            icon_url     : arg2.icon_url,
            price        : v5,
        };
        0x2::event::emit<DAOTokenAssignedEvent>(v7);
    }

    public entry fun bulk_add_vip_addresses(arg0: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::operator::OperatorCap, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: &mut DAOFund, arg3: vector<address>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 1014);
        let v1 = 0;
        while (v1 < v0) {
            add_vip_address(arg0, arg1, *0x1::vector::borrow<address>(&arg3, v1), arg2, *0x1::vector::borrow<u64>(&arg4, v1), arg5, arg6);
            v1 = v1 + 1;
        };
    }

    public entry fun bulk_add_whitelist_addresses(arg0: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::operator::OperatorCap, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: &mut DAOFund, arg3: vector<address>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 1014);
        let v1 = 0;
        while (v1 < v0) {
            add_whitelist_address(arg0, arg1, *0x1::vector::borrow<address>(&arg3, v1), arg2, *0x1::vector::borrow<u64>(&arg4, v1), arg5, arg6);
            v1 = v1 + 1;
        };
    }

    public entry fun change_fund_status(arg0: &mut DAOFund, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        assert!(arg0.fundraise_status == 0x1::string::utf8(b"fundraising"), 1011);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = ((arg0.fundraise_goal * 110 / 100) as u64);
        if (v0 < arg0.fundraise_end_at && 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v1) {
            arg0.fundraise_status = 0x1::string::utf8(b"succeed");
            arg0.assign_deadline = v0 + 259200000;
            let v2 = FundraiseSucceededEvent{
                dao_fund_id      : 0x2::object::id<DAOFund>(arg0),
                sender           : 0x2::tx_context::sender(arg3),
                fundraise_status : arg0.fundraise_status,
                updated_at       : v0,
            };
            0x2::event::emit<FundraiseSucceededEvent>(v2);
        } else if (v0 >= arg0.fundraise_end_at && 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) < v1) {
            arg0.fundraise_status = 0x1::string::utf8(b"failed");
            let v3 = FundraiseFailedEvent{
                dao_fund_id      : 0x2::object::id<DAOFund>(arg0),
                sender           : 0x2::tx_context::sender(arg3),
                fundraise_status : arg0.fundraise_status,
                updated_at       : v0,
            };
            0x2::event::emit<FundraiseFailedEvent>(v3);
        };
    }

    fun check_fund_withdrawable(arg0: &DAOFund, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 >= arg0.fundraise_end_at) {
            if (v0 < arg0.dao_end_at) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.balance) < ((arg0.fundraise_goal * 110 / 100) as u64)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1009);
    }

    public fun commit(arg0: &mut DAOFund, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: &mut 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::Committed, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        assert!(0x2::object::id<DAOFund>(arg0) == 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::get_committed_dao(arg2), 1015);
        validate_before_commit(arg0, arg5, arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg3, 1005);
        assert!(is_existed_user_dao(arg0, 0x2::tx_context::sender(arg6)), 1010);
        let v0 = get_committable_amount(arg0, arg3);
        commit_and_emit(arg0, arg1, arg4, v0, arg5, arg6);
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::increase_commit_amount(arg2, v0, arg6);
    }

    fun commit_and_emit(arg0: &mut DAOFund, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (!is_existed_user_dao(arg0, 0x2::tx_context::sender(arg5))) {
            let v0 = UserDAO{
                dao_type               : arg0.phase,
                max_committable_amount : 0,
                total_committed_amount : arg3,
                total_withdrawn_amount : 0,
            };
            0x2::table::add<address, UserDAO>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg5), v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, UserDAO>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg5));
            if (arg0.phase != 0x1::string::utf8(b"public_progress")) {
                assert!(v1.total_committed_amount + arg3 <= v1.max_committable_amount, 1007);
            };
            v1.total_committed_amount = v1.total_committed_amount + arg3;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3, arg5)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg5));
        arg0.current_committed = arg0.current_committed + arg3;
        if (arg0.current_committed == ((arg0.fundraise_goal * 110 / 100) as u64)) {
            change_fund_status(arg0, arg1, arg4, arg5);
        };
        let v2 = CommittedEvent{
            dao_fund_id  : 0x2::object::id<DAOFund>(arg0),
            sender       : 0x2::tx_context::sender(arg5),
            amount       : arg3,
            committed_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CommittedEvent>(v2);
    }

    public fun commit_first_time(arg0: &mut DAOFund, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        validate_before_commit(arg0, arg4, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg2, 1005);
        let v0 = get_committable_amount(arg0, arg2);
        assert!(!is_existed_user_dao(arg0, 0x2::tx_context::sender(arg5)) || 0x2::table::borrow_mut<address, UserDAO>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg5)).total_committed_amount == 0, 1017);
        commit_and_emit(arg0, arg1, arg3, v0, arg4, arg5);
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::transfer(0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::mint_and_emit(0x2::object::id<DAOFund>(arg0), v0, arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun create_dao_fund(arg0: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::operator::OperatorCap, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = ((((arg5 / 110 * 100) as u64) / arg7 * 110 / 100) as u64);
        let v2 = DAOFund{
            id                         : 0x2::object::new(arg9),
            creator                    : arg2,
            name                       : arg3,
            description                : arg4,
            total_supply               : arg5,
            icon_url                   : 0x2::url::new_unsafe_from_bytes(arg6),
            decimals                   : 9,
            token_type                 : 0x1::option::none<0x1::ascii::String>(),
            created_at                 : v0,
            dao_end_at                 : v0 + 1800000,
            fundraise_end_at           : v0 + 1200000,
            assign_deadline            : 0,
            price                      : v1,
            fundraise_goal             : arg7,
            balance                    : 0x2::balance::zero<0x2::sui::SUI>(),
            current_committed          : 0,
            phase                      : 0x1::string::utf8(b"accepting"),
            fundraise_status           : 0x1::string::utf8(b"fundraising"),
            tracked_addresses          : 0x2::table::new<address, UserDAO>(arg9),
            is_seeded                  : false,
            is_finished                : false,
            pool_id                    : 0x1::option::none<0x1::string::String>(),
            hurdle_rate_numerator      : 500,
            carried_interest_numerator : 800,
            asset_keys                 : 0x1::vector::empty<vector<u8>>(),
            assets                     : 0x2::bag::new(arg9),
            carried_distribution       : 0x2::bag::new(arg9),
            platform_fee               : 0x2::bag::new(arg9),
        };
        let v3 = DAOFundCreatedEvent{
            id                         : 0x2::object::id<DAOFund>(&v2),
            creator                    : arg2,
            name                       : arg3,
            description                : arg4,
            total_supply               : arg5,
            icon_url                   : v2.icon_url,
            decimals                   : v2.decimals,
            token_type                 : 0x1::option::none<0x1::ascii::String>(),
            created_at                 : v2.created_at,
            dao_end_at                 : v2.dao_end_at,
            fundraise_end_at           : v2.fundraise_end_at,
            price                      : v1,
            fundraise_goal             : arg7,
            phase                      : v2.phase,
            fundraise_status           : v2.fundraise_status,
            hurdle_rate_numerator      : 500,
            carried_interest_numerator : 800,
            denominator                : 10000,
            current_committed          : 0,
        };
        0x2::event::emit<DAOFundCreatedEvent>(v3);
        let v4 = PhaseChangedEvent{
            dao_fund_id : 0x2::object::id<DAOFund>(&v2),
            sender      : 0x2::tx_context::sender(arg9),
            phase       : 0x1::string::utf8(b"accepting"),
            created_at  : v0,
        };
        0x2::event::emit<PhaseChangedEvent>(v4);
        let v5 = AdminCap{
            id          : 0x2::object::new(arg9),
            dao_fund_id : 0x2::object::id<DAOFund>(&v2),
        };
        0x2::transfer::transfer<AdminCap>(v5, arg2);
        0x2::transfer::share_object<DAOFund>(v2);
    }

    fun get_committable_amount(arg0: &DAOFund, arg1: u64) : u64 {
        let v0 = ((arg0.fundraise_goal * 110 / 100) as u64);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v1 < v0, 1006);
        if (v1 + arg1 > v0) {
            v0 - v1
        } else {
            arg1
        }
    }

    public(friend) fun get_price(arg0: &DAOFund) : u64 {
        arg0.price
    }

    public(friend) fun get_seed_balance(arg0: &mut DAOFund, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg0.fundraise_status == 0x1::string::utf8(b"succeed"), 1012);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.dao_end_at, 1013);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) - arg0.fundraise_goal)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::new_global_dao_fee_and_shared(arg0);
    }

    fun is_existed_user_dao(arg0: &DAOFund, arg1: address) : bool {
        0x2::table::contains<address, UserDAO>(&arg0.tracked_addresses, arg1)
    }

    public(friend) fun is_seeded(arg0: &DAOFund) : bool {
        arg0.is_seeded
    }

    fun join_or_insert<T0>(arg0: &mut DAOFund, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::bag::contains<0x1::ascii::String>(&arg0.assets, v0)) {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.assets, v0, arg1);
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.assets, v0), arg1);
            0x1::vector::push_back<vector<u8>>(&mut arg0.asset_keys, 0x1::ascii::into_bytes(v0));
        };
        let v1 = AssetsChangedEvent{
            dao_fund_id : 0x2::object::id<DAOFund>(arg0),
            asset_type  : v0,
            amount      : 0x2::balance::value<T0>(&arg1),
            change_type : 0x1::string::utf8(b"join"),
        };
        0x2::event::emit<AssetsChangedEvent>(v1);
    }

    public entry fun redeem<T0>(arg0: &mut DAOFund, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::Committed, arg3: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        assert!(0x2::object::id<DAOFund>(arg0) == 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::get_committed_dao(&arg2), 1015);
        assert!(0x2::dynamic_field::exists_with_type<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::string::utf8(b"dao_token_balance")), 1016);
        let v0 = 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::get_committed_amount(&arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::string::utf8(b"dao_token_balance")), v0 * arg0.price), arg3), 0x2::tx_context::sender(arg3));
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::burn_and_emit(arg2, arg3);
        let v1 = RedeemedEvent{
            dao_fund_id : 0x2::object::id<DAOFund>(arg0),
            sender      : 0x2::tx_context::sender(arg3),
            amount      : v0,
        };
        0x2::event::emit<RedeemedEvent>(v1);
    }

    public entry fun set_dao_fee(arg0: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::operator::OperatorCap, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: &mut DAOFund, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        arg2.hurdle_rate_numerator = arg3;
        arg2.carried_interest_numerator = arg4;
        let v0 = DaoFeeChangedEvent{
            sender                     : 0x2::tx_context::sender(arg5),
            hurdle_rate_numerator      : arg3,
            carried_interest_numerator : arg4,
            denominator                : 10000,
        };
        0x2::event::emit<DaoFeeChangedEvent>(v0);
    }

    public(friend) fun set_is_seeded(arg0: &mut DAOFund) {
        arg0.is_seeded = true;
    }

    public entry fun set_platform_fee(arg0: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::operator::OperatorCap, arg1: &mut 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::set_platform_fee(arg1, arg2, arg3, arg4);
    }

    public entry fun set_to_public_phase(arg0: &AdminCap, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: &mut DAOFund, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        validate_admin_cap(arg0, arg2);
        validate_fundraise_time(arg2, arg3);
        assert!(arg2.phase == 0x1::string::utf8(b"vip_progress") || arg2.phase == 0x1::string::utf8(b"whitelist_progress"), 1002);
        arg2.phase = 0x1::string::utf8(b"public_progress");
        let v0 = PhaseChangedEvent{
            dao_fund_id : 0x2::object::uid_to_inner(&arg2.id),
            sender      : 0x2::tx_context::sender(arg4),
            phase       : 0x1::string::utf8(b"public_progress"),
            created_at  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PhaseChangedEvent>(v0);
    }

    public entry fun set_to_vip_phase(arg0: &AdminCap, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: &mut DAOFund, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        validate_admin_cap(arg0, arg2);
        validate_fundraise_time(arg2, arg3);
        assert!(arg2.phase == 0x1::string::utf8(b"accepting"), 1002);
        arg2.phase = 0x1::string::utf8(b"vip_progress");
        let v0 = PhaseChangedEvent{
            dao_fund_id : 0x2::object::uid_to_inner(&arg2.id),
            sender      : 0x2::tx_context::sender(arg4),
            phase       : 0x1::string::utf8(b"vip_progress"),
            created_at  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PhaseChangedEvent>(v0);
    }

    public entry fun set_to_whitelist_phase(arg0: &AdminCap, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: &mut DAOFund, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        validate_admin_cap(arg0, arg2);
        validate_fundraise_time(arg2, arg3);
        assert!(arg2.phase == 0x1::string::utf8(b"vip_progress"), 1002);
        arg2.phase = 0x1::string::utf8(b"whitelist_progress");
        let v0 = PhaseChangedEvent{
            dao_fund_id : 0x2::object::uid_to_inner(&arg2.id),
            sender      : 0x2::tx_context::sender(arg4),
            phase       : 0x1::string::utf8(b"whitelist_progress"),
            created_at  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PhaseChangedEvent>(v0);
    }

    fun validate_admin_cap(arg0: &AdminCap, arg1: &DAOFund) {
        assert!(arg0.dao_fund_id == 0x2::object::id<DAOFund>(arg1), 1004);
    }

    fun validate_before_commit(arg0: &DAOFund, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        validate_phase(arg0, 0x2::tx_context::sender(arg2));
        validate_fundraise_time(arg0, arg1);
        assert!(arg0.fundraise_status == 0x1::string::utf8(b"fundraising"), 1011);
    }

    fun validate_fundraise_time(arg0: &DAOFund, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.fundraise_end_at, 1003);
    }

    fun validate_phase(arg0: &DAOFund, arg1: address) {
        let v0 = arg0.phase;
        assert!(v0 != 0x1::string::utf8(b"accepting"), 1002);
        if (v0 == 0x1::string::utf8(b"vip_progress")) {
            assert!(is_existed_user_dao(arg0, arg1), 1001);
            assert!(0x2::table::borrow<address, UserDAO>(&arg0.tracked_addresses, arg1).dao_type == 0x1::string::utf8(b"vip"), 1002);
        } else if (v0 == 0x1::string::utf8(b"whitelist_progress")) {
            assert!(is_existed_user_dao(arg0, arg1), 1001);
            let v1 = 0x2::table::borrow<address, UserDAO>(&arg0.tracked_addresses, arg1);
            assert!(v1.dao_type == 0x1::string::utf8(b"vip") || v1.dao_type == 0x1::string::utf8(b"whitelist"), 1002);
        };
    }

    fun validate_withdraw_amount(arg0: &DAOFund, arg1: u64) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 1008);
    }

    public entry fun withdraw(arg0: &mut DAOFund, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::Committed, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        check_fund_withdrawable(arg0, arg3);
        assert!(0x2::object::id<DAOFund>(arg0) == 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::get_committed_dao(&arg2), 1015);
        let v0 = 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::get_committed_amount(&arg2);
        validate_withdraw_amount(arg0, v0);
        assert!(is_existed_user_dao(arg0, 0x2::tx_context::sender(arg4)), 1010);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0);
        withdraw_and_emit(arg0, v1, arg3, arg4);
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::burn_and_emit(arg2, arg4);
    }

    fun withdraw_and_emit(arg0: &mut DAOFund, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::table::borrow_mut<address, UserDAO>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg3));
        v1.total_withdrawn_amount = v1.total_withdrawn_amount + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg1, arg3), 0x2::tx_context::sender(arg3));
        let v2 = WithdrawnEvent{
            dao_fund_id  : 0x2::object::id<DAOFund>(arg0),
            sender       : 0x2::tx_context::sender(arg3),
            amount       : v0,
            withdrawn_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawnEvent>(v2);
    }

    public entry fun withdraw_by_operator(arg0: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::operator::OperatorCap, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: &mut DAOFund, arg3: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), 0x2::tx_context::sender(arg3));
        let v1 = OperatorWithdrawnEvent{
            dao_fund_id : 0x2::object::id<DAOFund>(arg2),
            sender      : 0x2::tx_context::sender(arg3),
            amount      : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<OperatorWithdrawnEvent>(v1);
    }

    public entry fun withdraw_with_amount(arg0: &mut DAOFund, arg1: &0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::GlobalDaoConfig, arg2: &mut 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::Committed, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::dao_config::check_package_version(arg1);
        check_fund_withdrawable(arg0, arg4);
        assert!(0x2::object::id<DAOFund>(arg0) == 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::get_committed_dao(arg2), 1015);
        let v0 = 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::get_committed_amount(arg2);
        validate_withdraw_amount(arg0, v0);
        assert!(is_existed_user_dao(arg0, 0x2::tx_context::sender(arg5)), 1010);
        assert!(arg3 < v0, 1009);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg3);
        withdraw_and_emit(arg0, v1, arg4, arg5);
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::committed::decrease_commit_amount(arg2, arg3, arg5);
    }

    // decompiled from Move bytecode v6
}

