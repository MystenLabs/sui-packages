module 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::campaign {
    struct CampaignCreatedEvent has copy, drop {
        campaign_id: 0x2::object::ID,
    }

    struct CampaignClosedEvent has copy, drop {
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

    struct RewardsClaimedEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        investor: address,
        amount: u64,
        refunded: u64,
    }

    struct InvestmentClaimedEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        amount: u64,
    }

    struct ApplyForWhitelistEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        project_id: 0x1::string::String,
    }

    struct Campaign<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        project_id: 0x1::string::String,
        whitelist_start: u64,
        sale_start: u64,
        distribution_start: u64,
        investors_count: u64,
        vault: 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::vault::Vault<T0, T1>,
        allocations: vector<u64>,
        funded: bool,
        requests: 0x2::table::Table<address, bool>,
    }

    public entry fun add_bulk_to_whitelist<T0, T1>(arg0: &0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::launchpad::Launchpad, arg1: &mut Campaign<T0, T1>, arg2: vector<address>) {
        0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::whitelist::add_to_whitelist(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::whitelist::Whitelist>(&mut arg1.id, b"whitelist"), arg2);
    }

    public entry fun add_to_whitelist<T0, T1>(arg0: &0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::launchpad::Launchpad, arg1: &mut Campaign<T0, T1>, arg2: address) {
        0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::whitelist::add_investor(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::whitelist::Whitelist>(&mut arg1.id, b"whitelist"), arg2);
    }

    public entry fun apply_for_whitelist<T0, T1>(arg0: &mut Campaign<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_whitelist_phase<T0, T1>(arg0, arg1), 3);
        assert!(arg0.funded, 11);
        assert!(!0x2::table::contains<address, bool>(&arg0.requests, 0x2::tx_context::sender(arg2)), 6);
        0x2::table::add<address, bool>(&mut arg0.requests, 0x2::tx_context::sender(arg2), true);
        let v0 = ApplyForWhitelistEvent{
            campaign_id : get_id<T0, T1>(arg0),
            project_id  : arg0.project_id,
        };
        0x2::event::emit<ApplyForWhitelistEvent>(v0);
    }

    public entry fun claim_investment<T0, T1>(arg0: &mut Campaign<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_distribution_phase<T0, T1>(arg0, arg1), 5);
        0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::vault::claim_investment<T0, T1>(&mut arg0.vault, arg2);
    }

    public entry fun claim_rewards<T0, T1>(arg0: &mut Campaign<T0, T1>, arg1: &mut 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::vault::InvestCertificate, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_distribution_phase<T0, T1>(arg0, arg2), 5);
        assert!(get_id<T0, T1>(arg0) == 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::vault::get_certificate_campaign_id(arg1), 1);
        0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::vault::claim<T0, T1>(arg1, &mut arg0.vault, arg2, arg3);
    }

    public entry fun create_campaign<T0, T1>(arg0: &mut 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::launchpad::Launchpad, arg1: 0x1::string::String, arg2: vector<u64>, arg3: vector<u64>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 14);
        let v0 = 0x2::object::new(arg10);
        let v1 = 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::vault::create<T0, T1>(0x2::object::uid_to_inner(&v0), arg2, arg3, arg7, arg6, arg8, arg9, arg10);
        assert!(0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::vault::get_token_price<T0, T1>(&v1) > 0, 12);
        let v2 = Campaign<T0, T1>{
            id                 : v0,
            project_id         : arg1,
            whitelist_start    : arg4,
            sale_start         : arg5,
            distribution_start : arg6,
            investors_count    : 0,
            vault              : v1,
            allocations        : 0x1::vector::empty<u64>(),
            funded             : false,
            requests           : 0x2::table::new<address, bool>(arg10),
        };
        let v3 = CampaignCreatedEvent{campaign_id: get_id<T0, T1>(&v2)};
        0x2::event::emit<CampaignCreatedEvent>(v3);
        0x2::dynamic_object_field::add<vector<u8>, 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::whitelist::Whitelist>(&mut v2.id, b"whitelist", 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::whitelist::new(arg10));
        0x2::transfer::public_share_object<Campaign<T0, T1>>(v2);
    }

    public entry fun fund<T0, T1>(arg0: &mut Campaign<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.funded, 10);
        arg0.funded = true;
        0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::vault::fund<T0, T1>(&mut arg0.vault, get_coin_from_vec<T1>(arg1, 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::vault::get_tokens_total_rewards_amount<T0, T1>(&arg0.vault), arg2));
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

    public entry fun invest<T0, T1>(arg0: &mut Campaign<T0, T1>, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::vault::get_token_price<T0, T1>(&arg0.vault);
        let v1 = (((arg1 as u128) * 10000000 / v0 * v0 / 10000000) as u64);
        assert!(v1 > 0, 13);
        assert!(is_sale_phase<T0, T1>(arg0, arg3), 4);
        assert!(v1 <= *0x1::vector::borrow<u64>(&arg0.allocations, 0), 8);
        let v2 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::whitelist::Whitelist>(&mut arg0.id, b"whitelist");
        assert!(0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::whitelist::can_invest(v2, 0x2::tx_context::sender(arg4)), 2);
        0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::whitelist::investor_invested(v2, 0x2::tx_context::sender(arg4));
        let v3 = get_coin_from_vec<T0>(arg2, v1, arg4);
        0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::vault::mint_investment_certificate<T0, T1>(&mut arg0.vault, 0x2::object::uid_to_inner(&arg0.id), v3, false, arg4);
        arg0.investors_count = arg0.investors_count + 1;
        let v4 = InvestedInCampaignEvent{
            campaign_id : get_id<T0, T1>(arg0),
            investor    : 0x2::tx_context::sender(arg4),
            amount      : v1,
        };
        0x2::event::emit<InvestedInCampaignEvent>(v4);
    }

    fun is_distribution_phase<T0, T1>(arg0: &Campaign<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        arg0.distribution_start < 0x2::clock::timestamp_ms(arg1)
    }

    fun is_sale_phase<T0, T1>(arg0: &Campaign<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        arg0.sale_start < 0x2::clock::timestamp_ms(arg1) && arg0.distribution_start > 0x2::clock::timestamp_ms(arg1)
    }

    fun is_whitelist_phase<T0, T1>(arg0: &Campaign<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        arg0.whitelist_start < 0x2::clock::timestamp_ms(arg1) && arg0.sale_start - 8640000 > 0x2::clock::timestamp_ms(arg1)
    }

    public entry fun set_allocations<T0, T1>(arg0: &0xea10b3c9a65427fe13194413ef9844e61acd5636ea8b007c142991f65b0aaf67::launchpad::Launchpad, arg1: &mut Campaign<T0, T1>, arg2: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 1, 9);
        arg1.allocations = arg2;
    }

    // decompiled from Move bytecode v6
}

