module 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct FeedWormEvent has copy, drop {
        owner: address,
        bird_type: u16,
        energy: u64,
        worm_type: u16,
        worm_energy: u64,
    }

    struct PreyEvent has copy, drop {
        owner: address,
        bird_type: u16,
        preying_time: u64,
        claiming_time: u64,
        rare: u8,
        boost: u64,
    }

    struct ClaimPreyRewardEvent has copy, drop {
        owner: address,
        bird_type: u16,
        reward: u64,
        bonus: u64,
    }

    struct UpgradeEvent has copy, drop {
        req_id: u128,
        owner: address,
        upgrade_type: u8,
        nonce: u128,
        value: u64,
        new_value: u64,
    }

    struct DepositBirdNFTEvent has copy, drop {
        owner: address,
        archive: 0x2::object::ID,
        bird: 0x2::object::ID,
        bird_type: u16,
        bird_sub_type: u8,
    }

    struct WithdrawBirdNFTEvent has copy, drop {
        owner: address,
        archive: 0x2::object::ID,
        bird_type: u16,
        withdrawal_time: u64,
    }

    struct ClaimBirdNFTEvent has copy, drop {
        owner: address,
        archive: 0x2::object::ID,
        bird: 0x2::object::ID,
        bird_type: u16,
    }

    struct PaymentExecuted has copy, drop {
        owner: address,
        amount: u64,
        req_id: u128,
        type: u8,
        coin_type: 0x1::type_name::TypeName,
    }

    struct DepositMatchingBirdEvent has copy, drop {
        owner: address,
        archive: 0x2::object::ID,
        matching_bird: 0x2::object::ID,
        matching_bird_type: u16,
        matching_bird_sub_type: u8,
    }

    struct WithdrawMatchingBirdEvent has copy, drop {
        owner: address,
        archive: 0x2::object::ID,
        bird_id: 0x2::object::ID,
    }

    struct MatchingEvent has copy, drop {
        owner: address,
        bird_type: u16,
        matching_time: u64,
        claiming_matching_time: u64,
    }

    struct ClaimMatchingRewardEvent has copy, drop {
        owner: address,
    }

    public fun withdraw_matching_bird(arg0: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg2, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::ensure_not_matching(arg1);
        let v0 = WithdrawMatchingBirdEvent{
            owner   : 0x2::tx_context::sender(arg3),
            archive : 0x2::object::id<0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive>(arg1),
            bird_id : 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::withdraw_matching_bird(arg1),
        };
        0x2::event::emit<WithdrawMatchingBirdEvent>(v0);
    }

    public fun claim_bird(arg0: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg3, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = ClaimBirdNFTEvent{
            owner     : v0,
            archive   : 0x2::object::id<0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive>(arg1),
            bird      : 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::transfer_bird(arg1, v0),
            bird_type : 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_claim_bird(arg1, 0x2::clock::timestamp_ms(arg2)),
        };
        0x2::event::emit<ClaimBirdNFTEvent>(v1);
    }

    public fun claim_matching_reward(arg0: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg3, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::clear_matching_session(arg1, 0x2::clock::timestamp_ms(arg2));
        let v0 = ClaimMatchingRewardEvent{owner: 0x2::tx_context::sender(arg4)};
        0x2::event::emit<ClaimMatchingRewardEvent>(v0);
    }

    public fun claim_prey_reward<T0, T1>(arg0: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::pools::RewardPoolGame<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg4, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_bird_archive(arg1, v0);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_claim_reward_prey(arg1, 0x2::clock::timestamp_ms(arg3));
        let (v2, v3) = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::get_prey_reward(arg0, v1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::pools::validate_reward_pool_game<T0, T1>(arg2, v2, v3);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::pools::transfer_reward_game<T0, T1>(arg2, v2, v3, v0, arg5);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::reset_preying(arg1, v2, v3);
        let v4 = ClaimPreyRewardEvent{
            owner     : v0,
            bird_type : v1,
            reward    : v2,
            bonus     : v3,
        };
        0x2::event::emit<ClaimPreyRewardEvent>(v4);
    }

    public fun deposit_bird(arg0: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: 0xf4fef70790fe61d3bf4aa3189c2cd1260a6506f646ec1792ec038861b7f6b24::birds_nft::BirdNFT, arg3: &0x2::clock::Clock, arg4: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg4, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg5);
        let (_, v2, v3) = 0xf4fef70790fe61d3bf4aa3189c2cd1260a6506f646ec1792ec038861b7f6b24::birds_nft::info(&arg2);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_bird_type(arg0, v2);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_deposit_bird(arg1, v0);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::fill_bird(arg1, 0x2::clock::timestamp_ms(arg3), v2, arg2);
        let v4 = DepositBirdNFTEvent{
            owner         : v0,
            archive       : 0x2::object::id<0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive>(arg1),
            bird          : 0x2::object::id<0xf4fef70790fe61d3bf4aa3189c2cd1260a6506f646ec1792ec038861b7f6b24::birds_nft::BirdNFT>(&arg2),
            bird_type     : v2,
            bird_sub_type : v3,
        };
        0x2::event::emit<DepositBirdNFTEvent>(v4);
    }

    public fun deposit_matching_bird(arg0: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: 0xf4fef70790fe61d3bf4aa3189c2cd1260a6506f646ec1792ec038861b7f6b24::birds_nft::BirdNFT, arg3: &0x2::clock::Clock, arg4: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg4, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg5);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_bird_archive(arg1, v0);
        let (_, v2, v3) = 0xf4fef70790fe61d3bf4aa3189c2cd1260a6506f646ec1792ec038861b7f6b24::birds_nft::info(&arg2);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::fill_matching_bird(arg1, arg2, v2, v3, 0x2::clock::timestamp_ms(arg3));
        let v4 = DepositMatchingBirdEvent{
            owner                  : v0,
            archive                : 0x2::object::id<0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive>(arg1),
            matching_bird          : 0x2::object::id<0xf4fef70790fe61d3bf4aa3189c2cd1260a6506f646ec1792ec038861b7f6b24::birds_nft::BirdNFT>(&arg2),
            matching_bird_type     : v2,
            matching_bird_sub_type : v3,
        };
        0x2::event::emit<DepositMatchingBirdEvent>(v4);
    }

    public fun feed_worm(arg0: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFT, arg3: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg3, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_preying(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_bird_archive(arg1, v0);
        let (_, _, _, v5, _, _) = 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::info(&arg2);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_worm_type(arg0, v5);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_bird_energy(arg1, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::get_bird_energy(arg0, v1));
        let v8 = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::get_worm_energy(arg0, v5);
        0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::burn(arg2, arg4);
        let v9 = FeedWormEvent{
            owner       : v0,
            bird_type   : v1,
            energy      : 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::set_energy(arg1, v8),
            worm_type   : v5,
            worm_energy : v8,
        };
        0x2::event::emit<FeedWormEvent>(v9);
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun matching(arg0: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg3, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg4);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::ensure_not_matching(arg1);
        let (_, _, v3) = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::get_time_lock(arg0);
        let (v4, v5) = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::start_matching_session(arg1, 0x2::clock::timestamp_ms(arg2), v3);
        let v6 = MatchingEvent{
            owner                  : v0,
            bird_type              : 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_bird_archive(arg1, v0),
            matching_time          : v4,
            claiming_matching_time : v5,
        };
        0x2::event::emit<MatchingEvent>(v6);
    }

    public fun payment<T0>(arg0: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::pools::FeePool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg6, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        let v0 = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::get_validator(arg0);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::verify_signature(arg4, arg5, &v0);
        let v1 = 0x2::tx_context::sender(arg7);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_bird_archive(arg1, v1);
        let v2 = 0x2::bcs::new(arg5);
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        assert!(v1 == 0x2::bcs::peel_address(&mut v2), 7002);
        assert!(0x2::coin::value<T0>(&arg3) == v3 && v3 > 0, 7003);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::pools::collec_fee<T0>(arg2, arg3);
        let v4 = PaymentExecuted{
            owner     : v1,
            amount    : v3,
            req_id    : 0x2::bcs::peel_u128(&mut v2),
            type      : 0x2::bcs::peel_u8(&mut v2),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<PaymentExecuted>(v4);
    }

    public fun prey(arg0: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg3, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg4);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_bird_archive(arg1, v0);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_preying(arg1);
        let (_, _, _, v4, _, _, v7, v8) = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::get_archive(arg1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_bird_energy_v2(arg1, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::get_bird_energy(arg0, v4));
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_boost(arg0, v7);
        let (_, v10, _) = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::get_time_lock(arg0);
        let (v12, v13) = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::set_prey(arg1, 0x2::clock::timestamp_ms(arg2), v10);
        let v14 = PreyEvent{
            owner         : v0,
            bird_type     : v4,
            preying_time  : v12,
            claiming_time : v13,
            rare          : v8,
            boost         : v7,
        };
        0x2::event::emit<PreyEvent>(v14);
    }

    public fun upgrade(arg0: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg5, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        let v0 = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::get_validator(arg0);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::verify_signature(arg2, arg3, &v0);
        let v1 = 0x2::tx_context::sender(arg6);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_bird_archive(arg1, v1);
        let v2 = 0x2::bcs::new(arg3);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        let v4 = 0x2::bcs::peel_u8(&mut v2);
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        assert!(v1 == 0x2::bcs::peel_address(&mut v2), 7002);
        assert!(0x2::clock::timestamp_ms(arg4) < 0x2::bcs::peel_u64(&mut v2), 7004);
        assert!(v4 >= 0 && v4 <= 1, 7001);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_type_tasks(v3);
        let v6 = UpgradeEvent{
            req_id       : 0x2::bcs::peel_u128(&mut v2),
            owner        : v1,
            upgrade_type : v4,
            nonce        : 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::update_nonce(arg1, v3, 0x2::bcs::peel_u128(&mut v2)),
            value        : v5,
            new_value    : 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::set_upgrade(arg1, v4, v5),
        };
        0x2::event::emit<UpgradeEvent>(v6);
    }

    public fun withdraw_bird(arg0: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::Config, arg1: &mut 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::check_version(arg3, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game(), 1);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::validate_paused(arg0, 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, _, _) = 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::config::get_time_lock(arg0);
        0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::reset_archive(arg1);
        let v4 = WithdrawBirdNFTEvent{
            owner           : v0,
            archive         : 0x2::object::id<0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::UserArchive>(arg1),
            bird_type       : 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::validate_bird_archive(arg1, v0),
            withdrawal_time : 0xb13604ecb1fb4f479f42f60f3c0f4fb2a185a07db4ff0bd221f90d6a44290b3::archive::set_time_withdraw_nft(arg1, 0x2::clock::timestamp_ms(arg2), v1),
        };
        0x2::event::emit<WithdrawBirdNFTEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

