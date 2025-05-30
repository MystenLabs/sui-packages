module 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::actions {
    struct MintEvent has copy, drop {
        pfp_id: 0x2::object::ID,
        pfp_number: u64,
        minted_by: address,
        payment: u64,
        referral_code: u64,
    }

    struct ClaimEvent has copy, drop {
        pfp_id: 0x2::object::ID,
        pfp_number: u64,
        minted_by: address,
        net_maya_burnt: u64,
        boost_amount: u64,
        old_rank: u64,
        new_rank: u64,
        timestamp: u64,
    }

    struct ReferEvent has copy, drop {
        pfp_id: 0x2::object::ID,
        pfp_number: u64,
        minted_by: address,
        code: u64,
    }

    struct UserDataReadOnly has copy, drop {
        id: 0x2::object::ID,
        chakra_number: u64,
        owner: address,
        s1_alloc: u64,
        s2_alloc: u64,
        maya_burnt: u64,
        referral_code: u64,
        referral_used: u64,
        rank: u64,
        is_whale_whitelisted: bool,
        boost_multiplier: u64,
    }

    public fun claim_maya(arg0: 0x2::coin::Coin<0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::staging_maya::STAGING_MAYA>, arg1: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::booster_pool::BoosterPool, arg2: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::ChakraNFT, arg3: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::Leaderboard, arg4: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::GlobalConfig, arg5: &0x2::clock::Clock) {
        assert!(0x2::coin::value<0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::staging_maya::STAGING_MAYA>(&arg0) > 0, 0);
        let v0 = 0x2::coin::into_balance<0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::staging_maya::STAGING_MAYA>(arg0);
        let v1 = get_boost_multiplier(arg4, arg2);
        let v2 = 0;
        if (v1 > 0) {
            let v3 = 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::booster_pool::calc_bonus(v1, 0x2::balance::value<0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::staging_maya::STAGING_MAYA>(&v0));
            v2 = v3;
            0x2::balance::join<0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::staging_maya::STAGING_MAYA>(&mut v0, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::booster_pool::take_bonus(arg1, v3));
        };
        let v4 = 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::booster_pool::burn_maya(arg1, v0);
        if (0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::exists(arg3, arg2)) {
            0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::remove(arg3, arg2);
        };
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::add_maya_burnt(arg2, arg4, v4);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::add(arg3, arg2);
        let v5 = ClaimEvent{
            pfp_id         : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::id(arg2),
            pfp_number     : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::number(arg2),
            minted_by      : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::minted_by(arg2),
            net_maya_burnt : v4,
            boost_amount   : v2,
            old_rank       : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::find_rank(arg3, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::maya_burnt(arg2), 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::number(arg2)),
            new_rank       : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::find_rank(arg3, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::maya_burnt(arg2), 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::number(arg2)),
            timestamp      : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ClaimEvent>(v5);
    }

    fun get_boost_multiplier(arg0: &0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::GlobalConfig, arg1: &0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::ChakraNFT) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::minted_by(arg1);
        if (0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::is_a_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v0, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::boost_a(arg0));
        };
        if (0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::is_b_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v1, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::boost_b(arg0));
        };
        if (0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::is_c_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v1, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::boost_c(arg0));
        };
        if (0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::is_d_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v1, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::boost_d(arg0));
        };
        if (0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::is_e_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v1, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::boost_e(arg0));
        };
        if (0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::is_f_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v1, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::boost_f(arg0));
        };
        v1
    }

    public fun get_user_data(arg0: &0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::GlobalConfig, arg1: &0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::Leaderboard, arg2: &0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::ChakraNFT) : UserDataReadOnly {
        let v0 = 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::is_whale_whitelisted(arg0, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::minted_by(arg2));
        let v1 = if (v0) {
            0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::max_codes_per_whale(arg0) - 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::remaining_referrals(arg0, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::referral_code(arg2))
        } else {
            0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::max_codes_per_acc(arg0) - 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::remaining_referrals(arg0, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::referral_code(arg2))
        };
        let (v2, v3) = 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::s_alloc(arg2);
        UserDataReadOnly{
            id                   : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::id(arg2),
            chakra_number        : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::number(arg2),
            owner                : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::minted_by(arg2),
            s1_alloc             : v2,
            s2_alloc             : v3,
            maya_burnt           : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::maya_burnt(arg2),
            referral_code        : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::referral_code(arg2),
            referral_used        : v1,
            rank                 : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::find_rank(arg1, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::maya_burnt(arg2), 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::number(arg2)),
            is_whale_whitelisted : v0,
            boost_multiplier     : get_boost_multiplier(arg0, arg2),
        }
    }

    public fun mint_basic(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::Leaderboard, arg2: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::ChakraNFT {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::base_price(arg2), 4);
        assert!(0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::status(arg2), 17);
        let v0 = 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::create(arg2, arg3);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::add(arg1, &v0);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::register(arg2, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::id(&v0), 0x2::tx_context::sender(arg3));
        let v1 = MintEvent{
            pfp_id        : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::id(&v0),
            pfp_number    : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::number(&v0),
            minted_by     : 0x2::tx_context::sender(arg3),
            payment       : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            referral_code : 0,
        };
        0x2::event::emit<MintEvent>(v1);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::add_payment(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        v0
    }

    public fun mint_by_code(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::Leaderboard, arg2: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::GlobalConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::ChakraNFT {
        assert!(0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::status(arg2), 17);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::referral_price(arg2), 4);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::use_referral_code(arg2, arg3);
        let v0 = 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::create(arg2, arg4);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::add(arg1, &v0);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::register(arg2, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::id(&v0), 0x2::tx_context::sender(arg4));
        let v1 = MintEvent{
            pfp_id        : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::id(&v0),
            pfp_number    : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::number(&v0),
            minted_by     : 0x2::tx_context::sender(arg4),
            payment       : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            referral_code : arg3,
        };
        0x2::event::emit<MintEvent>(v1);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::add_payment(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::increment_used_referral_count(arg2);
        v0
    }

    public fun mint_free(arg0: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::Leaderboard, arg1: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::ChakraNFT {
        assert!(0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::is_free_whitelisted(arg1, 0x2::tx_context::sender(arg2)), 0);
        assert!(0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::status(arg1), 17);
        let v0 = 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::create(arg1, arg2);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::add(arg0, &v0);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::register(arg1, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::id(&v0), 0x2::tx_context::sender(arg2));
        let v1 = MintEvent{
            pfp_id        : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::id(&v0),
            pfp_number    : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::number(&v0),
            minted_by     : 0x2::tx_context::sender(arg2),
            payment       : 0,
            referral_code : 0,
        };
        0x2::event::emit<MintEvent>(v1);
        v0
    }

    public fun pre_mint_by_admin(arg0: &0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::admin::MintCap, arg1: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::Leaderboard, arg2: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::GlobalConfig, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::ChakraNFT {
        assert!(0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::status(arg2), 17);
        let v0 = 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::create_unsafe(arg2, arg3, arg4, arg5, arg6);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::leaderboard::add(arg1, &v0);
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::register(arg2, 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::id(&v0), arg3);
        let v1 = MintEvent{
            pfp_id        : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::id(&v0),
            pfp_number    : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::number(&v0),
            minted_by     : arg3,
            payment       : 0,
            referral_code : 0,
        };
        0x2::event::emit<MintEvent>(v1);
        v0
    }

    public fun refer(arg0: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::GlobalConfig, arg1: &mut 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::ChakraNFT, arg2: u64) {
        0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::add_referral_code(arg0, arg1, arg2);
        let v0 = ReferEvent{
            pfp_id     : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::id(arg1),
            pfp_number : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::number(arg1),
            minted_by  : 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::chakra_nft::minted_by(arg1),
            code       : arg2,
        };
        0x2::event::emit<ReferEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

