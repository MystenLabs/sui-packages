module 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct FeedWormEvent has copy, drop {
        owner: address,
        bird: 0x2::object::ID,
        bird_type: u16,
        bird_energy: u64,
        worm: 0x2::object::ID,
        worm_type: u16,
        worm_energy: u64,
        preying_energy: u64,
    }

    struct PreyEvent has copy, drop {
        owner: address,
        bird: 0x2::object::ID,
        bird_type: u16,
        preying_time: u64,
        claiming_time: u64,
        boost: u64,
        preying_counts: u128,
    }

    struct ClaimPreyRewardEvent has copy, drop {
        owner: address,
        bird: 0x2::object::ID,
        bird_type: u16,
        reward: u64,
        bonus: u64,
        preying_counts: u128,
    }

    struct SetBoostEvent has copy, drop {
        req_id: u128,
        owner: address,
        upgrade_type: u8,
        nonce: u128,
        old_value: u64,
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
        bird: 0x2::object::ID,
        bird_type: u16,
        withdrawal_time: u64,
    }

    struct PaymentExecuted has copy, drop {
        owner: address,
        pool: address,
        fee: u64,
        req_id: u128,
        amount: u64,
        type: u8,
        nonce: u128,
        sig: vector<u8>,
        coin_type: 0x1::type_name::TypeName,
    }

    struct DepositMatingBirdEvent has copy, drop {
        owner: address,
        archive: 0x2::object::ID,
        mating_bird: 0x2::object::ID,
        mating_bird_type: u16,
        mating_bird_sub_type: u8,
    }

    struct WithdrawMatingBirdEvent has copy, drop {
        owner: address,
        archive: 0x2::object::ID,
        mating_bird: 0x2::object::ID,
    }

    struct DrinkLovePotion has copy, drop {
        owner: address,
        bird: 0x2::object::ID,
        mating_bird: 0x2::object::ID,
        potion_type: u16,
        potion_energy: u64,
        mating_energy: u64,
        nonce: u128,
    }

    struct MatingEvent has copy, drop {
        owner: address,
        bird_type: u16,
        bird: 0x2::object::ID,
        mating_bird: 0x2::object::ID,
        mating_time: u64,
        claiming_mating_time: u64,
        user_mating_count: u64,
        bird_nft_mating_count: u64,
        bird_mating_left: u64,
        mating_bird_nft_mating_count: u64,
        mating_bird_mating_left: u64,
    }

    struct ClaimMatingRewardEvent has copy, drop {
        owner: address,
        bird_type: u16,
        bird: 0x2::object::ID,
        mating_bird: 0x2::object::ID,
        mating_count: u64,
    }

    public fun withdraw_bird(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg3, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg4);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::ensure_not_mating(arg1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::ensure_not_preying(arg1);
        let v1 = WithdrawBirdNFTEvent{
            owner           : v0,
            archive         : 0x2::object::id<0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive>(arg1),
            bird            : 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::withdraw_bird(arg1),
            bird_type       : 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::validate_bird_archive(arg1, v0),
            withdrawal_time : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawBirdNFTEvent>(v1);
    }

    public fun withdraw_mating_bird(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg2, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::ensure_not_mating(arg1);
        let v0 = WithdrawMatingBirdEvent{
            owner       : 0x2::tx_context::sender(arg3),
            archive     : 0x2::object::id<0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive>(arg1),
            mating_bird : 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::withdraw_mating_bird(arg1),
        };
        0x2::event::emit<WithdrawMatingBirdEvent>(v0);
    }

    public fun claim_mating_reward(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg3, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        let (v0, v1, v2, v3) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::clear_mating_session(arg1, 0x2::clock::timestamp_ms(arg2));
        let v4 = ClaimMatingRewardEvent{
            owner        : 0x2::tx_context::sender(arg4),
            bird_type    : v0,
            bird         : v2,
            mating_bird  : v3,
            mating_count : v1,
        };
        0x2::event::emit<ClaimMatingRewardEvent>(v4);
    }

    public fun claim_prey_reward<T0, T1>(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::pools::RewardPoolGame<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg4, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::validate_bird_archive(arg1, v0);
        let (v2, v3) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_prey_reward(arg0, v1);
        let (_, v5) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::get_boost(arg1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::pools::validate_reward_pool_game<T0, T1>(arg2, v2, v3, v5);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::pools::transfer_reward_game<T0, T1>(arg2, v2, v3, v5, v0, arg5);
        let (v6, v7) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::clear_preying_session(arg1, 0x2::clock::timestamp_ms(arg3), v2, v3);
        let v8 = ClaimPreyRewardEvent{
            owner          : v0,
            bird           : v7,
            bird_type      : v1,
            reward         : v2,
            bonus          : v3,
            preying_counts : v6,
        };
        0x2::event::emit<ClaimPreyRewardEvent>(v8);
    }

    public fun deposit_bird(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT, arg3: &0x2::clock::Clock, arg4: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg4, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg5);
        let (_, v2, v3, _, _, _) = 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::info(&arg2);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_bird_type(arg0, v2);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::fill_bird(arg1, v0, 0x2::clock::timestamp_ms(arg3), v2, arg2);
        let v7 = DepositBirdNFTEvent{
            owner         : v0,
            archive       : 0x2::object::id<0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive>(arg1),
            bird          : 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg2),
            bird_type     : v2,
            bird_sub_type : v3,
        };
        0x2::event::emit<DepositBirdNFTEvent>(v7);
    }

    public fun deposit_mating_bird(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT, arg3: &0x2::clock::Clock, arg4: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg4, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        let (_, v1, v2, _, _, _) = 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::info(&arg2);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::fill_mating_bird(arg1, arg2, v1, v2, 0x2::clock::timestamp_ms(arg3));
        let v6 = DepositMatingBirdEvent{
            owner                : 0x2::tx_context::sender(arg5),
            archive              : 0x2::object::id<0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive>(arg1),
            mating_bird          : 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg2),
            mating_bird_type     : v1,
            mating_bird_sub_type : v2,
        };
        0x2::event::emit<DepositMatingBirdEvent>(v6);
    }

    public fun drink_love_potion(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg5, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_validator(arg0);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::verify_signature(arg2, arg3, &v1);
        let v2 = 0x2::bcs::new(arg3);
        let _ = 0x2::bcs::peel_u128(&mut v2);
        let v4 = 0x2::bcs::peel_u16(&mut v2);
        assert!(v0 == 0x2::bcs::peel_address(&mut v2), 7002);
        assert!(0x2::clock::timestamp_ms(arg4) < 0x2::bcs::peel_u64(&mut v2), 7004);
        let v5 = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::validate_bird_archive(arg1, v0);
        assert!(v5 == v4, 7001);
        let v6 = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_energy(arg0, 2002, v4);
        let (v7, v8, v9) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::set_mating_energy(arg1, v6, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_energy(arg0, 2001, v5));
        let v10 = DrinkLovePotion{
            owner         : v0,
            bird          : v8,
            mating_bird   : v9,
            potion_type   : v4,
            potion_energy : v6,
            mating_energy : v7,
            nonce         : 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::update_nonce(arg1, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<DrinkLovePotion>(v10);
    }

    public fun feed_worm(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: 0x3004a1c316760c6dec255ed49c5e551390e542f626d09cfbcf2d9305baf7351e::nft::BirdNFT, arg3: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg3, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::ensure_not_preying(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::validate_bird_archive(arg1, v0);
        let (v2, _, _, v5, _, _) = 0x3004a1c316760c6dec255ed49c5e551390e542f626d09cfbcf2d9305baf7351e::nft::info(&arg2);
        assert!(v1 == v5, 7001);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_worm_type(arg0, v5);
        let v8 = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_energy(arg0, 2003, v1);
        let v9 = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_energy(arg0, 2004, v5);
        let (v10, v11) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::set_preying_energy(arg1, v9, v8);
        0x3004a1c316760c6dec255ed49c5e551390e542f626d09cfbcf2d9305baf7351e::nft::burn(arg2, arg4);
        let v12 = FeedWormEvent{
            owner          : v0,
            bird           : v11,
            bird_type      : v1,
            bird_energy    : v8,
            worm           : v2,
            worm_type      : v5,
            worm_energy    : v9,
            preying_energy : v10,
        };
        0x2::event::emit<FeedWormEvent>(v12);
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun mating(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg3, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::ensure_not_mating(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::validate_bird_archive(arg1, v0);
        let (_, _, v4) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_time_lock(arg0);
        let (v5, v6, v7, v8, v9, v10, v11, v12, v13) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::start_mating_session(arg1, 0x2::clock::timestamp_ms(arg2), v4, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_energy(arg0, 2001, v1));
        let v14 = MatingEvent{
            owner                        : v0,
            bird_type                    : v1,
            bird                         : v12,
            mating_bird                  : v13,
            mating_time                  : v5,
            claiming_mating_time         : v6,
            user_mating_count            : v7,
            bird_nft_mating_count        : v8,
            bird_mating_left             : v9,
            mating_bird_nft_mating_count : v10,
            mating_bird_mating_left      : v11,
        };
        0x2::event::emit<MatingEvent>(v14);
    }

    public fun payment<T0>(arg0: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::pools::FeePool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg7, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        let v0 = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_validator(arg0);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::verify_signature(arg4, arg5, &v0);
        let v1 = 0x2::tx_context::sender(arg8);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::validate_bird_archive(arg1, v1);
        let v2 = 0x2::bcs::new(arg5);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        let v5 = 0x2::bcs::peel_address(&mut v2);
        assert!(v1 == 0x2::bcs::peel_address(&mut v2), 7002);
        assert!(0x2::clock::timestamp_ms(arg6) < 0x2::bcs::peel_u64(&mut v2), 7004);
        assert!(v5 == 0x2::object::id_address<0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::pools::FeePool<T0>>(arg2), 7001);
        assert!(0x2::coin::value<T0>(&arg3) == v4 && v4 > 0, 7003);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::pools::collect_fee<T0>(arg2, arg3);
        let v6 = PaymentExecuted{
            owner     : v1,
            pool      : v5,
            fee       : v4,
            req_id    : 0x2::bcs::peel_u128(&mut v2),
            amount    : 0x2::bcs::peel_u64(&mut v2),
            type      : v3,
            nonce     : 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::update_nonce(arg1, v3, 0x2::bcs::peel_u128(&mut v2)),
            sig       : arg4,
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<PaymentExecuted>(v6);
    }

    public fun prey(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg3, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg4);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::validate_bird_archive(arg1, v0);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::ensure_not_preying(arg1);
        let (_, _, _, v4, _, v6, _) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::get_archive(arg1);
        let (_, v9, _) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_time_lock(arg0);
        let (v11, v12, v13, v14) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::start_prey_session(arg1, 0x2::clock::timestamp_ms(arg2), v9, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_energy(arg0, 2003, v4));
        let v15 = PreyEvent{
            owner          : v0,
            bird           : v14,
            bird_type      : v4,
            preying_time   : v11,
            claiming_time  : v12,
            boost          : v6,
            preying_counts : v13,
        };
        0x2::event::emit<PreyEvent>(v15);
    }

    public fun set_boost(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg5, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game(), 1);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg0, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_game());
        let v0 = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::get_validator(arg0);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::verify_signature(arg2, arg3, &v0);
        let v1 = 0x2::tx_context::sender(arg6);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::validate_bird_archive(arg1, v1);
        let v2 = 0x2::bcs::new(arg3);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        assert!(v1 == 0x2::bcs::peel_address(&mut v2), 7002);
        assert!(0x2::clock::timestamp_ms(arg4) < 0x2::bcs::peel_u64(&mut v2), 7004);
        assert!(v3 >= 0 && v3 <= 1, 7001);
        let (v4, v5) = 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::set_upgrade_boost(arg1, v3, 0x2::bcs::peel_u64(&mut v2));
        let v6 = SetBoostEvent{
            req_id       : 0x2::bcs::peel_u128(&mut v2),
            owner        : v1,
            upgrade_type : v3,
            nonce        : 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::update_nonce(arg1, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u128(&mut v2)),
            old_value    : v4,
            new_value    : v5,
        };
        0x2::event::emit<SetBoostEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

