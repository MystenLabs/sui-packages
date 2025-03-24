module 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct FeedWormEvent has copy, drop {
        owner: address,
        bird_type: u8,
        energy: u64,
        worm_type: u16,
        worm_energy: u64,
    }

    struct PreyEvent has copy, drop {
        owner: address,
        bird_type: u8,
        preying_time: u64,
        claiming_time: u64,
        rare: u8,
        boost: u64,
    }

    struct ClaimPreyRewardEvent has copy, drop {
        req_id: u128,
        owner: address,
        reward: u64,
        bonus: u64,
        nonce: u128,
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
        bird_type: u8,
    }

    struct WithdrawBirdNFTEvent has copy, drop {
        owner: address,
        archive: 0x2::object::ID,
        bird_type: u8,
        withdrawal_time: u64,
    }

    struct ClaimBirdNFTEvent has copy, drop {
        owner: address,
        archive: 0x2::object::ID,
        bird: 0x2::object::ID,
        bird_type: u8,
    }

    public fun claim_bird(arg0: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::Config, arg1: &mut 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::check_version(arg3, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game(), 1);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::validate_paused(arg0, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg4);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_claim_bird(arg1, 0x2::clock::timestamp_ms(arg2));
        let v1 = ClaimBirdNFTEvent{
            owner     : v0,
            archive   : 0x2::object::id<0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::UserArchive>(arg1),
            bird      : 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::transfer_bird(arg1, v0),
            bird_type : 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_bird_archive(arg1, v0),
        };
        0x2::event::emit<ClaimBirdNFTEvent>(v1);
    }

    public fun claim_prey_reward<T0, T1>(arg0: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::Config, arg1: &mut 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::UserArchive, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::pools::RewardPoolGame<T0, T1>, arg5: &0x2::clock::Clock, arg6: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::check_version(arg6, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game(), 1);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::validate_paused(arg0, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game());
        let v0 = 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::get_validator(arg0);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::verify_signature(arg2, arg3, &v0);
        let v1 = 0x2::tx_context::sender(arg7);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_bird_archive(arg1, v1);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_claim_reward_prey(arg1, 0x2::clock::timestamp_ms(arg5));
        let v2 = 0x2::bcs::new(arg3);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        assert!(v1 == 0x2::bcs::peel_address(&mut v2), 7002);
        assert!(v4 > 0 && v5 > 0, 7003);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_type_tasks(v3);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::pools::validate_reward_pool_game<T0, T1>(arg4, v4, v5);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::pools::transfer_reward_game<T0, T1>(arg4, v4, v5, v1, arg7);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::reset_preying(arg1);
        let v6 = ClaimPreyRewardEvent{
            req_id : 0x2::bcs::peel_u128(&mut v2),
            owner  : v1,
            reward : v4,
            bonus  : v5,
            nonce  : 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::update_nonce(arg1, v3, 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<ClaimPreyRewardEvent>(v6);
    }

    public fun deposit_bird(arg0: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::Config, arg1: &mut 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::UserArchive, arg2: 0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT, arg3: &0x2::clock::Clock, arg4: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::check_version(arg4, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game(), 1);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::validate_paused(arg0, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg5);
        let (_, v2, _) = 0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::info(&arg2);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::validate_bird_type(arg0, v2);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_deposit_bird(arg1, v0);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::fill_bird(arg1, 0x2::clock::timestamp_ms(arg3), v2, arg2);
        let v4 = DepositBirdNFTEvent{
            owner     : v0,
            archive   : 0x2::object::id<0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::UserArchive>(arg1),
            bird      : 0x2::object::id<0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT>(&arg2),
            bird_type : v2,
        };
        0x2::event::emit<DepositBirdNFTEvent>(v4);
    }

    public fun feed_worm(arg0: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::Config, arg1: &mut 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::UserArchive, arg2: 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFT, arg3: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::check_version(arg3, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game(), 1);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::validate_paused(arg0, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game());
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_preying(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_bird_archive(arg1, v0);
        let (_, _, v4, _, _, _) = 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::info(&arg2);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::validate_worm_type(arg0, v4);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_bird_energy(arg1, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::get_bird_energy(arg0, v1));
        let v8 = 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::get_worm_energy(arg0, v4);
        0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::burn(arg2, arg4);
        let v9 = FeedWormEvent{
            owner       : v0,
            bird_type   : v1,
            energy      : 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::set_energy(arg1, v8),
            worm_type   : v4,
            worm_energy : v8,
        };
        0x2::event::emit<FeedWormEvent>(v9);
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun prey(arg0: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::Config, arg1: &mut 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::check_version(arg3, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game(), 1);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::validate_paused(arg0, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg4);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_bird_archive(arg1, v0);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_preying(arg1);
        let (_, _, _, v4, _, _, v7, v8) = 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::get_archive(arg1);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_bird_energy_v2(arg1, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::get_bird_energy(arg0, v4));
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::validate_boost(arg0, v7);
        let (_, v10) = 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::get_time_lock(arg0);
        let (v11, v12) = 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::set_prey(arg1, 0x2::clock::timestamp_ms(arg2), v10);
        let v13 = PreyEvent{
            owner         : v0,
            bird_type     : v4,
            preying_time  : v11,
            claiming_time : v12,
            rare          : v8,
            boost         : v7,
        };
        0x2::event::emit<PreyEvent>(v13);
    }

    public fun upgrade(arg0: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::Config, arg1: &mut 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::UserArchive, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::check_version(arg4, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game(), 1);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::validate_paused(arg0, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game());
        let v0 = 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::get_validator(arg0);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::verify_signature(arg2, arg3, &v0);
        let v1 = 0x2::tx_context::sender(arg5);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_bird_archive(arg1, v1);
        let v2 = 0x2::bcs::new(arg3);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        let v4 = 0x2::bcs::peel_u8(&mut v2);
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        assert!(v1 == 0x2::bcs::peel_address(&mut v2), 7002);
        assert!(v4 >= 0 && v4 <= 1, 7001);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_type_tasks(v3);
        let v6 = UpgradeEvent{
            req_id       : 0x2::bcs::peel_u128(&mut v2),
            owner        : v1,
            upgrade_type : v4,
            nonce        : 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::update_nonce(arg1, v3, 0x2::bcs::peel_u128(&mut v2)),
            value        : v5,
            new_value    : 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::set_upgrade(arg1, v4, v5),
        };
        0x2::event::emit<UpgradeEvent>(v6);
    }

    public fun withdraw_bird(arg0: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::Config, arg1: &mut 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::UserArchive, arg2: &0x2::clock::Clock, arg3: &0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::check_version(arg3, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game(), 1);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::validate_paused(arg0, 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::version::module_type_game());
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, _) = 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::config::get_time_lock(arg0);
        0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::reset_archive(arg1);
        let v3 = WithdrawBirdNFTEvent{
            owner           : v0,
            archive         : 0x2::object::id<0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::UserArchive>(arg1),
            bird_type       : 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::validate_bird_archive(arg1, v0),
            withdrawal_time : 0xe637c0d19def5f6fffebea2131f1413175c25d95aa6de3fa130b25db2b882091::archive::set_time_withdraw_nft(arg1, 0x2::clock::timestamp_ms(arg2), v1),
        };
        0x2::event::emit<WithdrawBirdNFTEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

