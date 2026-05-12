module 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko_credits {
    struct ZENKO_CREDITS has drop {
        dummy_field: bool,
    }

    struct CreditsStore has key {
        id: 0x2::object::UID,
        version: u64,
        credits_treasury: 0x2::coin::TreasuryCap<ZENKO_CREDITS>,
        profits_usdsui: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
        redemption_usdsui: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
        fees_collected: u64,
        fees_withdrawn: u64,
        total_purchased: u64,
        total_earned_minted: u64,
        total_redeemed: u64,
        total_revenue_usdsui: u64,
    }

    struct EarnRule has drop {
        dummy_field: bool,
    }

    struct CreditsPurchased has copy, drop {
        account_id: 0x2::object::ID,
        buyer: address,
        usdsui_amount: u64,
        credits_amount: u64,
        purchase_type: 0x1::string::String,
        bundle_index: 0x1::option::Option<u64>,
        timestamp: u64,
    }

    struct EarningsMinted has copy, drop {
        recipient: address,
        amount: u64,
        source: 0x1::string::String,
        timestamp: u64,
    }

    struct CreditsRedeemed has copy, drop {
        redeemer: address,
        credits_amount: u64,
        usdsui_amount: u64,
        timestamp: u64,
    }

    struct PlatformFeeCollected has copy, drop {
        amount: u64,
        source: 0x1::string::String,
        total_collected: u64,
        timestamp: u64,
    }

    struct PlatformFeeWithdrawn has copy, drop {
        withdrawn_by: address,
        credits_amount: u64,
        timestamp: u64,
    }

    struct USDSUIProfitsWithdrawn has copy, drop {
        withdrawn_by: address,
        amount: u64,
        remaining_balance: u64,
        timestamp: u64,
    }

    struct BonusCreditsGranted has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
        reason: 0x1::string::String,
        granted_by: address,
        timestamp: u64,
    }

    struct RedemptionLiquidityAdded has copy, drop {
        added_by: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct EarningsMerged has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct RedemptionLiquidityWithdrawn has copy, drop {
        withdrawn_by: address,
        amount: u64,
        remaining_balance: u64,
        timestamp: u64,
    }

    public fun add_redemption_liquidity(arg0: &mut CreditsStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_treasury(arg1, arg3);
        0x2::coin::put<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg0.redemption_usdsui, arg2);
        let v0 = RedemptionLiquidityAdded{
            added_by    : 0x2::tx_context::sender(arg3),
            amount      : 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg2),
            new_balance : 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg0.redemption_usdsui),
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<RedemptionLiquidityAdded>(v0);
    }

    public(friend) fun add_sponsor_liquidity(arg0: &mut CreditsStore, arg1: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg2: &0x2::tx_context::TxContext) {
        0x2::coin::put<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg0.redemption_usdsui, arg1);
        let v0 = RedemptionLiquidityAdded{
            added_by    : 0x2::tx_context::sender(arg2),
            amount      : 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg1),
            new_balance : 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg0.redemption_usdsui),
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<RedemptionLiquidityAdded>(v0);
    }

    public fun buy_credits(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &mut CreditsStore, arg2: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg4: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::assert_not_paused(arg0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg2, arg3);
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg4);
        assert!(v0 > 0, 1);
        let v1 = v0 * 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::credits_per_usdsui() / 1000000;
        let v2 = if (v1 == 0) {
            1
        } else {
            v1
        };
        0x2::coin::put<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg1.profits_usdsui, arg4);
        arg1.total_revenue_usdsui = arg1.total_revenue_usdsui + v0;
        arg1.total_purchased = arg1.total_purchased + v2;
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::add_purchased_credits(arg2, v2, arg5);
        let v3 = CreditsPurchased{
            account_id     : 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg2),
            buyer          : 0x2::tx_context::sender(arg5),
            usdsui_amount  : v0,
            credits_amount : v2,
            purchase_type  : 0x1::string::utf8(b"purchase"),
            bundle_index   : 0x1::option::none<u64>(),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<CreditsPurchased>(v3);
    }

    public fun buy_credits_with_pass(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &mut CreditsStore, arg2: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::subscription::SubscriptionStore, arg3: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg4: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg5: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::subscription::ZenkoPass, arg6: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg7: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::assert_not_paused(arg0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg3, arg4);
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg6);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg7);
        assert!(v0 > 0, 1);
        let v2 = v0 * 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::credits_per_usdsui() / 1000000;
        let v3 = if (v2 == 0) {
            1
        } else {
            v2
        };
        0x2::coin::put<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg1.profits_usdsui, arg6);
        arg1.total_revenue_usdsui = arg1.total_revenue_usdsui + v0;
        arg1.total_purchased = arg1.total_purchased + v3;
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::add_purchased_credits(arg3, v3, arg7);
        let v4 = CreditsPurchased{
            account_id     : 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg3),
            buyer          : 0x2::tx_context::sender(arg7),
            usdsui_amount  : v0,
            credits_amount : v3,
            purchase_type  : 0x1::string::utf8(b"purchase_with_pass"),
            bundle_index   : 0x1::option::none<u64>(),
            timestamp      : v1,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<CreditsPurchased>(v4);
        let (v5, v6, v7) = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::subscription::calculate_purchase_bonus(arg2, arg3, arg5, v3, v1);
        if (v5 > 0) {
            0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::add_bonus_credits(arg3, v5, 0x1::string::utf8(b"ZenkoPass Bonus"), arg7);
            0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::subscription::emit_bonus_applied_event(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg3), v7, v3, v5, v6, v1);
        };
    }

    public(friend) fun collect_fee(arg0: &mut CreditsStore, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        arg0.fees_collected = arg0.fees_collected + arg1;
        let v0 = PlatformFeeCollected{
            amount          : arg1,
            source          : arg2,
            total_collected : arg0.fees_collected,
            timestamp       : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<PlatformFeeCollected>(v0);
    }

    public(friend) fun confirm_spend_for_vault(arg0: &mut 0x2::token::TokenPolicy<ZENKO_CREDITS>, arg1: 0x2::token::ActionRequest<ZENKO_CREDITS>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, address, 0x1::option::Option<address>) {
        0x2::token::confirm_request_mut<ZENKO_CREDITS>(arg0, arg1, arg2)
    }

    public fun fee_stats(arg0: &CreditsStore) : (u64, u64, u64) {
        (arg0.fees_collected, arg0.fees_withdrawn, arg0.fees_collected - arg0.fees_withdrawn)
    }

    public fun grant_bonus_credits(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg1: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_operations(arg0, arg4);
        assert!(arg2 > 0, 4);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::add_bonus_credits(arg1, arg2, arg3, arg4);
        let v0 = BonusCreditsGranted{
            account_id : 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg1),
            amount     : arg2,
            reason     : arg3,
            granted_by : 0x2::tx_context::sender(arg4),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<BonusCreditsGranted>(v0);
    }

    fun init(arg0: ZENKO_CREDITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENKO_CREDITS>(arg0, 0, b"ZKC", b"Zenko Credits", b"Earned credits from Zenko platform competitions", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<ZENKO_CREDITS>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<ZENKO_CREDITS>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::token::allow<ZENKO_CREDITS>(&mut v6, &v5, 0x2::token::to_coin_action(), arg1);
        let v7 = CreditsStore{
            id                   : 0x2::object::new(arg1),
            version              : 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::current_version(),
            credits_treasury     : v2,
            profits_usdsui       : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
            redemption_usdsui    : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
            fees_collected       : 0,
            fees_withdrawn       : 0,
            total_purchased      : 0,
            total_earned_minted  : 0,
            total_redeemed       : 0,
            total_revenue_usdsui : 0,
        };
        0x2::transfer::share_object<CreditsStore>(v7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZENKO_CREDITS>>(v1);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<ZENKO_CREDITS>>(v5, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<ZENKO_CREDITS>(v6);
    }

    public fun merge_earnings_to_account(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &mut 0x2::token::TokenPolicy<ZENKO_CREDITS>, arg2: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg4: 0x2::token::Token<ZENKO_CREDITS>, arg5: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::assert_not_paused(arg0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg2, arg3);
        let v0 = 0x2::token::value<ZENKO_CREDITS>(&arg4);
        assert!(v0 > 0, 4);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<ZENKO_CREDITS>(arg1, 0x2::token::spend<ZENKO_CREDITS>(arg4, arg5), arg5);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::add_purchased_credits(arg2, v0, arg5);
        let v5 = EarningsMerged{
            account_id : 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg2),
            owner      : 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::owner_address(arg2),
            amount     : v0,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<EarningsMerged>(v5);
    }

    public(friend) fun mint_and_send_earnings(arg0: &mut CreditsStore, arg1: u64, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        arg0.total_earned_minted = arg0.total_earned_minted + arg1;
        let v0 = EarningsMinted{
            recipient : arg2,
            amount    : arg1,
            source    : arg3,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<EarningsMinted>(v0);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<ZENKO_CREDITS>(&mut arg0.credits_treasury, 0x2::token::transfer<ZENKO_CREDITS>(0x2::token::mint<ZENKO_CREDITS>(&mut arg0.credits_treasury, arg1, arg4), arg2, arg4), arg4);
    }

    public(friend) fun mint_bonus_credits(arg0: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::add_bonus_credits(arg0, arg1, arg2, arg3);
    }

    public fun mint_credits_to(arg0: &mut CreditsStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_treasury(arg1, arg4);
        assert!(arg2 > 0, 4);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<ZENKO_CREDITS>(&mut arg0.credits_treasury, 0x2::token::transfer<ZENKO_CREDITS>(0x2::token::mint<ZENKO_CREDITS>(&mut arg0.credits_treasury, arg2, arg4), arg3, arg4), arg4);
        let v4 = EarningsMinted{
            recipient : arg3,
            amount    : arg2,
            source    : 0x1::string::utf8(b"mint_credits_to"),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<EarningsMinted>(v4);
    }

    public(friend) fun mint_earnings(arg0: &mut CreditsStore, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<ZENKO_CREDITS> {
        assert!(arg1 > 0, 4);
        arg0.total_earned_minted = arg0.total_earned_minted + arg1;
        let v0 = EarningsMinted{
            recipient : 0x2::tx_context::sender(arg3),
            amount    : arg1,
            source    : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<EarningsMinted>(v0);
        0x2::token::mint<ZENKO_CREDITS>(&mut arg0.credits_treasury, arg1, arg3)
    }

    public(friend) fun mint_earnings_to(arg0: &mut CreditsStore, arg1: u64, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<ZENKO_CREDITS> {
        assert!(arg1 > 0, 4);
        arg0.total_earned_minted = arg0.total_earned_minted + arg1;
        let v0 = EarningsMinted{
            recipient : arg2,
            amount    : arg1,
            source    : arg3,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<EarningsMinted>(v0);
        0x2::token::mint<ZENKO_CREDITS>(&mut arg0.credits_treasury, arg1, arg4)
    }

    public fun profits_balance(arg0: &CreditsStore) : u64 {
        0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg0.profits_usdsui)
    }

    public fun redeem(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: &mut CreditsStore, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::ConfigStore, arg4: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg5: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg6: 0x2::token::Token<ZENKO_CREDITS>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::assert_not_paused(arg0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg4, arg5);
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::owner_address(arg4);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_not_blacklisted(arg1, v0);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::redemption_cooldown_until(arg4) == 0 || v1 >= 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::redemption_cooldown_until(arg4), 6);
        let v2 = 0x2::token::value<ZENKO_CREDITS>(&arg6);
        assert!(v2 > 0, 3);
        let v3 = v2 * 1000000 / 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::credits_per_usdsui();
        assert!(v3 > 0, 3);
        assert!(v3 >= 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::min_redemption_usdsui(arg3), 5);
        let v4 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::last_redemption_at(arg4);
        let v5 = v4 > 0 && v1 - v4 < 86400000;
        let v6 = if (v5) {
            0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::redemption_rapid_fee_bps(arg3)
        } else {
            0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::redemption_fee_bps(arg3)
        };
        let v7 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::calculate_bps(v3, v6);
        let v8 = v3 - v7;
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg2.redemption_usdsui) >= v8, 2);
        0x2::token::burn<ZENKO_CREDITS>(&mut arg2.credits_treasury, arg6);
        arg2.total_redeemed = arg2.total_redeemed + v2;
        if (v7 > 0 && 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg2.redemption_usdsui) >= v3) {
            0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg2.profits_usdsui, 0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg2.redemption_usdsui, v7));
            arg2.total_revenue_usdsui = arg2.total_revenue_usdsui + v7;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg2.redemption_usdsui, v8), arg8), v0);
        let v9 = if (v5) {
            v1 + 86400000
        } else {
            0
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::update_redemption_state(arg4, v1, v9);
        let v10 = CreditsRedeemed{
            redeemer       : v0,
            credits_amount : v2,
            usdsui_amount  : v8,
            timestamp      : v1,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<CreditsRedeemed>(v10);
    }

    public fun redeem_purchased_credits(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: &mut CreditsStore, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::ConfigStore, arg4: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg5: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::assert_not_paused(arg0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg4, arg5);
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::owner_address(arg4);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_not_blacklisted(arg1, v0);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::redemption_cooldown_until(arg4) == 0 || v1 >= 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::redemption_cooldown_until(arg4), 6);
        assert!(arg6 > 0, 3);
        let v2 = arg6 * 1000000 / 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::credits_per_usdsui();
        assert!(v2 > 0, 3);
        assert!(v2 >= 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::min_redemption_usdsui(arg3), 5);
        let v3 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::last_redemption_at(arg4);
        let v4 = v3 > 0 && v1 - v3 < 86400000;
        let v5 = if (v4) {
            0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::redemption_rapid_fee_bps(arg3)
        } else {
            0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::redemption_fee_bps(arg3)
        };
        let v6 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::calculate_bps(v2, v5);
        let v7 = v2 - v6;
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg2.redemption_usdsui) >= v7, 2);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::withdraw_purchased_credits(arg4, arg6, arg8);
        if (v6 > 0 && 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg2.redemption_usdsui) >= v2) {
            0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg2.profits_usdsui, 0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg2.redemption_usdsui, v6));
            arg2.total_revenue_usdsui = arg2.total_revenue_usdsui + v6;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg2.redemption_usdsui, v7), arg8), v0);
        let v8 = if (v4) {
            v1 + 86400000
        } else {
            0
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::update_redemption_state(arg4, v1, v8);
        let v9 = CreditsRedeemed{
            redeemer       : v0,
            credits_amount : arg6,
            usdsui_amount  : v7,
            timestamp      : v1,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<CreditsRedeemed>(v9);
    }

    public fun redemption_liquidity(arg0: &CreditsStore) : u64 {
        0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg0.redemption_usdsui)
    }

    public fun store_stats(arg0: &CreditsStore) : (u64, u64, u64, u64) {
        (arg0.total_purchased, arg0.total_earned_minted, arg0.total_redeemed, arg0.total_revenue_usdsui)
    }

    public(friend) fun treasury_cap_mut(arg0: &mut CreditsStore) : &mut 0x2::coin::TreasuryCap<ZENKO_CREDITS> {
        &mut arg0.credits_treasury
    }

    public fun withdraw_fees(arg0: &mut CreditsStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_treasury(arg1, arg3);
        assert!(arg2 > 0 && arg2 <= arg0.fees_collected - arg0.fees_withdrawn, 4);
        let v0 = arg2 * 1000000 / 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::credits_per_usdsui();
        assert!(v0 > 0, 4);
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg0.redemption_usdsui) >= v0, 2);
        arg0.fees_withdrawn = arg0.fees_withdrawn + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg0.redemption_usdsui, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = PlatformFeeWithdrawn{
            withdrawn_by   : 0x2::tx_context::sender(arg3),
            credits_amount : arg2,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<PlatformFeeWithdrawn>(v1);
    }

    public fun withdraw_profits(arg0: &mut CreditsStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_treasury(arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg0.profits_usdsui, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = USDSUIProfitsWithdrawn{
            withdrawn_by      : 0x2::tx_context::sender(arg3),
            amount            : arg2,
            remaining_balance : 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg0.profits_usdsui),
            timestamp         : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<USDSUIProfitsWithdrawn>(v0);
    }

    public fun withdraw_redemption_liquidity(arg0: &mut CreditsStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_treasury(arg1, arg3);
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg0.redemption_usdsui) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg0.redemption_usdsui, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = RedemptionLiquidityWithdrawn{
            withdrawn_by      : 0x2::tx_context::sender(arg3),
            amount            : arg2,
            remaining_balance : 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg0.redemption_usdsui),
            timestamp         : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<RedemptionLiquidityWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

