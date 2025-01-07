module 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::actions {
    struct MintEvent has copy, drop {
        pfp_id: 0x2::object::ID,
        pfp_number: u64,
        minted_by: address,
        payment: u64,
        referral_code: 0x1::string::String,
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
        code: 0x1::string::String,
    }

    struct UserDataReadOnly has copy, drop {
        id: 0x2::object::ID,
        chakra_number: u64,
        owner: address,
        s1_alloc: u64,
        s2_alloc: u64,
        maya_burnt: u64,
        referral_code: 0x1::string::String,
        referral_used: u64,
        rank: u64,
        is_whale_whitelisted: bool,
        boost_multiplier: u64,
    }

    public fun claim_maya(arg0: 0x2::coin::Coin<0x3bf0aeb7b9698b18ec7937290a5701088fcd5d43ad11a2564b074d022a6d71ec::maya::MAYA>, arg1: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::booster_pool::BoosterPool, arg2: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::ChakraNFT, arg3: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::Leaderboard, arg4: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::GlobalConfig, arg5: &0x2::clock::Clock) {
        assert!(0x2::coin::value<0x3bf0aeb7b9698b18ec7937290a5701088fcd5d43ad11a2564b074d022a6d71ec::maya::MAYA>(&arg0) > 0, 0);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::version::assert_v(0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::version(arg4));
        let v0 = 0x2::coin::into_balance<0x3bf0aeb7b9698b18ec7937290a5701088fcd5d43ad11a2564b074d022a6d71ec::maya::MAYA>(arg0);
        let v1 = get_boost_multiplier(arg4, arg2);
        let v2 = 0;
        if (v1 > 0) {
            let v3 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::booster_pool::calc_bonus(v1, 0x2::balance::value<0x3bf0aeb7b9698b18ec7937290a5701088fcd5d43ad11a2564b074d022a6d71ec::maya::MAYA>(&v0));
            v2 = v3;
            0x2::balance::join<0x3bf0aeb7b9698b18ec7937290a5701088fcd5d43ad11a2564b074d022a6d71ec::maya::MAYA>(&mut v0, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::booster_pool::take_bonus(arg1, v3));
        };
        let (v4, v5) = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::bonus_percentage_per_claim(arg4);
        let v6 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::max_bonus_per_claim(arg4);
        let v7 = v2 * v4 / v5;
        let v8 = v7;
        if (v7 > v6) {
            v8 = v6;
        };
        0x2::balance::join<0x3bf0aeb7b9698b18ec7937290a5701088fcd5d43ad11a2564b074d022a6d71ec::maya::MAYA>(&mut v0, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::booster_pool::take_bonus(arg1, v8));
        let v9 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::booster_pool::burn_maya(arg1, v0);
        if (0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::exists(arg3, arg2)) {
            0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::remove(arg3, arg2);
        };
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::add_maya_burnt(arg2, arg4, v9);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::add(arg3, arg2);
        let v10 = ClaimEvent{
            pfp_id         : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::id(arg2),
            pfp_number     : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::number(arg2),
            minted_by      : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::minted_by(arg2),
            net_maya_burnt : v9,
            boost_amount   : v2,
            old_rank       : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::find_rank(arg3, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::maya_burnt(arg2), 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::number(arg2)),
            new_rank       : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::find_rank(arg3, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::maya_burnt(arg2), 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::number(arg2)),
            timestamp      : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ClaimEvent>(v10);
    }

    fun get_boost_multiplier(arg0: &0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::GlobalConfig, arg1: &0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::ChakraNFT) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::minted_by(arg1);
        if (0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::is_a_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v0, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::boost_a(arg0));
        };
        if (0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::is_b_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v1, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::boost_b(arg0));
        };
        if (0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::is_c_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v1, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::boost_c(arg0));
        };
        if (0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::is_d_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v1, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::boost_d(arg0));
        };
        if (0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::is_e_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v1, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::boost_e(arg0));
        };
        if (0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::is_f_whitelisted(arg0, v2)) {
            v1 = 0x1::u64::max(v1, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::boost_f(arg0));
        };
        v1
    }

    public fun get_user_data(arg0: &0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::GlobalConfig, arg1: &0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::Leaderboard, arg2: &0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::ChakraNFT) : UserDataReadOnly {
        let v0 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::is_whale_whitelisted(arg0, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::minted_by(arg2));
        let (v1, v2) = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::remaining_referrals(arg0, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::referral_code(arg2));
        let v3 = if (v0) {
            0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::max_codes_per_whale(arg0) - v1
        } else {
            0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::max_codes_per_acc(arg0) - v1
        };
        let v4 = v3;
        if (!v2) {
            v4 = 0;
        };
        let (v5, v6) = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::s_alloc(arg2);
        UserDataReadOnly{
            id                   : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::id(arg2),
            chakra_number        : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::number(arg2),
            owner                : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::minted_by(arg2),
            s1_alloc             : v5,
            s2_alloc             : v6,
            maya_burnt           : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::maya_burnt(arg2),
            referral_code        : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::referral_code(arg2),
            referral_used        : v4,
            rank                 : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::find_rank(arg1, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::maya_burnt(arg2), 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::number(arg2)),
            is_whale_whitelisted : v0,
            boost_multiplier     : get_boost_multiplier(arg0, arg2),
        }
    }

    public fun mint_basic(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::Leaderboard, arg2: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::ChakraNFT {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::base_price(arg2), 4);
        assert!(0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::status(arg2), 17);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::version::assert_v(0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::version(arg2));
        let v0 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::create(arg2, arg3);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::add(arg1, &v0);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::register(arg2, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::id(&v0), 0x2::tx_context::sender(arg3));
        let v1 = MintEvent{
            pfp_id        : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::id(&v0),
            pfp_number    : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::number(&v0),
            minted_by     : 0x2::tx_context::sender(arg3),
            payment       : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            referral_code : 0x1::string::utf8(b""),
        };
        0x2::event::emit<MintEvent>(v1);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::add_payment(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        v0
    }

    public fun mint_by_code(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::Leaderboard, arg2: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::GlobalConfig, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::ChakraNFT {
        assert!(0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::status(arg2), 17);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::referral_price(arg2), 4);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::version::assert_v(0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::version(arg2));
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::use_referral_code(arg2, arg3);
        let v0 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::create(arg2, arg4);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::add(arg1, &v0);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::register(arg2, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::id(&v0), 0x2::tx_context::sender(arg4));
        let v1 = MintEvent{
            pfp_id        : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::id(&v0),
            pfp_number    : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::number(&v0),
            minted_by     : 0x2::tx_context::sender(arg4),
            payment       : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            referral_code : arg3,
        };
        0x2::event::emit<MintEvent>(v1);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::add_payment(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::increment_used_referral_count(arg2);
        v0
    }

    public fun mint_retro(arg0: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::Leaderboard, arg1: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::GlobalConfig, arg2: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::retro::RetroUsersList, arg3: &mut 0x2::tx_context::TxContext) : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::ChakraNFT {
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::version::assert_v(0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::version(arg1));
        assert!(0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::retro::exists(arg2, 0x2::tx_context::sender(arg3)), 109);
        let (v0, v1) = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::retro::get_user_info(arg2, 0x2::tx_context::sender(arg3));
        let v2 = 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::create_unsafe(arg1, 0x2::tx_context::sender(arg3), v0, v1, arg3);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::leaderboard::add(arg0, &v2);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::register(arg1, 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::id(&v2), 0x2::tx_context::sender(arg3));
        let v3 = MintEvent{
            pfp_id        : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::id(&v2),
            pfp_number    : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::number(&v2),
            minted_by     : 0x2::tx_context::sender(arg3),
            payment       : 0,
            referral_code : 0x1::string::utf8(b""),
        };
        0x2::event::emit<MintEvent>(v3);
        v2
    }

    public fun refer(arg0: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::GlobalConfig, arg1: &mut 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::ChakraNFT, arg2: 0x1::string::String) {
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::version::assert_v(0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::version(arg0));
        assert!(0x1::string::length(&arg2) < 20, 99);
        0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::add_referral_code(arg0, arg1, arg2);
        let v0 = ReferEvent{
            pfp_id     : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::id(arg1),
            pfp_number : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::number(arg1),
            minted_by  : 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::chakra_nft::minted_by(arg1),
            code       : arg2,
        };
        0x2::event::emit<ReferEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

