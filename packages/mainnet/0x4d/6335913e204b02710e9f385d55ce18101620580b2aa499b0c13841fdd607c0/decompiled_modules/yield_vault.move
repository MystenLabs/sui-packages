module 0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::yield_vault {
    struct YIELD_VAULT has drop {
        dummy_field: bool,
    }

    struct YieldVault has key {
        id: 0x2::object::UID,
        governance_registry_id: 0x2::object::ID,
        oracle_registry_id: 0x2::object::ID,
        ausd_pool: 0x2::balance::Balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>,
        sausd_pool: 0x2::balance::Balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>,
        total_ausd_staked: u64,
        total_ausd_redeemed: u64,
        total_sausd_distributed: u64,
        redeem_requests: 0x2::table::Table<0x2::object::ID, RedeemRequest>,
        user_request_ids: 0x2::table::Table<address, vector<0x2::object::ID>>,
        next_request_id: u64,
        is_paused: bool,
    }

    struct RedeemRequest has copy, store {
        id: 0x2::object::ID,
        user: address,
        sausd_amount: u64,
        ausd_amount: u64,
        sausd_price: u64,
        created_at: u64,
        is_claimed: bool,
    }

    struct StakeEvent has copy, drop {
        user: address,
        ausd_amount: u64,
        sausd_amount: u64,
        sausd_price: u64,
    }

    struct RedeemRequestEvent has copy, drop {
        user: address,
        request_id: 0x2::object::ID,
        sausd_amount: u64,
        ausd_amount: u64,
        sausd_price: u64,
        unlock_time: u64,
    }

    struct ClaimEvent has copy, drop {
        user: address,
        request_id: 0x2::object::ID,
        ausd_amount: u64,
    }

    struct PauseEvent has copy, drop {
        is_paused: bool,
    }

    struct DepositEvent has copy, drop {
        coin_type: u8,
        coin_amount: u64,
    }

    fun calculate_ausd_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 1000000
    }

    fun calculate_pool_total_value(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 1000000
    }

    fun calculate_sausd_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 4);
        arg0 * 1000000 / arg1
    }

    entry fun claim(arg0: &mut YieldVault, arg1: &0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::GovernanceRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        verify_vault_governance_association(arg0, arg1);
        assert!(!0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::is_governance_paused(arg1) && !arg0.is_paused, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<0x2::object::ID, RedeemRequest>(&arg0.redeem_requests, arg2), 10);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, RedeemRequest>(&mut arg0.redeem_requests, arg2);
        assert!(v1.user == v0, 9);
        assert!(!v1.is_claimed, 7);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.created_at + 604800000, 6);
        v1.is_claimed = true;
        let v2 = v1.ausd_amount;
        assert!(0x2::balance::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&arg0.ausd_pool) >= v2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>>(0x2::coin::from_balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(0x2::balance::split<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&mut arg0.ausd_pool, v2), arg4), v0);
        arg0.total_ausd_redeemed = arg0.total_ausd_redeemed + v2;
        let v3 = ClaimEvent{
            user        : v0,
            request_id  : arg2,
            ausd_amount : v2,
        };
        0x2::event::emit<ClaimEvent>(v3);
        let RedeemRequest {
            id           : _,
            user         : v5,
            sausd_amount : _,
            ausd_amount  : _,
            sausd_price  : _,
            created_at   : _,
            is_claimed   : _,
        } = 0x2::table::remove<0x2::object::ID, RedeemRequest>(&mut arg0.redeem_requests, arg2);
        let v11 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_request_ids, v5);
        let (v12, v13) = 0x1::vector::index_of<0x2::object::ID>(v11, &arg2);
        if (v12) {
            0x1::vector::remove<0x2::object::ID>(v11, v13);
        };
    }

    public fun deposit_ausd(arg0: &mut YieldVault, arg1: &0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::GovernanceRegistry, arg2: 0x2::coin::Coin<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>, arg3: &0x2::tx_context::TxContext) {
        verify_vault_governance_association(arg0, arg1);
        assert!(0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::is_admin(arg1, 0x2::tx_context::sender(arg3)), 3);
        let v0 = 0x2::coin::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&arg2);
        assert!(v0 > 0, 3);
        0x2::balance::join<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&mut arg0.ausd_pool, 0x2::coin::into_balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(arg2));
        let v1 = DepositEvent{
            coin_type   : 1,
            coin_amount : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun deposit_sausd(arg0: &mut YieldVault, arg1: &0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::GovernanceRegistry, arg2: 0x2::coin::Coin<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>, arg3: &0x2::tx_context::TxContext) {
        verify_vault_governance_association(arg0, arg1);
        assert!(0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::is_admin(arg1, 0x2::tx_context::sender(arg3)), 3);
        let v0 = 0x2::coin::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>(&arg2);
        assert!(v0 > 0, 3);
        0x2::balance::join<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>(&mut arg0.sausd_pool, 0x2::coin::into_balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>(arg2));
        let v1 = DepositEvent{
            coin_type   : 2,
            coin_amount : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun get_pool_total_value(arg0: &YieldVault, arg1: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry, arg2: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) : u64 {
        calculate_pool_total_value(get_sausd_price_from_oracle(arg0, arg1, arg2, arg3, arg4, arg5), arg0.total_sausd_distributed)
    }

    public fun get_redeem_request(arg0: &YieldVault, arg1: 0x2::object::ID) : (address, u64, u64, u64, u64, bool) {
        assert!(0x2::table::contains<0x2::object::ID, RedeemRequest>(&arg0.redeem_requests, arg1), 5);
        let v0 = 0x2::table::borrow<0x2::object::ID, RedeemRequest>(&arg0.redeem_requests, arg1);
        (v0.user, v0.sausd_amount, v0.ausd_amount, v0.sausd_price, v0.created_at, v0.is_claimed)
    }

    public fun get_sausd_price(arg0: &YieldVault, arg1: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry, arg2: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) : u64 {
        get_sausd_price_from_oracle(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun get_sausd_price_from_oracle(arg0: &YieldVault, arg1: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry, arg2: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) : u64 {
        verify_oracle_provider(arg0, arg1, arg2);
        0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::get_asset_price(arg2, 0x1::string::utf8(b"saUSD"), arg3, arg4, arg5) / 100
    }

    public fun get_user_redeem_requests(arg0: &YieldVault, arg1: address) : vector<RedeemRequest> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_request_ids, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_request_ids, arg1);
            let v2 = 0x1::vector::empty<RedeemRequest>();
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x2::object::ID>(v1)) {
                let v4 = *0x1::vector::borrow<0x2::object::ID>(v1, v3);
                if (0x2::table::contains<0x2::object::ID, RedeemRequest>(&arg0.redeem_requests, v4)) {
                    0x1::vector::push_back<RedeemRequest>(&mut v2, *0x2::table::borrow<0x2::object::ID, RedeemRequest>(&arg0.redeem_requests, v4));
                };
                v3 = v3 + 1;
            };
            v2
        } else {
            0x1::vector::empty<RedeemRequest>()
        }
    }

    public fun get_vault_details(arg0: &YieldVault) : (0x2::object::ID, 0x2::object::ID, u64, u64, u64, u64, u64, bool) {
        (arg0.governance_registry_id, arg0.oracle_registry_id, 0x2::balance::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&arg0.ausd_pool), 0x2::balance::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>(&arg0.sausd_pool), arg0.total_ausd_staked, arg0.total_ausd_redeemed, arg0.total_sausd_distributed, arg0.is_paused)
    }

    fun init(arg0: YIELD_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_yield_vault(arg0: &0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::GovernanceRegistry, arg1: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::is_admin(arg0, 0x2::tx_context::sender(arg2)), 3);
        let v0 = YieldVault{
            id                      : 0x2::object::new(arg2),
            governance_registry_id  : 0x2::object::id<0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::GovernanceRegistry>(arg0),
            oracle_registry_id      : 0x2::object::id<0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry>(arg1),
            ausd_pool               : 0x2::balance::zero<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(),
            sausd_pool              : 0x2::balance::zero<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>(),
            total_ausd_staked       : 0,
            total_ausd_redeemed     : 0,
            total_sausd_distributed : 0,
            redeem_requests         : 0x2::table::new<0x2::object::ID, RedeemRequest>(arg2),
            user_request_ids        : 0x2::table::new<address, vector<0x2::object::ID>>(arg2),
            next_request_id         : 0,
            is_paused               : false,
        };
        0x2::transfer::share_object<YieldVault>(v0);
    }

    entry fun redeem(arg0: &mut YieldVault, arg1: &0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::GovernanceRegistry, arg2: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry, arg3: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider, arg4: 0x2::coin::Coin<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>, arg5: u64, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        verify_vault_governance_association(arg0, arg1);
        assert!(!0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::is_governance_paused(arg1) && !arg0.is_paused, 1);
        let v0 = 0x2::coin::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>(&arg4);
        assert!(v0 > 0, 3);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = get_sausd_price_from_oracle(arg0, arg2, arg3, arg6, arg7, arg8);
        let v3 = calculate_ausd_amount(v0, v2);
        assert!(v3 >= arg5, 15);
        assert!(0x2::balance::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&arg0.ausd_pool) >= v3, 2);
        0x2::balance::join<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>(&mut arg0.sausd_pool, 0x2::coin::into_balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>(arg4));
        let v4 = 0x2::clock::timestamp_ms(arg8);
        let v5 = arg0.next_request_id;
        arg0.next_request_id = arg0.next_request_id + 1;
        let v6 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v6, 0x2::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v6, 0x2::bcs::to_bytes<u64>(&v5));
        let v7 = 0x2::object::id_from_bytes(0x2::hash::keccak256(&v6));
        let v8 = RedeemRequest{
            id           : v7,
            user         : v1,
            sausd_amount : v0,
            ausd_amount  : v3,
            sausd_price  : v2,
            created_at   : v4,
            is_claimed   : false,
        };
        0x2::table::add<0x2::object::ID, RedeemRequest>(&mut arg0.redeem_requests, v7, v8);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_request_ids, v1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.user_request_ids, v1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_request_ids, v1), v7);
        arg0.total_sausd_distributed = arg0.total_sausd_distributed - v0;
        let v9 = RedeemRequestEvent{
            user         : v1,
            request_id   : v7,
            sausd_amount : v0,
            ausd_amount  : v3,
            sausd_price  : v2,
            unlock_time  : v4 + 604800000,
        };
        0x2::event::emit<RedeemRequestEvent>(v9);
    }

    public fun set_pause(arg0: &mut YieldVault, arg1: &0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::GovernanceRegistry, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        verify_vault_governance_association(arg0, arg1);
        assert!(0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::is_admin(arg1, 0x2::tx_context::sender(arg3)), 3);
        if (arg0.is_paused == arg2) {
            return
        };
        arg0.is_paused = arg2;
        let v0 = PauseEvent{is_paused: arg2};
        0x2::event::emit<PauseEvent>(v0);
    }

    entry fun stake(arg0: &mut YieldVault, arg1: &0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::GovernanceRegistry, arg2: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry, arg3: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider, arg4: 0x2::coin::Coin<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>, arg5: u64, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        verify_vault_governance_association(arg0, arg1);
        assert!(!0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::is_governance_paused(arg1) && !arg0.is_paused, 1);
        let v0 = 0x2::coin::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&arg4);
        assert!(v0 > 0, 3);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = get_sausd_price_from_oracle(arg0, arg2, arg3, arg6, arg7, arg8);
        let v3 = calculate_sausd_amount(v0, v2);
        assert!(v3 >= arg5, 15);
        assert!(0x2::balance::value<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>(&arg0.sausd_pool) >= v3, 2);
        0x2::balance::join<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(&mut arg0.ausd_pool, 0x2::coin::into_balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd::AUSD>(arg4));
        arg0.total_ausd_staked = arg0.total_ausd_staked + v0;
        arg0.total_sausd_distributed = arg0.total_sausd_distributed + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>>(0x2::coin::from_balance<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>(0x2::balance::split<0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd::SAUSD>(&mut arg0.sausd_pool, v3), arg9), v1);
        let v4 = StakeEvent{
            user         : v1,
            ausd_amount  : v0,
            sausd_amount : v3,
            sausd_price  : v2,
        };
        0x2::event::emit<StakeEvent>(v4);
    }

    fun verify_oracle_provider(arg0: &YieldVault, arg1: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry, arg2: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider) {
        verify_oracle_registry(arg0, arg1);
        assert!(0x2::object::id<0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider::OracleProvider>(arg2) == 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::get_current_provider_id(arg1), 18);
    }

    fun verify_oracle_registry(arg0: &YieldVault, arg1: &0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry) {
        assert!(arg0.oracle_registry_id == 0x2::object::id<0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_registry::OracleRegistry>(arg1), 17);
    }

    fun verify_vault_governance_association(arg0: &YieldVault, arg1: &0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::GovernanceRegistry) {
        assert!(arg0.governance_registry_id == 0x2::object::id<0x4d6335913e204b02710e9f385d55ce18101620580b2aa499b0c13841fdd607c0::vault_governance::GovernanceRegistry>(arg1), 8);
    }

    // decompiled from Move bytecode v6
}

