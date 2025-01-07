module 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::campaign {
    struct CampaignFundEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        amount: u64,
        wallet: address,
        is_insured: bool,
        is_private_to_public: bool,
    }

    struct CampaignEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        hard_cap: u64,
        only_whitelist: bool,
        change_to_public: bool,
        scheduled_times: vector<u64>,
        scheduled_rewards: vector<u64>,
        investors: u64,
        investor_amounts: u64,
        price: u64,
        start_time: u64,
        end_time: u64,
        min_amount: u64,
        max_amount: u64,
        sender: address,
        owner: address,
    }

    struct CampaignClaimEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        member: address,
        claim_amount: u64,
        return_amount: u64,
        valid_amount: u64,
        timestamp_ms: u64,
    }

    struct CampaignRefundClaimEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        wallet: address,
        valid_amount: u64,
        amount: u64,
        timestamp_ms: u64,
    }

    struct Member has store {
        wallet: address,
        amount: u64,
        valid_amount: u64,
        return_amount: u64,
        claimed: u64,
        is_claimed: bool,
        is_refunded: bool,
        is_private: bool,
        is_insured: bool,
        is_claimed_insurance: bool,
    }

    struct Campaign<phantom T0> has store, key {
        id: 0x2::object::UID,
        hard_cap: u64,
        only_whitelist: bool,
        change_to_public: bool,
        scheduled_times: vector<u64>,
        scheduled_rewards: vector<u64>,
        investors: u64,
        investor_amounts: u64,
        price: u64,
        start_time: u64,
        end_time: u64,
        min_amount: u64,
        max_amount: u64,
        total_deposit: u256,
        balance: 0x2::balance::Balance<T0>,
        members: 0x2::bag::Bag,
        white_list: 0x2::bag::Bag,
        owner: address,
        funded: bool,
        public_sell_days: u64,
    }

    public entry fun add_whitelist<T0>(arg0: &0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::admin::AdminCap, arg1: &mut Campaign<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 1004);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::bag::contains<address>(&arg1.white_list, v1)) {
                *0x2::bag::borrow_mut<address, u64>(&mut arg1.white_list, v1) = 0x1::vector::pop_back<u64>(&mut arg3);
            } else {
                0x2::bag::add<address, u64>(&mut arg1.white_list, v1, 0x1::vector::pop_back<u64>(&mut arg3));
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    fun caculate_claimable_amount(arg0: u64, arg1: u64, arg2: u256, arg3: u64, arg4: u64) : u64 {
        (((arg1 as u256) * (arg4 as u256) / (1000000000 as u256)) as u64)
    }

    fun caculate_claimable_amount_when_hardcap_is_reached(arg0: u64, arg1: u64, arg2: u256, arg3: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / (1000000000 as u256) / arg2 / (arg3 as u256)) as u64)
    }

    public entry fun claim<T0, T1>(arg0: &mut Campaign<T0>, arg1: &mut 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::vault::Vault<T1>, arg2: &mut 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::vesuip::Supply, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::bag::contains<address>(&arg0.members, v0), 1010);
        let v1 = 0x2::object::id<Campaign<T0>>(arg0);
        let v2 = 0x2::bag::borrow_mut<address, Member>(&mut arg0.members, v0);
        assert!(v2.is_claimed == false, 1013);
        if (arg0.only_whitelist && v2.is_private) {
            assert!(arg0.end_time + arg0.public_sell_days * 86400000 < 0x2::clock::timestamp_ms(arg3), 1011);
        } else {
            assert!(arg0.end_time < 0x2::clock::timestamp_ms(arg3), 1011);
        };
        let v3 = arg0.total_deposit;
        0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::vesuip::mint_and_transfer(arg2, 10, arg4);
        if (v3 > (arg0.hard_cap as u256)) {
            let v4 = caculate_claimable_amount_when_hardcap_is_reached(arg0.hard_cap, arg0.price, v3, v2.amount);
            let v5 = claulate_return_amout_when_hardcap_is_reached(arg0.hard_cap, arg0.price, v3, v2.amount);
            v2.is_claimed = true;
            v2.claimed = v4;
            v2.return_amount = v5;
            v2.valid_amount = v2.amount - v5;
            let v6 = CampaignClaimEvent{
                campaign_id   : v1,
                member        : v0,
                claim_amount  : v4,
                return_amount : v5,
                valid_amount  : v2.valid_amount,
                timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<CampaignClaimEvent>(v6);
            0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::lock::new<T1>(v1, arg0.scheduled_times, arg0.scheduled_rewards, 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::vault::claim<T1>(arg1, v1, v4, arg4), 0x2::clock::timestamp_ms(arg3), arg3, arg4);
        } else {
            let v7 = caculate_claimable_amount(arg0.hard_cap, arg0.price, v3, arg0.investors, v2.amount);
            v2.is_claimed = true;
            v2.claimed = v7;
            v2.return_amount = 0;
            v2.valid_amount = v2.amount;
            let v8 = CampaignClaimEvent{
                campaign_id   : v1,
                member        : v0,
                claim_amount  : v7,
                return_amount : v2.return_amount,
                valid_amount  : v2.valid_amount,
                timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<CampaignClaimEvent>(v8);
            0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::lock::new<T1>(v1, arg0.scheduled_times, arg0.scheduled_rewards, 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::vault::claim<T1>(arg1, v1, v7, arg4), 0x2::clock::timestamp_ms(arg3), arg3, arg4);
        };
    }

    public entry fun claim_insurance<T0>(arg0: &mut Campaign<T0>, arg1: &mut 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::Fund<T0>, arg2: &0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::CampaignRefundAllowance, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::object::id<Campaign<T0>>(arg0) == 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::campaign_id(arg2), 1010);
        assert!(arg0.end_time + 7 * 86400000 >= 0x2::clock::timestamp_ms(arg3), 1011);
        assert!(0x2::bag::contains<address>(&arg0.members, v0), 1010);
        let v1 = 0x2::bag::borrow_mut<address, Member>(&mut arg0.members, v0);
        assert!(v1.is_claimed == true, 1014);
        assert!(v1.is_insured == true, 1007);
        assert!(v1.is_claimed_insurance == false, 1015);
        0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::claim_refund<T0>(arg1, arg2, v1.valid_amount, v1.claimed, arg4);
        v1.is_claimed_insurance = true;
    }

    fun claulate_return_amout_when_hardcap_is_reached(arg0: u64, arg1: u64, arg2: u256, arg3: u64) : u64 {
        arg3 - (((caculate_claimable_amount_when_hardcap_is_reached(arg0, arg1, arg2, arg3) as u256) * (1000000000 as u256) / (arg1 as u256)) as u64)
    }

    public entry fun create<T0>(arg0: &0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::admin::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: vector<u64>, arg9: vector<u64>, arg10: bool, arg11: u64, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::lock::check(arg8, arg9), 1016);
        let v0 = Campaign<T0>{
            id                : 0x2::object::new(arg13),
            hard_cap          : arg1,
            only_whitelist    : arg7,
            change_to_public  : arg10,
            scheduled_times   : arg8,
            scheduled_rewards : arg9,
            investors         : 0,
            investor_amounts  : 0,
            price             : arg2,
            start_time        : arg3,
            end_time          : arg4,
            min_amount        : arg5,
            max_amount        : arg6,
            total_deposit     : 0,
            balance           : 0x2::balance::zero<T0>(),
            members           : 0x2::bag::new(arg13),
            white_list        : 0x2::bag::new(arg13),
            owner             : arg12,
            funded            : false,
            public_sell_days  : arg11,
        };
        let v1 = CampaignEvent{
            campaign_id       : 0x2::object::id<Campaign<T0>>(&v0),
            hard_cap          : arg1,
            only_whitelist    : arg7,
            change_to_public  : arg10,
            scheduled_times   : arg8,
            scheduled_rewards : arg9,
            investors         : v0.investors,
            investor_amounts  : v0.investor_amounts,
            price             : arg2,
            start_time        : arg3,
            end_time          : arg4,
            min_amount        : arg5,
            max_amount        : arg6,
            sender            : 0x2::tx_context::sender(arg13),
            owner             : arg12,
        };
        0x2::event::emit<CampaignEvent>(v1);
        0x2::transfer::public_share_object<Campaign<T0>>(v0);
    }

    fun fund<T0>(arg0: &mut Campaign<T0>, arg1: &mut 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::Fund<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.funded == false, 1005);
        assert!(v0 >= arg0.start_time, 1002);
        let v1 = false;
        if (arg0.change_to_public) {
            if (v0 >= arg0.end_time && v0 <= arg0.end_time + arg0.public_sell_days * 86400000) {
                v1 = true;
            };
            assert!(v0 <= arg0.end_time + arg0.public_sell_days * 86400000, 1002);
        } else {
            assert!(v0 <= arg0.end_time, 1002);
        };
        let v2 = CampaignFundEvent{
            campaign_id          : 0x2::object::id<Campaign<T0>>(arg0),
            amount               : 0x2::coin::value<T0>(&arg3),
            wallet               : 0x2::tx_context::sender(arg6),
            is_insured           : arg4,
            is_private_to_public : v1,
        };
        0x2::event::emit<CampaignFundEvent>(v2);
        if (arg0.only_whitelist && !v1) {
            if (arg2 > 0) {
                staker_fund<T0>(arg0, arg1, arg2, arg3, arg4, arg6);
            } else {
                wilte_list_fund<T0>(arg0, arg1, arg3, arg4, arg6);
            };
        } else if (arg0.only_whitelist && v1) {
            assert!(0x2::balance::value<T0>(&arg0.balance) + 0x2::coin::value<T0>(&arg3) <= arg0.hard_cap, 1003);
            pub_fund<T0>(arg0, arg1, arg3, arg4, true, arg6);
        } else {
            pub_fund<T0>(arg0, arg1, arg3, arg4, false, arg6);
        };
    }

    public entry fun fund_pub<T0>(arg0: &mut Campaign<T0>, arg1: &mut 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::Fund<T0>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        fund<T0>(arg0, arg1, 0, arg2, arg3, arg4, arg5);
    }

    public entry fun fund_with_vesuip<T0>(arg0: &mut Campaign<T0>, arg1: &mut 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::Fund<T0>, arg2: &0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::vesuip::VeSuip, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.only_whitelist, 1009);
        fund<T0>(arg0, arg1, 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::vesuip::amount(arg2), arg3, arg4, arg5, arg6);
    }

    public fun get_member<T0>(arg0: &mut Campaign<T0>, arg1: address) : &Member {
        assert!(0x2::bag::contains<address>(&arg0.members, arg1), 1010);
        0x2::bag::borrow<address, Member>(&arg0.members, arg1)
    }

    fun pub_fund<T0>(arg0: &mut Campaign<T0>, arg1: &mut 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::Fund<T0>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = v1;
        assert!(v1 >= arg0.min_amount, 1006);
        assert!(v1 <= arg0.max_amount, 1006);
        if (arg3) {
            let v3 = 0x2::coin::split<T0>(&mut arg2, v1 * 15 / 100, arg5);
            v2 = v1 - 0x2::coin::value<T0>(&v3);
            0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::insure_campaign<T0>(arg1, 0x2::object::id<Campaign<T0>>(arg0), v3, arg5);
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_deposit = arg0.total_deposit + (v2 as u256);
        if (0x2::bag::contains<address>(&mut arg0.members, v0)) {
            let v4 = 0x2::bag::borrow_mut<address, Member>(&mut arg0.members, v0);
            v4.amount = v4.amount + v2;
            assert!(v4.amount <= arg0.max_amount, 1003);
        } else {
            let v5 = Member{
                wallet               : v0,
                amount               : v2,
                valid_amount         : v2,
                return_amount        : 0,
                claimed              : 0,
                is_claimed           : false,
                is_refunded          : false,
                is_private           : arg4,
                is_insured           : arg3,
                is_claimed_insurance : false,
            };
            arg0.investors = arg0.investors + 1;
            0x2::bag::add<address, Member>(&mut arg0.members, v0, v5);
        };
    }

    public entry fun refund<T0>(arg0: &mut Campaign<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.end_time < 0x2::clock::timestamp_ms(arg1), 1011);
        if (arg0.only_whitelist && arg0.change_to_public) {
            assert!(arg0.end_time + arg0.public_sell_days * 86400000 < 0x2::clock::timestamp_ms(arg1), 1011);
        };
        assert!(0x2::bag::contains<address>(&arg0.members, v0), 1010);
        let v1 = 0x2::bag::borrow_mut<address, Member>(&mut arg0.members, v0);
        assert!(!v1.is_refunded, 1017);
        let v2 = arg0.total_deposit;
        assert!(v2 > (arg0.hard_cap as u256), 1012);
        let v3 = claulate_return_amout_when_hardcap_is_reached(arg0.hard_cap, arg0.price, v2, v1.amount);
        assert!(v3 > 0, 1012);
        v1.return_amount = v3;
        v1.valid_amount = v1.amount - v3;
        v1.is_refunded = true;
        let v4 = CampaignRefundClaimEvent{
            campaign_id  : 0x2::object::id<Campaign<T0>>(arg0),
            wallet       : v0,
            valid_amount : v1.valid_amount,
            amount       : v3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CampaignRefundClaimEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v3), arg2), 0x2::tx_context::sender(arg2));
    }

    fun staker_fund<T0>(arg0: &mut Campaign<T0>, arg1: &mut 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::Fund<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = v1;
        assert!(v1 >= arg0.min_amount, 1006);
        if (arg4) {
            let v3 = 0x2::coin::split<T0>(&mut arg3, v1 * 15 / 100, arg5);
            v2 = v1 - 0x2::coin::value<T0>(&v3);
            0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::insure_campaign<T0>(arg1, 0x2::object::id<Campaign<T0>>(arg0), v3, arg5);
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg3));
        assert!(v2 <= arg2, 1003);
        arg0.total_deposit = arg0.total_deposit + (v2 as u256);
        if (0x2::bag::contains<address>(&mut arg0.members, v0)) {
            let v4 = 0x2::bag::borrow_mut<address, Member>(&mut arg0.members, v0);
            v4.amount = v4.amount + v2;
            assert!(v4.amount <= arg2, 1003);
        } else {
            let v5 = Member{
                wallet               : v0,
                amount               : v2,
                valid_amount         : v2,
                return_amount        : 0,
                claimed              : 0,
                is_claimed           : false,
                is_refunded          : false,
                is_private           : true,
                is_insured           : arg4,
                is_claimed_insurance : false,
            };
            arg0.investors = arg0.investors + 1;
            0x2::bag::add<address, Member>(&mut arg0.members, v0, v5);
        };
    }

    public entry fun take_fund<T0>(arg0: &0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::admin::AdminCap, arg1: &mut Campaign<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg2), arg1.owner);
    }

    public entry fun update<T0>(arg0: &0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::admin::AdminCap, arg1: &mut Campaign<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: vector<u64>, arg10: vector<u64>, arg11: bool, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::lock::check(arg9, arg10), 1016);
        arg1.hard_cap = arg2;
        arg1.price = arg3;
        arg1.start_time = arg4;
        arg1.end_time = arg5;
        arg1.min_amount = arg6;
        arg1.max_amount = arg7;
        arg1.only_whitelist = arg8;
        arg1.scheduled_times = arg9;
        arg1.scheduled_rewards = arg10;
        arg1.change_to_public = arg11;
        let v0 = CampaignEvent{
            campaign_id       : 0x2::object::id<Campaign<T0>>(arg1),
            hard_cap          : arg2,
            only_whitelist    : arg8,
            change_to_public  : arg11,
            scheduled_times   : arg9,
            scheduled_rewards : arg10,
            investors         : arg1.investors,
            investor_amounts  : arg1.investor_amounts,
            price             : arg3,
            start_time        : arg4,
            end_time          : arg5,
            min_amount        : arg6,
            max_amount        : arg7,
            sender            : 0x2::tx_context::sender(arg13),
            owner             : arg12,
        };
        0x2::event::emit<CampaignEvent>(v0);
    }

    fun wilte_list_fund<T0>(arg0: &mut Campaign<T0>, arg1: &mut 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::Fund<T0>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = v1;
        assert!(0x2::bag::contains<address>(&arg0.white_list, v0), 1001);
        let v3 = 0x2::bag::borrow<address, u64>(&arg0.white_list, v0);
        assert!(v1 >= arg0.min_amount, 1006);
        assert!(v1 <= *v3, 1003);
        if (arg3) {
            let v4 = 0x2::coin::split<T0>(&mut arg2, v1 * 15 / 100, arg4);
            v2 = v1 - 0x2::coin::value<T0>(&v4);
            0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::insurance::insure_campaign<T0>(arg1, 0x2::object::id<Campaign<T0>>(arg0), v4, arg4);
        };
        arg0.total_deposit = arg0.total_deposit + (v2 as u256);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        if (0x2::bag::contains<address>(&mut arg0.members, v0)) {
            let v5 = 0x2::bag::borrow_mut<address, Member>(&mut arg0.members, v0);
            v5.amount = v5.amount + v2;
            assert!(v5.amount <= *v3, 1003);
        } else {
            let v6 = Member{
                wallet               : v0,
                amount               : v2,
                valid_amount         : v2,
                return_amount        : 0,
                claimed              : 0,
                is_claimed           : false,
                is_refunded          : false,
                is_private           : true,
                is_insured           : arg3,
                is_claimed_insurance : false,
            };
            arg0.investors = arg0.investors + 1;
            0x2::bag::add<address, Member>(&mut arg0.members, v0, v6);
        };
    }

    // decompiled from Move bytecode v6
}

