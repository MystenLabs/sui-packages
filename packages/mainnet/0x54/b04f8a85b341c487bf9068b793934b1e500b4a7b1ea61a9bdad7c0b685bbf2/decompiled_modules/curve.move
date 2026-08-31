module 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::curve {
    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        name: vector<u8>,
        symbol: vector<u8>,
        is_gift: bool,
        initial_token_reserve: u64,
        virtual_sui_reserve: u64,
        virtual_token_reserve: u64,
        graduation_threshold_mist: u64,
        creator_fee_bps: u64,
    }

    struct TradeExecuted has copy, drop {
        curve_id: 0x2::object::ID,
        trader: address,
        side: u8,
        sui_amount: u64,
        token_amount: u64,
        fee_amount: u64,
        real_sui_reserve: u64,
        token_reserve: u64,
    }

    struct FeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        recipient: address,
        kind: u8,
        amount: u64,
    }

    struct GiftOwnerClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        owner_wallet: address,
        payout: address,
    }

    struct GiftPayoutUpdated has copy, drop {
        curve_id: 0x2::object::ID,
        owner_wallet: address,
        payout: address,
    }

    struct GiftForfeited has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
    }

    struct EmergencyWithdrawn has copy, drop {
        curve_id: 0x2::object::ID,
        treasury: address,
        amount: u64,
    }

    struct GraduationReady has copy, drop {
        curve_id: 0x2::object::ID,
        real_sui_reserve: u64,
        threshold: u64,
    }

    struct GraduationPrepared has copy, drop {
        curve_id: 0x2::object::ID,
        admin: address,
        real_sui_reserve: u64,
        token_reserve: u64,
    }

    struct GraduatedPoolRecorded has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct Curve<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        lifecycle: u8,
        real_sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        real_token_reserve: u64,
        token_reserve: 0x2::balance::Balance<T0>,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui_reserve: u64,
        virtual_token_reserve: u64,
        graduation_threshold_mist: u64,
        graduated_pool: 0x1::option::Option<0x2::object::ID>,
        platform_fee_bps: u64,
        creator_fee_bps: u64,
        is_gift: bool,
        gift: 0x1::option::Option<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>,
        fees: 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::FeeVault,
    }

    public fun accrue_trade_fee_for_testing<T0>(arg0: &mut Curve<T0>, arg1: u64) {
        let (v0, v1) = fee_split_for_testing(arg1, arg0.platform_fee_bps, arg0.creator_fee_bps);
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::accrue(&mut arg0.fees, v0, v1, arg0.is_gift);
    }

    fun append_ref(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    entry fun buy<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &mut Curve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_for_testing<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun buy_for_testing<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &mut Curve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_trading_enabled(arg0);
        assert!(is_internal_trading_open(arg1.lifecycle), 540);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let (v1, v2) = fee_split_for_testing(v0, arg1.platform_fee_bps, arg1.creator_fee_bps);
        let v3 = v1 + v2;
        let v4 = quote_buy(0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserve), 0x2::balance::value<T0>(&arg1.token_reserve), arg1.virtual_sui_reserve, arg1.virtual_token_reserve, v0 - v3);
        assert!(v4 >= arg3, 520);
        assert!(0x2::balance::value<T0>(&arg1.token_reserve) >= v4, 522);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        if (v3 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v3));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.real_sui_reserve, v5);
        arg1.real_token_reserve = arg1.real_token_reserve + v4;
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::accrue(&mut arg1.fees, v1, v2, arg1.is_gift);
        maybe_mark_ready_to_graduate<T0>(arg1);
        let v6 = TradeExecuted{
            curve_id         : 0x2::object::uid_to_inner(&arg1.id),
            trader           : 0x2::tx_context::sender(arg4),
            side             : 0,
            sui_amount       : v0,
            token_amount     : v4,
            fee_amount       : v3,
            real_sui_reserve : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserve),
            token_reserve    : 0x2::balance::value<T0>(&arg1.token_reserve),
        };
        0x2::event::emit<TradeExecuted>(v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token_reserve, v4), arg4)
    }

    entry fun claim_creator_fees<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &mut Curve<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = claim_creator_fees_amount<T0>(arg0, arg1, v0);
        let v2 = &mut arg1.fee_balance;
        transfer_claim(v2, v1, v0, arg2);
        let v3 = FeesClaimed{
            curve_id  : 0x2::object::uid_to_inner(&arg1.id),
            recipient : v0,
            kind      : 0,
            amount    : v1,
        };
        0x2::event::emit<FeesClaimed>(v3);
    }

    public fun claim_creator_fees_amount<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &mut Curve<T0>, arg2: address) : u64 {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_claiming_enabled(arg0);
        assert!(arg2 == arg1.creator, 530);
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::claim_creator(&mut arg1.fees)
    }

    entry fun claim_gift_fees<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &mut Curve<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::payout_sui_address(0x1::option::borrow<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>(&arg1.gift));
        let v1 = claim_gift_fees_amount<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
        let v2 = &mut arg1.fee_balance;
        transfer_claim(v2, v1, v0, arg2);
        let v3 = FeesClaimed{
            curve_id  : 0x2::object::uid_to_inner(&arg1.id),
            recipient : v0,
            kind      : 1,
            amount    : v1,
        };
        0x2::event::emit<FeesClaimed>(v3);
    }

    public fun claim_gift_fees_amount<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &mut Curve<T0>, arg2: address) : u64 {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_claiming_enabled(arg0);
        let v0 = 0x1::option::borrow<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>(&arg1.gift);
        assert!(0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::is_claimed(v0), 500);
        assert!(0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::owner_wallet(v0) == arg2, 501);
        let v1 = 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::claim_gift(&mut arg1.fees);
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::add_claimed_amount(0x1::option::borrow_mut<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>(&mut arg1.gift), v1);
        v1
    }

    entry fun claim_gift_owner<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &0x2::clock::Clock, arg2: &mut Curve<T0>, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_claiming_enabled(arg0);
        assert!(arg2.is_gift, 502);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg1), 503);
        let v1 = gift_owner_claim_message<T0>(arg2, 0x1::option::borrow<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>(&arg2.gift), v0, arg3, arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg5, 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::attestation_signer(arg0), &v1), 504);
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::claim(0x1::option::borrow_mut<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>(&mut arg2.gift), v0, arg3, 0x2::clock::timestamp_ms(arg1));
        let v2 = GiftOwnerClaimed{
            curve_id     : 0x2::object::uid_to_inner(&arg2.id),
            owner_wallet : v0,
            payout       : arg3,
        };
        0x2::event::emit<GiftOwnerClaimed>(v2);
    }

    entry fun create_gift<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0x2::coin::Coin<T0>, arg13: &mut 0x2::tx_context::TxContext) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_valid_creator_fee_bps(arg8);
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = new_gift_for_testing<T0>(arg0, v0, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg10, arg11, arg12, 0x2::clock::timestamp_ms(arg1), arg13);
        emit_curve_created<T0>(&v1, v0, true);
        0x2::transfer::share_object<Curve<T0>>(v1);
    }

    entry fun create_gift_with_creator<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &0x2::clock::Clock, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: 0x2::coin::Coin<T0>, arg14: &mut 0x2::tx_context::TxContext) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_valid_creator_fee_bps(arg9);
        let v0 = new_gift_for_testing<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11, arg12, arg13, 0x2::clock::timestamp_ms(arg1), arg14);
        emit_curve_created<T0>(&v0, arg2, true);
        0x2::transfer::share_object<Curve<T0>>(v0);
    }

    entry fun create_normal<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0x2::tx_context::TxContext) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_valid_creator_fee_bps(arg4);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = new_normal_for_testing<T0>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        emit_curve_created<T0>(&v1, v0, false);
        0x2::transfer::share_object<Curve<T0>>(v1);
    }

    entry fun create_normal_with_creator<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_valid_creator_fee_bps(arg5);
        let v0 = new_normal_for_testing<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        emit_curve_created<T0>(&v0, arg1, false);
        0x2::transfer::share_object<Curve<T0>>(v0);
    }

    public fun creator<T0>(arg0: &Curve<T0>) : address {
        arg0.creator
    }

    public fun creator_entitlement_for_testing<T0>(arg0: &Curve<T0>) : u64 {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::creator_entitlement(&arg0.fees)
    }

    public fun creator_fee_bps<T0>(arg0: &Curve<T0>) : u64 {
        arg0.creator_fee_bps
    }

    entry fun emergency_withdraw<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::AdminCap, arg2: &mut Curve<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_admin_cap(arg0, arg1);
        assert!(0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::trading_paused(arg0), 510);
        assert!(0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::claiming_paused(arg0), 511);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2.real_sui_reserve);
        if (v0 > 0) {
            let v1 = &mut arg2.real_sui_reserve;
            transfer_claim(v1, v0, 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::treasury(arg0), arg3);
        };
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg2.fee_balance);
        if (v2 > 0) {
            let v3 = &mut arg2.fee_balance;
            transfer_claim(v3, v2, 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::treasury(arg0), arg3);
        };
        let v4 = 0x2::balance::value<T0>(&arg2.token_reserve);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.token_reserve, v4), arg3), 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::treasury(arg0));
        };
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::claim_creator(&mut arg2.fees);
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::claim_gift(&mut arg2.fees);
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::claim_protocol(&mut arg2.fees);
        let v5 = EmergencyWithdrawn{
            curve_id : 0x2::object::uid_to_inner(&arg2.id),
            treasury : 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::treasury(arg0),
            amount   : v0 + v2,
        };
        0x2::event::emit<EmergencyWithdrawn>(v5);
    }

    public fun emergency_withdraw_for_testing<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &mut Curve<T0>) : u64 {
        assert!(0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::trading_paused(arg0), 510);
        assert!(0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::claiming_paused(arg0), 511);
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::claim_creator(&mut arg1.fees) + 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::claim_gift(&mut arg1.fees) + 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::claim_protocol(&mut arg1.fees)
    }

    fun emit_curve_created<T0>(arg0: &Curve<T0>, arg1: address, arg2: bool) {
        let v0 = CurveCreated{
            curve_id                  : 0x2::object::uid_to_inner(&arg0.id),
            creator                   : arg1,
            name                      : arg0.name,
            symbol                    : arg0.symbol,
            is_gift                   : arg2,
            initial_token_reserve     : 0x2::balance::value<T0>(&arg0.token_reserve),
            virtual_sui_reserve       : arg0.virtual_sui_reserve,
            virtual_token_reserve     : arg0.virtual_token_reserve,
            graduation_threshold_mist : arg0.graduation_threshold_mist,
            creator_fee_bps           : arg0.creator_fee_bps,
        };
        0x2::event::emit<CurveCreated>(v0);
    }

    public fun fee_balance_value<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance)
    }

    public fun fee_split_for_testing(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        (arg0 * arg2 / 10000, arg0 * arg1 / 10000)
    }

    entry fun forfeit_gift<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &mut Curve<T0>, arg2: &0x2::clock::Clock) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::forfeit(0x1::option::borrow_mut<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>(&mut arg1.gift), 0x2::clock::timestamp_ms(arg2), 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::gift_grace_period_ms(arg0));
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::move_gift_to_creator(&mut arg1.fees);
        arg1.is_gift = false;
        let v0 = GiftForfeited{
            curve_id : 0x2::object::uid_to_inner(&arg1.id),
            creator  : arg1.creator,
        };
        0x2::event::emit<GiftForfeited>(v0);
    }

    public fun forfeit_gift_for_testing<T0>(arg0: &mut Curve<T0>, arg1: u64, arg2: u64) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::forfeit(0x1::option::borrow_mut<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>(&mut arg0.gift), arg1, arg2);
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::move_gift_to_creator(&mut arg0.fees);
        arg0.is_gift = false;
    }

    public fun gift_entitlement_for_testing<T0>(arg0: &Curve<T0>) : u64 {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::gift_entitlement(&arg0.fees)
    }

    fun gift_owner_claim_message<T0>(arg0: &Curve<T0>, arg1: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault, arg2: address, arg3: address, arg4: u64) : vector<u8> {
        let v0 = b"SUI_GIFT_OWNER_CLAIM_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::object::uid_to_bytes(&arg0.id));
        let v1 = &mut v0;
        append_ref(v1, 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::x_user_id_hash(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        v0
    }

    public fun gift_owner_claim_message_for_testing<T0>(arg0: &Curve<T0>, arg1: address, arg2: address, arg3: u64) : vector<u8> {
        gift_owner_claim_message<T0>(arg0, 0x1::option::borrow<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>(&arg0.gift), arg1, arg2, arg3)
    }

    public fun graduated() : u8 {
        3
    }

    public fun graduating() : u8 {
        2
    }

    fun is_internal_trading_open(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 3
        }
    }

    public fun lifecycle<T0>(arg0: &Curve<T0>) : u8 {
        arg0.lifecycle
    }

    public fun live() : u8 {
        0
    }

    fun maybe_mark_ready_to_graduate<T0>(arg0: &mut Curve<T0>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui_reserve);
        let v1 = if (arg0.lifecycle == 0) {
            if (arg0.graduation_threshold_mist > 0) {
                v0 >= arg0.graduation_threshold_mist
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            arg0.lifecycle = 3;
            let v2 = 0x2::object::uid_to_inner(&arg0.id);
            arg0.graduated_pool = 0x1::option::some<0x2::object::ID>(v2);
            let v3 = GraduationReady{
                curve_id         : 0x2::object::uid_to_inner(&arg0.id),
                real_sui_reserve : v0,
                threshold        : arg0.graduation_threshold_mist,
            };
            0x2::event::emit<GraduationReady>(v3);
            let v4 = GraduatedPoolRecorded{
                curve_id : 0x2::object::uid_to_inner(&arg0.id),
                pool_id  : v2,
            };
            0x2::event::emit<GraduatedPoolRecorded>(v4);
        };
    }

    public fun new_gift_for_testing<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2::coin::Coin<T0>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : Curve<T0> {
        Curve<T0>{
            id                        : 0x2::object::new(arg13),
            creator                   : arg1,
            name                      : arg2,
            symbol                    : arg3,
            description               : arg4,
            lifecycle                 : 0,
            real_sui_reserve          : 0x2::balance::zero<0x2::sui::SUI>(),
            real_token_reserve        : 0,
            token_reserve             : 0x2::coin::into_balance<T0>(arg11),
            fee_balance               : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui_reserve       : arg8,
            virtual_token_reserve     : arg9,
            graduation_threshold_mist : arg10,
            graduated_pool            : 0x1::option::none<0x2::object::ID>(),
            platform_fee_bps          : 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::platform_fee_bps(arg0),
            creator_fee_bps           : arg7,
            is_gift                   : true,
            gift                      : 0x1::option::some<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>(0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::new_pending(arg1, arg5, arg6, arg12)),
            fees                      : 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::new(),
        }
    }

    public fun new_normal_for_testing<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T0>, arg10: &mut 0x2::tx_context::TxContext) : Curve<T0> {
        Curve<T0>{
            id                        : 0x2::object::new(arg10),
            creator                   : arg1,
            name                      : arg2,
            symbol                    : arg3,
            description               : arg4,
            lifecycle                 : 0,
            real_sui_reserve          : 0x2::balance::zero<0x2::sui::SUI>(),
            real_token_reserve        : 0,
            token_reserve             : 0x2::coin::into_balance<T0>(arg9),
            fee_balance               : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui_reserve       : arg6,
            virtual_token_reserve     : arg7,
            graduation_threshold_mist : arg8,
            graduated_pool            : 0x1::option::none<0x2::object::ID>(),
            platform_fee_bps          : 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::platform_fee_bps(arg0),
            creator_fee_bps           : arg5,
            is_gift                   : false,
            gift                      : 0x1::option::none<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>(),
            fees                      : 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::new(),
        }
    }

    public entry fun prepare_graduation<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::AdminCap, arg2: &mut Curve<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_admin_cap(arg0, arg1);
        abort 546
    }

    public fun protocol_balance_for_testing<T0>(arg0: &Curve<T0>) : u64 {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::protocol_balance(&arg0.fees)
    }

    public fun quote_buy(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg0 as u128) + (arg2 as u128);
        let v1 = (arg1 as u128) + (arg3 as u128);
        ((v1 - v0 * v1 / (v0 + (arg4 as u128))) as u64)
    }

    public fun quote_sell(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg0 as u128) + (arg2 as u128);
        let v1 = (arg1 as u128) + (arg3 as u128);
        ((v0 - v0 * v1 / (v1 + (arg4 as u128))) as u64)
    }

    public fun ready_to_graduate() : u8 {
        1
    }

    public fun real_sui_reserve_value<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui_reserve)
    }

    public fun real_token_reserve_value<T0>(arg0: &Curve<T0>) : u64 {
        arg0.real_token_reserve
    }

    public entry fun record_graduated_pool<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::admin::AdminCap, arg2: &mut Curve<T0>, arg3: 0x2::object::ID) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_admin_cap(arg0, arg1);
        assert!(arg2.lifecycle == 2 || arg2.lifecycle == 1, 542);
        assert!(arg3 == 0x2::object::uid_to_inner(&arg2.id), 547);
        arg2.lifecycle = 3;
        arg2.graduated_pool = 0x1::option::some<0x2::object::ID>(arg3);
        let v0 = GraduatedPoolRecorded{
            curve_id : 0x2::object::uid_to_inner(&arg2.id),
            pool_id  : arg3,
        };
        0x2::event::emit<GraduatedPoolRecorded>(v0);
    }

    entry fun sell<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &mut Curve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = sell_for_testing<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun sell_for_testing<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &mut Curve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_trading_enabled(arg0);
        assert!(is_internal_trading_open(arg1.lifecycle), 540);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(arg1.real_token_reserve >= v0, 523);
        let v1 = quote_sell(0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserve), 0x2::balance::value<T0>(&arg1.token_reserve), arg1.virtual_sui_reserve, arg1.virtual_token_reserve, v0);
        let (v2, v3) = fee_split_for_testing(v1, arg1.platform_fee_bps, arg1.creator_fee_bps);
        let v4 = v2 + v3;
        let v5 = v1 - v4;
        assert!(v5 >= arg3, 521);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserve) >= v1, 524);
        0x2::balance::join<T0>(&mut arg1.token_reserve, 0x2::coin::into_balance<T0>(arg2));
        let v6 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui_reserve, v1);
        if (v4 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v4));
        };
        arg1.real_token_reserve = arg1.real_token_reserve - v0;
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees::accrue(&mut arg1.fees, v2, v3, arg1.is_gift);
        let v7 = TradeExecuted{
            curve_id         : 0x2::object::uid_to_inner(&arg1.id),
            trader           : 0x2::tx_context::sender(arg4),
            side             : 1,
            sui_amount       : v5,
            token_amount     : v0,
            fee_amount       : v4,
            real_sui_reserve : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui_reserve),
            token_reserve    : 0x2::balance::value<T0>(&arg1.token_reserve),
        };
        0x2::event::emit<TradeExecuted>(v7);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg4)
    }

    public fun token_reserve_value<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    fun transfer_claim(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, arg1), arg3), arg2);
        };
    }

    entry fun update_gift_payout<T0>(arg0: &0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::LaunchpadConfig, arg1: &mut Curve<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::launchpad::assert_claiming_enabled(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::update_payout(0x1::option::borrow_mut<0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::gift_vault::GiftVault>(&mut arg1.gift), v0, arg2);
        let v1 = GiftPayoutUpdated{
            curve_id     : 0x2::object::uid_to_inner(&arg1.id),
            owner_wallet : v0,
            payout       : arg2,
        };
        0x2::event::emit<GiftPayoutUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

