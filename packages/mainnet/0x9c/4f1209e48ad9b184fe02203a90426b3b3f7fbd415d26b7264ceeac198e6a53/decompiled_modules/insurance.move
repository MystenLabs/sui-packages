module 0x9c4f1209e48ad9b184fe02203a90426b3b3f7fbd415d26b7264ceeac198e6a53::insurance {
    struct InsureCampaignEvent has copy, drop {
        sender: address,
        amount: u64,
        campaign_id: 0x2::object::ID,
    }

    struct IssueRefundAllowanceEvent has copy, drop {
        campaign_id: 0x2::object::ID,
    }

    struct ClaimRefundEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        amount: u64,
    }

    struct WithdrawFundEvent has copy, drop {
        fund_id: 0x2::object::ID,
        amount: u64,
    }

    struct Fund<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<T0>,
        operator: address,
    }

    struct InsuranceCertificate<phantom T0> has store, key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        amount: u64,
    }

    struct CampaignRefundAllowance has store, key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        real_avg_price: u64,
    }

    entry fun new<T0>(arg0: &0x9c4f1209e48ad9b184fe02203a90426b3b3f7fbd415d26b7264ceeac198e6a53::launchpad::Launchpad, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Fund<T0>{
            id       : 0x2::object::new(arg2),
            vault    : 0x2::balance::zero<T0>(),
            operator : arg1,
        };
        0x2::transfer::public_share_object<Fund<T0>>(v0);
    }

    entry fun add_coins<T0>(arg0: &mut Fund<T0>, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(get_coin_from_vec<T0>(arg2, arg1, arg3)));
    }

    public(friend) fun claim_refund<T0, T1, T2>(arg0: &mut Fund<T0>, arg1: &CampaignRefundAllowance, arg2: &0x9c4f1209e48ad9b184fe02203a90426b3b3f7fbd415d26b7264ceeac198e6a53::vault::InvestCertificate, arg3: &0x9c4f1209e48ad9b184fe02203a90426b3b3f7fbd415d26b7264ceeac198e6a53::vault::Vault<T1, T2>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.campaign_id == 0x9c4f1209e48ad9b184fe02203a90426b3b3f7fbd415d26b7264ceeac198e6a53::vault::get_certificate_campaign_id(arg2), 1);
        let v0 = 0x9c4f1209e48ad9b184fe02203a90426b3b3f7fbd415d26b7264ceeac198e6a53::vault::get_user_deposit(arg2);
        let v1 = 0x9c4f1209e48ad9b184fe02203a90426b3b3f7fbd415d26b7264ceeac198e6a53::vault::get_user_total_reward<T1, T2>(arg3, arg2) * arg1.real_avg_price / (10000000 as u64);
        assert!(v0 > v1, 4);
        let v2 = v0 - v1;
        let v3 = ClaimRefundEvent{
            campaign_id : arg1.campaign_id,
            amount      : v2,
        };
        0x2::event::emit<ClaimRefundEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.vault, v2, arg4), 0x2::tx_context::sender(arg4));
    }

    fun get_coin_from_vec<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 2);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        0x2::coin::split<T0>(&mut v0, arg1, arg2)
    }

    public(friend) fun insure_campaign<T0>(arg0: &mut Fund<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg2));
        let v0 = InsureCampaignEvent{
            sender      : 0x2::tx_context::sender(arg3),
            amount      : 0x2::coin::value<T0>(&arg2),
            campaign_id : arg1,
        };
        0x2::event::emit<InsureCampaignEvent>(v0);
    }

    entry fun issue_refund_allowance(arg0: &0x9c4f1209e48ad9b184fe02203a90426b3b3f7fbd415d26b7264ceeac198e6a53::launchpad::Launchpad, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CampaignRefundAllowance{
            id             : 0x2::object::new(arg3),
            campaign_id    : arg1,
            real_avg_price : arg2,
        };
        let v1 = IssueRefundAllowanceEvent{campaign_id: arg1};
        0x2::event::emit<IssueRefundAllowanceEvent>(v1);
        0x2::transfer::public_share_object<CampaignRefundAllowance>(v0);
    }

    entry fun set_operator<T0>(arg0: &0x9c4f1209e48ad9b184fe02203a90426b3b3f7fbd415d26b7264ceeac198e6a53::launchpad::Launchpad, arg1: &mut Fund<T0>, arg2: address) {
        arg1.operator = arg2;
    }

    entry fun withdraw<T0>(arg0: &mut Fund<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.operator == 0x2::tx_context::sender(arg2), 3);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.vault, arg1, arg2), 0x2::tx_context::sender(arg2));
        let v0 = WithdrawFundEvent{
            fund_id : 0x2::object::uid_to_inner(&arg0.id),
            amount  : arg1,
        };
        0x2::event::emit<WithdrawFundEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

