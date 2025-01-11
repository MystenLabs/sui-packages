module 0x810f2397b61cca1bfcd2497159fcdd128a51bd7cc56f9119feae297735d11eba::dao {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        dao_fund_id: 0x2::object::ID,
    }

    struct SharedObj has key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct DAOFund<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        total_supply: u64,
        icon_url: 0x1::string::String,
        token_type: 0x1::ascii::String,
        created_at: u64,
        dao_end_at: u64,
        fundraise_end_at: u64,
        price: u64,
        fundraise_goal: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        phase: 0x1::string::String,
        fundraise_status: 0x1::string::String,
        tracked_addresses: 0x2::table::Table<address, UserDAO>,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        is_seeded: bool,
        hurdle_rate_numerator: u64,
        carried_interest_numerator: u64,
        platform_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        carried_distribution: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct UserDAO has store {
        dao_type: 0x1::string::String,
        max_committable_amount: u64,
        total_committed_amount: u64,
        total_withdrawn_amount: u64,
        records: 0x2::table::Table<address, Record>,
    }

    struct Record has drop, store {
        sender: address,
        token_type: 0x1::ascii::String,
        committed_amount: u64,
        withdrawn_amount: u64,
        created_at: u64,
    }

    struct DAOFundCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        total_supply: u64,
        icon_url: 0x1::string::String,
        token_type: 0x1::ascii::String,
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
        current_platform_fee: u64,
        current_carried_distribution: u64,
    }

    struct TokenMintedEvent has copy, drop {
        token_type: 0x1::ascii::String,
        sender: address,
        amount: u64,
        minted_at: u64,
    }

    struct TokenBurnedEvent has copy, drop {
        token_type: 0x1::ascii::String,
        sender: address,
        amount: u64,
        burned_at: u64,
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

    struct DaoFundFeeClaimedEvent has copy, drop {
        dao_fund_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        claim_type: 0x1::string::String,
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

    public entry fun add_vip_address<T0>(arg0: &AdminCap, arg1: address, arg2: &mut DAOFund<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!is_existed_user_dao<T0>(arg2, arg1), 1000);
        let v0 = UserDAO{
            dao_type               : 0x1::string::utf8(b"vip"),
            max_committable_amount : arg3,
            total_committed_amount : 0,
            total_withdrawn_amount : 0,
            records                : 0x2::table::new<address, Record>(arg5),
        };
        0x2::table::add<address, UserDAO>(&mut arg2.tracked_addresses, arg1, v0);
        let v1 = VipAddressAddedEvent{
            dao_fund_id            : 0x2::object::id<DAOFund<T0>>(arg2),
            vip_address            : arg1,
            max_committable_amount : arg3,
            added_at               : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VipAddressAddedEvent>(v1);
    }

    public entry fun add_whitelist_address<T0>(arg0: &AdminCap, arg1: address, arg2: &mut DAOFund<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!is_existed_user_dao<T0>(arg2, arg1), 1000);
        let v0 = UserDAO{
            dao_type               : 0x1::string::utf8(b"whitelist"),
            max_committable_amount : arg3,
            total_committed_amount : 0,
            total_withdrawn_amount : 0,
            records                : 0x2::table::new<address, Record>(arg5),
        };
        0x2::table::add<address, UserDAO>(&mut arg2.tracked_addresses, arg1, v0);
        let v1 = WhitelistAddressAddedEvent{
            dao_fund_id            : 0x2::object::id<DAOFund<T0>>(arg2),
            whitelist_address      : arg1,
            max_committable_amount : arg3,
            added_at               : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<WhitelistAddressAddedEvent>(v1);
    }

    public entry fun change_fund_status<T0>(arg0: &mut DAOFund<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fundraise_status == 0x1::string::utf8(b"fundraising"), 1011);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = ((arg0.fundraise_goal * 110 / 100) as u64);
        if (v0 < arg0.fundraise_end_at && 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v1) {
            arg0.fundraise_status = 0x1::string::utf8(b"succeed");
            let v2 = 0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut v2, (((v1 - 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)) * arg0.price) as u64), arg2), arg0.creator);
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v2, @0x0);
            let v3 = FundraiseSucceededEvent{
                dao_fund_id      : 0x2::object::id<DAOFund<T0>>(arg0),
                sender           : 0x2::tx_context::sender(arg2),
                fundraise_status : arg0.fundraise_status,
                updated_at       : v0,
            };
            0x2::event::emit<FundraiseSucceededEvent>(v3);
        } else if (v0 >= arg0.fundraise_end_at && 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) < v1) {
            arg0.fundraise_status = 0x1::string::utf8(b"failed");
            let v4 = FundraiseFailedEvent{
                dao_fund_id      : 0x2::object::id<DAOFund<T0>>(arg0),
                sender           : 0x2::tx_context::sender(arg2),
                fundraise_status : arg0.fundraise_status,
                updated_at       : v0,
            };
            0x2::event::emit<FundraiseFailedEvent>(v4);
        };
    }

    fun check_fund_withdrawable<T0>(arg0: &DAOFund<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.dao_end_at) {
            assert!(v0 >= arg0.fundraise_end_at && 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) < ((arg0.fundraise_goal * 110 / 100) as u64), 1009);
        };
    }

    public entry fun claim_carry_distribution<T0>(arg0: &AdminCap, arg1: &mut DAOFund<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.carried_distribution);
        assert!(v0 > 0, 1005);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.carried_distribution), arg2), 0x2::tx_context::sender(arg2));
        let v1 = DaoFundFeeClaimedEvent{
            dao_fund_id : 0x2::object::id<DAOFund<T0>>(arg1),
            sender      : 0x2::tx_context::sender(arg2),
            amount      : v0,
            claim_type  : 0x1::string::utf8(b"carried_distribution"),
        };
        0x2::event::emit<DaoFundFeeClaimedEvent>(v1);
    }

    public entry fun claim_platform_fee<T0>(arg0: &OperatorCap, arg1: &mut DAOFund<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.platform_fee);
        assert!(v0 > 0, 1005);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.platform_fee), arg2), 0x2::tx_context::sender(arg2));
        let v1 = DaoFundFeeClaimedEvent{
            dao_fund_id : 0x2::object::id<DAOFund<T0>>(arg1),
            sender      : 0x2::tx_context::sender(arg2),
            amount      : v0,
            claim_type  : 0x1::string::utf8(b"platform_fee"),
        };
        0x2::event::emit<DaoFundFeeClaimedEvent>(v1);
    }

    public entry fun commit<T0>(arg0: &mut DAOFund<T0>, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        validate_coin_type<T0>(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1, 1005);
        validate_phase<T0>(arg0, 0x2::tx_context::sender(arg4));
        validate_fundraise_time<T0>(arg0, arg3);
        assert!(arg0.fundraise_status == 0x1::string::utf8(b"fundraising"), 1011);
        let v0 = ((arg0.fundraise_goal * 110 / 100) as u64);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v1 < v0, 1006);
        let v2 = if (v1 + arg1 > v0) {
            v0 - v1
        } else {
            arg1
        };
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = Record{
            sender           : 0x2::tx_context::sender(arg4),
            token_type       : arg0.token_type,
            committed_amount : v2,
            withdrawn_amount : 0,
            created_at       : v3,
        };
        if (!is_existed_user_dao<T0>(arg0, 0x2::tx_context::sender(arg4))) {
            let v5 = 0x2::table::new<address, Record>(arg4);
            0x2::table::add<address, Record>(&mut v5, 0x2::tx_context::sender(arg4), v4);
            let v6 = UserDAO{
                dao_type               : arg0.phase,
                max_committable_amount : 0,
                total_committed_amount : v2,
                total_withdrawn_amount : 0,
                records                : v5,
            };
            0x2::table::add<address, UserDAO>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg4), v6);
        } else {
            let v7 = 0x2::table::borrow_mut<address, UserDAO>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg4));
            assert!(v7.total_committed_amount + v2 <= v7.max_committable_amount, 1007);
            v7.total_committed_amount = v7.total_committed_amount + v2;
        };
        let v8 = arg0.price * v2;
        let v9 = mint_dao_token<T0>(arg0, v8, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, 0x2::tx_context::sender(arg4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        let v10 = CommittedEvent{
            dao_fund_id  : 0x2::object::id<DAOFund<T0>>(arg0),
            sender       : 0x2::tx_context::sender(arg4),
            amount       : arg1,
            committed_at : v3,
        };
        0x2::event::emit<CommittedEvent>(v10);
    }

    public entry fun create_dao_fund<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: &mut SharedObj, arg7: 0x2::transfer::Receiving<0x2::coin::TreasuryCap<T0>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = ((arg3 / arg5 * 110 / 100) as u64);
        let v2 = DAOFund<T0>{
            id                         : 0x2::object::new(arg9),
            creator                    : 0x2::tx_context::sender(arg9),
            name                       : arg0,
            symbol                     : arg1,
            description                : arg2,
            total_supply               : arg3,
            icon_url                   : arg4,
            token_type                 : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            created_at                 : v0,
            dao_end_at                 : v0 + 31536000000,
            fundraise_end_at           : v0 + 604800000,
            price                      : v1,
            fundraise_goal             : arg5,
            balance                    : 0x2::balance::zero<0x2::sui::SUI>(),
            phase                      : 0x1::string::utf8(b"accepting"),
            fundraise_status           : 0x1::string::utf8(b"fundraising"),
            tracked_addresses          : 0x2::table::new<address, UserDAO>(arg9),
            treasury_cap               : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(0x2::transfer::public_receive<0x2::coin::TreasuryCap<T0>>(&mut arg6.id, arg7)),
            is_seeded                  : false,
            hurdle_rate_numerator      : 500,
            carried_interest_numerator : 800,
            platform_fee               : 0x2::balance::zero<0x2::sui::SUI>(),
            carried_distribution       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v3 = DAOFundCreatedEvent{
            id                           : 0x2::object::id<DAOFund<T0>>(&v2),
            name                         : arg0,
            symbol                       : arg1,
            description                  : arg2,
            total_supply                 : arg3,
            icon_url                     : arg4,
            token_type                   : v2.token_type,
            created_at                   : v2.created_at,
            dao_end_at                   : v2.dao_end_at,
            fundraise_end_at             : v2.fundraise_end_at,
            price                        : v1,
            fundraise_goal               : arg5,
            phase                        : v2.phase,
            fundraise_status             : v2.fundraise_status,
            hurdle_rate_numerator        : 500,
            carried_interest_numerator   : 800,
            denominator                  : 10000,
            current_platform_fee         : 0x2::balance::value<0x2::sui::SUI>(&v2.platform_fee),
            current_carried_distribution : 0x2::balance::value<0x2::sui::SUI>(&v2.carried_distribution),
        };
        0x2::event::emit<DAOFundCreatedEvent>(v3);
        let v4 = PhaseChangedEvent{
            dao_fund_id : 0x2::object::id<DAOFund<T0>>(&v2),
            sender      : 0x2::tx_context::sender(arg9),
            phase       : 0x1::string::utf8(b"accepting"),
            created_at  : v0,
        };
        0x2::event::emit<PhaseChangedEvent>(v4);
        let v5 = AdminCap{
            id          : 0x2::object::new(arg9),
            dao_fund_id : 0x2::object::id<DAOFund<T0>>(&v2),
        };
        0x2::transfer::transfer<AdminCap>(v5, 0x2::tx_context::sender(arg9));
        0x2::transfer::share_object<DAOFund<T0>>(v2);
    }

    public(friend) fun get_price<T0>(arg0: &DAOFund<T0>) : u64 {
        arg0.price
    }

    public(friend) fun get_seed_balance<T0>(arg0: &mut DAOFund<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg0.fundraise_status == 0x1::string::utf8(b"succeed"), 1012);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.dao_end_at, 1013);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) - arg0.fundraise_goal)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedObj{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<SharedObj>(v0);
        let v1 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v1, 0x2::tx_context::sender(arg0));
        0x810f2397b61cca1bfcd2497159fcdd128a51bd7cc56f9119feae297735d11eba::dao_config::new_global_dao_fee_and_shared(arg0);
    }

    fun is_existed_user_dao<T0>(arg0: &DAOFund<T0>, arg1: address) : bool {
        0x2::table::contains<address, UserDAO>(&arg0.tracked_addresses, arg1)
    }

    public(friend) fun is_seeded<T0>(arg0: &DAOFund<T0>) : bool {
        arg0.is_seeded
    }

    public(friend) fun mint_dao_token<T0>(arg0: &mut DAOFund<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = TokenMintedEvent{
            token_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sender     : 0x2::tx_context::sender(arg3),
            amount     : arg1,
            minted_at  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenMintedEvent>(v0);
        0x2::coin::mint<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap), arg1, arg3)
    }

    public entry fun set_dao_fee<T0>(arg0: &OperatorCap, arg1: &mut DAOFund<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        arg1.hurdle_rate_numerator = arg2;
        arg1.carried_interest_numerator = arg3;
        let v0 = DaoFeeChangedEvent{
            sender                     : 0x2::tx_context::sender(arg4),
            hurdle_rate_numerator      : arg2,
            carried_interest_numerator : arg3,
            denominator                : 10000,
        };
        0x2::event::emit<DaoFeeChangedEvent>(v0);
    }

    public(friend) fun set_is_seeded<T0>(arg0: &mut DAOFund<T0>) {
        arg0.is_seeded = true;
    }

    public entry fun set_platform_fee(arg0: &OperatorCap, arg1: &mut 0x810f2397b61cca1bfcd2497159fcdd128a51bd7cc56f9119feae297735d11eba::dao_config::GlobalDaoFee, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x810f2397b61cca1bfcd2497159fcdd128a51bd7cc56f9119feae297735d11eba::dao_config::set_platform_fee(arg1, arg2, arg3, arg4);
    }

    public entry fun set_to_public_phase<T0>(arg0: &AdminCap, arg1: &mut DAOFund<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        validate_fundraise_time<T0>(arg1, arg2);
        assert!(arg1.phase == 0x1::string::utf8(b"vip_progress") || arg1.phase == 0x1::string::utf8(b"whitelist_progress"), 1002);
        arg1.phase = 0x1::string::utf8(b"public_progress");
        let v0 = PhaseChangedEvent{
            dao_fund_id : 0x2::object::uid_to_inner(&arg1.id),
            sender      : 0x2::tx_context::sender(arg3),
            phase       : 0x1::string::utf8(b"public_progress"),
            created_at  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PhaseChangedEvent>(v0);
    }

    public entry fun set_to_vip_phase<T0>(arg0: &AdminCap, arg1: &mut DAOFund<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        validate_fundraise_time<T0>(arg1, arg2);
        assert!(arg1.phase == 0x1::string::utf8(b"accepting"), 1002);
        arg1.phase = 0x1::string::utf8(b"vip_progress");
        let v0 = PhaseChangedEvent{
            dao_fund_id : 0x2::object::uid_to_inner(&arg1.id),
            sender      : 0x2::tx_context::sender(arg3),
            phase       : 0x1::string::utf8(b"vip_progress"),
            created_at  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PhaseChangedEvent>(v0);
    }

    public entry fun set_to_whitelist_phase<T0>(arg0: &AdminCap, arg1: &mut DAOFund<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        validate_fundraise_time<T0>(arg1, arg2);
        assert!(arg1.phase == 0x1::string::utf8(b"vip_progress"), 1002);
        arg1.phase = 0x1::string::utf8(b"whitelist_progress");
        let v0 = PhaseChangedEvent{
            dao_fund_id : 0x2::object::uid_to_inner(&arg1.id),
            sender      : 0x2::tx_context::sender(arg3),
            phase       : 0x1::string::utf8(b"whitelist_progress"),
            created_at  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PhaseChangedEvent>(v0);
    }

    fun validate_coin_type<T0>(arg0: &DAOFund<T0>) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == arg0.token_type, 1004);
    }

    fun validate_fundraise_time<T0>(arg0: &DAOFund<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.fundraise_end_at, 1003);
    }

    fun validate_phase<T0>(arg0: &DAOFund<T0>, arg1: address) {
        let v0 = arg0.phase;
        assert!(v0 != 0x1::string::utf8(b"accepting"), 1002);
        if (v0 == 0x1::string::utf8(b"vip_progress")) {
            assert!(is_existed_user_dao<T0>(arg0, arg1), 1001);
            assert!(0x2::table::borrow<address, UserDAO>(&arg0.tracked_addresses, arg1).dao_type == 0x1::string::utf8(b"vip"), 1002);
        } else if (v0 == 0x1::string::utf8(b"whitelist_progress")) {
            assert!(is_existed_user_dao<T0>(arg0, arg1), 1001);
            let v1 = 0x2::table::borrow<address, UserDAO>(&arg0.tracked_addresses, arg1);
            assert!(v1.dao_type == 0x1::string::utf8(b"vip") || v1.dao_type == 0x1::string::utf8(b"whitelist"), 1002);
        };
    }

    fun validate_withdraw_amount<T0>(arg0: &DAOFund<T0>, arg1: u64) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 1008);
    }

    public entry fun withdraw<T0>(arg0: &mut DAOFund<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        validate_coin_type<T0>(arg0);
        check_fund_withdrawable<T0>(arg0, arg3);
        validate_withdraw_amount<T0>(arg0, arg2);
        assert!(is_existed_user_dao<T0>(arg0, 0x2::tx_context::sender(arg4)), 1010);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = arg0.price * arg2;
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 1005);
        0x2::coin::burn<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap), 0x2::coin::split<T0>(&mut arg1, v1, arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        let v2 = TokenBurnedEvent{
            token_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sender     : 0x2::tx_context::sender(arg4),
            amount     : v1,
            burned_at  : v0,
        };
        0x2::event::emit<TokenBurnedEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg4), 0x2::tx_context::sender(arg4));
        let v3 = WithdrawnEvent{
            dao_fund_id  : 0x2::object::id<DAOFund<T0>>(arg0),
            sender       : 0x2::tx_context::sender(arg4),
            amount       : arg2,
            withdrawn_at : v0,
        };
        0x2::event::emit<WithdrawnEvent>(v3);
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

    // decompiled from Move bytecode v6
}

