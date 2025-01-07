module 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::campaign {
    struct CampaignCreatedEvent has copy, drop {
        campaign_id: 0x2::object::ID,
    }

    struct CampaignFundedEvent has copy, drop {
        campaign_id: 0x2::object::ID,
    }

    struct InvestedInCampaignEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        investor: address,
        amount: u64,
    }

    struct InvestedInSecondSaleCampaignEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        investor: address,
        amount: u64,
    }

    struct ApplyForWhitelistEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        project_id: 0x1::string::String,
    }

    struct SetAllocationsEvent has copy, drop {
        campaign_id: 0x2::object::ID,
    }

    struct Campaign<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        project_id: 0x1::string::String,
        whitelist_start: u64,
        sale_start: u64,
        distribution_start: u64,
        investors_count: u64,
        vault: 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::Vault<T0, T1>,
        allocations: vector<u64>,
        funded: bool,
        requests: 0x2::table::Table<address, bool>,
    }

    public entry fun add_bulk_to_whitelist<T0, T1>(arg0: &0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::launchpad::Launchpad, arg1: &mut Campaign<T0, T1>, arg2: vector<address>) {
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::whitelist::add_to_whitelist(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::whitelist::Whitelist>(&mut arg1.id, b"whitelist"), arg2);
    }

    public entry fun add_to_whitelist<T0, T1>(arg0: &0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::launchpad::Launchpad, arg1: &mut Campaign<T0, T1>, arg2: address) {
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::whitelist::add_investor(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::whitelist::Whitelist>(&mut arg1.id, b"whitelist"), arg2);
    }

    public entry fun apply_for_whitelist<T0, T1>(arg0: &mut Campaign<T0, T1>, arg1: &0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::staking::StakingLock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_whitelist_phase<T0, T1>(arg0, arg2), 3);
        assert!(arg0.funded, 11);
        assert!(!0x2::table::contains<address, bool>(&arg0.requests, 0x2::tx_context::sender(arg3)), 6);
        0x2::table::add<address, bool>(&mut arg0.requests, 0x2::tx_context::sender(arg3), true);
        let v0 = ApplyForWhitelistEvent{
            campaign_id : get_id<T0, T1>(arg0),
            project_id  : arg0.project_id,
        };
        0x2::event::emit<ApplyForWhitelistEvent>(v0);
    }

    public entry fun claim_insurance<T0, T1>(arg0: &mut 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::insurance::Fund<T0>, arg1: &0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::insurance::CampaignRefundAllowance, arg2: &mut 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::InvestCertificate, arg3: &Campaign<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(get_id<T0, T1>(arg3) == 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::get_certificate_campaign_id(arg2), 1);
        assert!(0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::is_insured(arg2), 14);
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::insurance::claim_refund<T0, T0, T1>(arg0, arg1, arg2, &arg3.vault, arg4);
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::insurance_claimed(arg2);
    }

    public entry fun claim_investment<T0, T1>(arg0: &mut Campaign<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_distribution_phase<T0, T1>(arg0, arg1), 5);
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::claim_investment<T0, T1>(&mut arg0.vault, arg2);
    }

    public entry fun claim_rewards<T0, T1>(arg0: &mut Campaign<T0, T1>, arg1: &mut 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::InvestCertificate, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_distribution_phase<T0, T1>(arg0, arg2), 5);
        assert!(get_id<T0, T1>(arg0) == 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::get_certificate_campaign_id(arg1), 1);
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::claim<T0, T1>(arg1, &mut arg0.vault, arg2, arg3);
    }

    public entry fun create_campaign<T0, T1>(arg0: &mut 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::launchpad::Launchpad, arg1: 0x1::string::String, arg2: vector<u64>, arg3: vector<u64>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg3, v1);
            v1 = v1 + 1;
        };
        assert!(v0 == 100, 16);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 15);
        let v2 = 0x2::object::new(arg10);
        let v3 = 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::create<T0, T1>(0x2::object::uid_to_inner(&v2), arg2, arg3, arg7, arg6, arg8, arg9, arg10);
        assert!(0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::get_token_price<T0, T1>(&v3) > 0, 12);
        let v4 = Campaign<T0, T1>{
            id                 : v2,
            project_id         : arg1,
            whitelist_start    : arg4,
            sale_start         : arg5,
            distribution_start : arg6,
            investors_count    : 0,
            vault              : v3,
            allocations        : 0x1::vector::empty<u64>(),
            funded             : false,
            requests           : 0x2::table::new<address, bool>(arg10),
        };
        let v5 = CampaignCreatedEvent{campaign_id: get_id<T0, T1>(&v4)};
        0x2::event::emit<CampaignCreatedEvent>(v5);
        0x2::dynamic_object_field::add<vector<u8>, 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::whitelist::Whitelist>(&mut v4.id, b"whitelist", 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::whitelist::new(arg10));
        0x2::dynamic_object_field::add<vector<u8>, 0x2::table::Table<address, bool>>(&mut v4.id, b"second_sale", 0x2::table::new<address, bool>(arg10));
        0x2::transfer::public_share_object<Campaign<T0, T1>>(v4);
    }

    public entry fun fund<T0, T1>(arg0: &mut Campaign<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.funded, 10);
        arg0.funded = true;
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::fund<T0, T1>(&mut arg0.vault, get_coin_from_vec<T1>(arg1, 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::get_tokens_total_rewards_amount<T0, T1>(&arg0.vault), arg2));
        let v0 = CampaignFundedEvent{campaign_id: get_id<T0, T1>(arg0)};
        0x2::event::emit<CampaignFundedEvent>(v0);
    }

    fun get_coin_from_vec<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 7);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        0x2::coin::split<T0>(&mut v0, arg1, arg2)
    }

    fun get_id<T0, T1>(arg0: &Campaign<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public entry fun invest<T0, T1>(arg0: &mut Campaign<T0, T1>, arg1: &0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::staking::StakingPool, arg2: &mut 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::staking::StakingLock, arg3: u64, arg4: vector<0x2::coin::Coin<T0>>, arg5: bool, arg6: &mut 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::insurance::Fund<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = (((arg3 as u128) - (arg3 as u128) * 10000000 % 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::get_token_price<T0, T1>(&arg0.vault)) as u64);
        assert!(v0 > 0, 13);
        assert!(is_sale_phase<T0, T1>(arg0, arg7), 4);
        assert!(v0 <= *0x1::vector::borrow<u64>(&arg0.allocations, 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::staking::get_tier_level(arg2, arg1, arg7)), 8);
        let v1 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::whitelist::Whitelist>(&mut arg0.id, b"whitelist");
        assert!(0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::whitelist::can_invest(v1, 0x2::tx_context::sender(arg8)), 2);
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::whitelist::investor_invested(v1, 0x2::tx_context::sender(arg8));
        let v2 = if (arg5) {
            v0 * 15 / 100
        } else {
            0
        };
        let v3 = get_coin_from_vec<T0>(arg4, v0 + v2, arg8);
        if (arg5) {
            0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::insurance::insure_campaign<T0>(arg6, get_id<T0, T1>(arg0), 0x2::coin::split<T0>(&mut v3, v2, arg8), arg8);
        };
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::mint_investment_certificate<T0, T1>(&mut arg0.vault, 0x2::object::uid_to_inner(&arg0.id), v3, arg5, arg8);
        arg0.investors_count = arg0.investors_count + 1;
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::staking::update_last_distribution_timestamp(arg2, arg0.distribution_start);
        let v4 = InvestedInCampaignEvent{
            campaign_id : get_id<T0, T1>(arg0),
            investor    : 0x2::tx_context::sender(arg8),
            amount      : v0,
        };
        0x2::event::emit<InvestedInCampaignEvent>(v4);
    }

    fun is_distribution_phase<T0, T1>(arg0: &Campaign<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        arg0.distribution_start < 0x2::clock::timestamp_ms(arg1)
    }

    fun is_sale_phase<T0, T1>(arg0: &Campaign<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        arg0.sale_start < 0x2::clock::timestamp_ms(arg1) && arg0.sale_start + 300000 > 0x2::clock::timestamp_ms(arg1)
    }

    fun is_second_sale_phase<T0, T1>(arg0: &Campaign<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        arg0.sale_start + 300000 < 0x2::clock::timestamp_ms(arg1) && arg0.distribution_start > 0x2::clock::timestamp_ms(arg1)
    }

    fun is_whitelist_phase<T0, T1>(arg0: &Campaign<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        arg0.whitelist_start < 0x2::clock::timestamp_ms(arg1) && arg0.sale_start - 60000 > 0x2::clock::timestamp_ms(arg1)
    }

    public entry fun second_sale_invest<T0, T1>(arg0: &mut Campaign<T0, T1>, arg1: &0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::staking::StakingPool, arg2: u64, arg3: vector<0x2::coin::Coin<T0>>, arg4: bool, arg5: &mut 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::insurance::Fund<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_second_sale_phase<T0, T1>(arg0, arg6), 4);
        let v0 = (((arg2 as u128) - (arg2 as u128) * 10000000 % 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::get_token_price<T0, T1>(&arg0.vault)) as u64);
        let v1 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::whitelist::Whitelist>(&mut arg0.id, b"whitelist");
        assert!(v0 > 0, 13);
        assert!(v0 <= *0x1::vector::borrow<u64>(&arg0.allocations, 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::staking::get_tier_levels_count(arg1)), 8);
        assert!(0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::whitelist::can_invest_second_sale(v1, 0x2::tx_context::sender(arg7)), 17);
        let v2 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<address, bool>>(&mut arg0.id, b"second_sale");
        assert!(!0x2::table::contains<address, bool>(v2, 0x2::tx_context::sender(arg7)), 17);
        0x2::table::add<address, bool>(v2, 0x2::tx_context::sender(arg7), true);
        let v3 = if (arg4) {
            v0 * 15 / 100
        } else {
            0
        };
        let v4 = get_coin_from_vec<T0>(arg3, v0 + v3, arg7);
        if (arg4) {
            0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::insurance::insure_campaign<T0>(arg5, get_id<T0, T1>(arg0), 0x2::coin::split<T0>(&mut v4, v3, arg7), arg7);
        };
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::mint_investment_certificate<T0, T1>(&mut arg0.vault, 0x2::object::uid_to_inner(&arg0.id), v4, arg4, arg7);
        arg0.investors_count = arg0.investors_count + 1;
        let v5 = InvestedInSecondSaleCampaignEvent{
            campaign_id : get_id<T0, T1>(arg0),
            investor    : 0x2::tx_context::sender(arg7),
            amount      : v0,
        };
        0x2::event::emit<InvestedInSecondSaleCampaignEvent>(v5);
    }

    public entry fun set_allocations<T0, T1>(arg0: &0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::launchpad::Launchpad, arg1: &mut Campaign<T0, T1>, arg2: &0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::staking::StakingPool, arg3: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg3) == 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::staking::get_tier_levels_count(arg2) + 1, 9);
        arg1.allocations = arg3;
        let v0 = SetAllocationsEvent{campaign_id: 0x2::object::uid_to_inner(&arg1.id)};
        0x2::event::emit<SetAllocationsEvent>(v0);
    }

    public entry fun set_distribution_start<T0, T1>(arg0: &0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::launchpad::Launchpad, arg1: &mut Campaign<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.distribution_start > 0x2::clock::timestamp_ms(arg3), 18);
        arg1.distribution_start = arg2;
        0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::vault::set_distribution_time<T0, T1>(&mut arg1.vault, arg2);
    }

    // decompiled from Move bytecode v6
}

