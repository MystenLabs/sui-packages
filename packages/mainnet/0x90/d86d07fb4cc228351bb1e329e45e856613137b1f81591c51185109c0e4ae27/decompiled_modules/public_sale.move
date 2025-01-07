module 0x90d86d07fb4cc228351bb1e329e45e856613137b1f81591c51185109c0e4ae27::public_sale {
    struct SingleAddressAddedToWhitelist has copy, drop {
        wallet: address,
    }

    struct MultipleAddressAddedToWhitelist has copy, drop {
        wallets: vector<address>,
    }

    struct WhitelistAddressRemoved has copy, drop {
        wallet: address,
    }

    struct SuiContributionRecieved has copy, drop {
        wallet: address,
        amount: u64,
    }

    struct RewardsCalculated has copy, drop {
        wallet: address,
        tokens: u64,
        bonus: u64,
        refundableSui: u64,
    }

    struct FundsWithdrawn has copy, drop {
        wallet: address,
        amount: u64,
    }

    struct PresaleEnded has copy, drop {
        totalSuiDeposited: u64,
    }

    struct ICOOperatorCapability has key {
        id: 0x2::object::UID,
    }

    struct PresaleData has key {
        id: 0x2::object::UID,
        icoStartTimestamp: u64,
        icoEndTimestamp: u64,
        suiPerToken: u64,
        totalTokensForSale: u64,
        totalSuiDeposited: 0x2::balance::Balance<0x2::sui::SUI>,
        amountToBeRaisedSui: u64,
        actualAmountRaisedSui: u64,
        minimumContributionSui: u64,
        isPresaleActive: bool,
        whitelistedAddresses: vector<address>,
        contributors: vector<address>,
        bonusRewardPool: u64,
        bonusDepositPool: u64,
        testTotalSuiDeposited: u64,
    }

    struct UserData has key {
        id: 0x2::object::UID,
        wallet: address,
        investedSui: u64,
        refundableSui: u64,
        calculatedTokensReward: u64,
        calculatedBonusReward: u64,
    }

    public entry fun add_multiple_whitelist_entries(arg0: &ICOOperatorCapability, arg1: &mut PresaleData, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            assert!(0x1::vector::contains<address>(&arg1.whitelistedAddresses, 0x1::vector::borrow<address>(&arg2, v0)) == false, 6);
            v0 = v0 + 1;
        };
        0x1::vector::append<address>(&mut arg1.whitelistedAddresses, arg2);
        let v1 = MultipleAddressAddedToWhitelist{wallets: arg2};
        0x2::event::emit<MultipleAddressAddedToWhitelist>(v1);
    }

    public entry fun add_single_whitelist_entry(arg0: &ICOOperatorCapability, arg1: &mut PresaleData, arg2: address) {
        assert!(0x1::vector::contains<address>(&arg1.whitelistedAddresses, &arg2) == false, 6);
        0x1::vector::push_back<address>(&mut arg1.whitelistedAddresses, arg2);
        let v0 = SingleAddressAddedToWhitelist{wallet: arg2};
        0x2::event::emit<SingleAddressAddedToWhitelist>(v0);
    }

    fun calculate_bonus_reward(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * 10000 / arg2 * arg1 / 10000
    }

    public entry fun calculate_elligible_rewards(arg0: &mut PresaleData, arg1: &mut UserData, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_reward(arg1.investedSui, arg0.suiPerToken, arg0.totalTokensForSale, arg0.amountToBeRaisedSui, arg0.actualAmountRaisedSui);
        let v1 = calculate_refundable_reward(arg1.investedSui, arg0.suiPerToken, arg0.totalTokensForSale, arg0.amountToBeRaisedSui, arg0.actualAmountRaisedSui);
        if (get_is_whitelisted(arg0, 0x2::tx_context::sender(arg2))) {
            arg1.calculatedBonusReward = calculate_bonus_reward(arg1.investedSui, arg0.bonusRewardPool, 0x2::balance::value<0x2::sui::SUI>(&arg0.totalSuiDeposited));
        };
        arg1.refundableSui = v1;
        arg1.calculatedTokensReward = v0;
        let v2 = RewardsCalculated{
            wallet        : 0x2::tx_context::sender(arg2),
            tokens        : v0,
            bonus         : arg1.calculatedBonusReward,
            refundableSui : v1,
        };
        0x2::event::emit<RewardsCalculated>(v2);
    }

    fun calculate_refundable_reward(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = calculate_reward(arg0, arg1, arg2, arg3, arg4) / 10000000 * arg1 / 1000000000 * 10000000;
        if (v0 > arg0) {
            0
        } else {
            arg0 - v0
        }
    }

    fun calculate_reward(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg4 >= arg3) {
            arg0 * 10000000 / arg4 * arg2 / 1000000000 / 10000000 * 1000000000
        } else {
            arg0 / arg1 * 1000000000
        }
    }

    public entry fun change_ico_timeframes(arg0: &ICOOperatorCapability, arg1: &mut PresaleData, arg2: u64, arg3: u64) {
        assert!(arg3 > arg2, 7);
        arg1.icoStartTimestamp = arg2;
        arg1.icoEndTimestamp = arg3;
    }

    public entry fun create_user_data(arg0: &mut PresaleData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.contributors, &v0) == false, 5);
        0x1::vector::push_back<address>(&mut arg0.contributors, 0x2::tx_context::sender(arg2));
        let v1 = UserData{
            id                     : 0x2::object::new(arg2),
            wallet                 : arg1,
            investedSui            : 0,
            refundableSui          : 0,
            calculatedTokensReward : 0,
            calculatedBonusReward  : 0,
        };
        0x2::transfer::transfer<UserData>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun end_presale(arg0: &ICOOperatorCapability, arg1: &mut PresaleData) {
        assert!(arg1.isPresaleActive, 2);
        arg1.isPresaleActive = false;
        let v0 = PresaleEnded{totalSuiDeposited: 0x2::balance::value<0x2::sui::SUI>(&arg1.totalSuiDeposited)};
        0x2::event::emit<PresaleEnded>(v0);
    }

    public entry fun get_actual_amount_raised_sui(arg0: &mut PresaleData) : u64 {
        arg0.actualAmountRaisedSui
    }

    public entry fun get_amount_to_be_raised_sui(arg0: &mut PresaleData) : u64 {
        arg0.amountToBeRaisedSui
    }

    public entry fun get_bonus_deposit_pool(arg0: &mut PresaleData) : u64 {
        arg0.bonusDepositPool
    }

    public entry fun get_bonus_reward_pool(arg0: &mut PresaleData) : u64 {
        arg0.bonusRewardPool
    }

    public entry fun get_calculated_bonus_reward(arg0: &mut UserData) : u64 {
        arg0.calculatedBonusReward
    }

    public entry fun get_calculated_tokens_reward(arg0: &mut UserData) : u64 {
        arg0.calculatedTokensReward
    }

    public entry fun get_ico_end_timestamp(arg0: &mut PresaleData) : u64 {
        arg0.icoEndTimestamp
    }

    public entry fun get_ico_start_timestamp(arg0: &mut PresaleData) : u64 {
        arg0.icoStartTimestamp
    }

    public entry fun get_is_presale_active(arg0: &mut PresaleData) : bool {
        arg0.isPresaleActive
    }

    public entry fun get_is_whitelisted(arg0: &mut PresaleData, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelistedAddresses, &arg1)
    }

    public entry fun get_minimum_contribution_sui(arg0: &mut PresaleData) : u64 {
        arg0.minimumContributionSui
    }

    public entry fun get_refundable_sui(arg0: &mut UserData) : u64 {
        arg0.refundableSui
    }

    public entry fun get_sui_balance(arg0: &mut UserData) : u64 {
        arg0.investedSui
    }

    public entry fun get_sui_per_token(arg0: &mut PresaleData) : u64 {
        arg0.suiPerToken
    }

    public entry fun get_total_tokens_for_sale(arg0: &mut PresaleData) : u64 {
        arg0.totalTokensForSale
    }

    public entry fun get_whitelisted_addresses(arg0: &mut PresaleData) : vector<address> {
        arg0.whitelistedAddresses
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ICOOperatorCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ICOOperatorCapability>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PresaleData{
            id                     : 0x2::object::new(arg0),
            icoStartTimestamp      : 1684489853000,
            icoEndTimestamp        : 1685074825000,
            suiPerToken            : 110000000,
            totalTokensForSale     : 7000000 * 1000000000,
            totalSuiDeposited      : 0x2::balance::zero<0x2::sui::SUI>(),
            amountToBeRaisedSui    : 795970 * 1000000000,
            actualAmountRaisedSui  : 0,
            minimumContributionSui : 1,
            isPresaleActive        : true,
            whitelistedAddresses   : 0x1::vector::empty<address>(),
            contributors           : 0x1::vector::empty<address>(),
            bonusRewardPool        : 1130000 * 1000000000,
            bonusDepositPool       : 0,
            testTotalSuiDeposited  : 0,
        };
        0x2::transfer::share_object<PresaleData>(v1);
    }

    public entry fun purchase_tokens(arg0: &mut PresaleData, arg1: &mut UserData, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 > arg0.minimumContributionSui, 4);
        assert!(v0 >= arg0.icoStartTimestamp, 0);
        assert!(v0 <= arg0.icoEndTimestamp, 1);
        assert!(arg0.isPresaleActive, 1);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg3);
        arg1.investedSui = arg1.investedSui + 0x2::balance::value<0x2::sui::SUI>(&v1);
        let v2 = SuiContributionRecieved{
            wallet : 0x2::tx_context::sender(arg5),
            amount : 0x2::balance::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<SuiContributionRecieved>(v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.totalSuiDeposited, v1);
        arg0.actualAmountRaisedSui = arg0.actualAmountRaisedSui + 0x2::balance::value<0x2::sui::SUI>(&v1);
    }

    public entry fun remove_whitelist_entry(arg0: &ICOOperatorCapability, arg1: &mut PresaleData, arg2: address) {
        assert!(0x1::vector::contains<address>(&arg1.whitelistedAddresses, &arg2) == true, 8);
        let (_, v1) = 0x1::vector::index_of<address>(&arg1.whitelistedAddresses, &arg2);
        0x1::vector::remove<address>(&mut arg1.whitelistedAddresses, v1);
        let v2 = WhitelistAddressRemoved{wallet: arg2};
        0x2::event::emit<WhitelistAddressRemoved>(v2);
    }

    public entry fun withdraw_funds(arg0: &mut PresaleData, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.totalSuiDeposited);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.totalSuiDeposited, v0, arg1), @0x393ad2a44376908b8e3199581dc113fd196e4c0afe1c632103dd65eecaf41501);
        let v1 = FundsWithdrawn{
            wallet : @0x393ad2a44376908b8e3199581dc113fd196e4c0afe1c632103dd65eecaf41501,
            amount : v0,
        };
        0x2::event::emit<FundsWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

