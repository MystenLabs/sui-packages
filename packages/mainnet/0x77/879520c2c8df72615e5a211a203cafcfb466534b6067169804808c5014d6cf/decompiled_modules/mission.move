module 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::mission {
    struct MISSION has drop {
        dummy_field: bool,
    }

    struct RewardClaimedEvent has copy, drop {
        type: u8,
        owner: address,
        rw_id: u128,
        pool_id: address,
        amount: u64,
        nonce: u128,
    }

    struct DepositEvent has copy, drop {
        user: address,
        task_slug: 0x1::string::String,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun claim_reward<T0>(arg0: &0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::config::Config, arg1: &mut 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::archive::UserArchive, arg2: &mut 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::pools::RewardPool<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::check_version(arg6, 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::module_type_mission(), 1);
        0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::config::validate_paused(arg0, 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::module_type_mission());
        let v0 = 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::config::get_validator(arg0);
        0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::config::verify_signature(arg3, arg4, &v0);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = 0x2::bcs::new(arg4);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        let v4 = 0x2::bcs::peel_address(&mut v2);
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::archive::validate_bird_archive(arg1, v1);
        assert!(v1 == 0x2::bcs::peel_address(&mut v2), 6000);
        assert!(0x2::clock::timestamp_ms(arg5) < 0x2::bcs::peel_u64(&mut v2), 6003);
        assert!(0x2::object::id_address<0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::pools::RewardPool<T0>>(arg2) == v4, 6002);
        assert!(v5 > 0, 6001);
        assert!((0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::pools::get_reward_balance<T0>(arg2) as u64) >= v5, 6001);
        0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::pools::transfer_mission_reward<T0>(arg1, arg2, v5, v1, arg7);
        let v6 = RewardClaimedEvent{
            type    : v3,
            owner   : v1,
            rw_id   : 0x2::bcs::peel_u128(&mut v2),
            pool_id : v4,
            amount  : v5,
            nonce   : 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::archive::update_nonce(arg1, v3, 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<RewardClaimedEvent>(v6);
    }

    public fun deposit<T0>(arg0: &0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::config::Config, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::check_version(arg3, 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::module_type_mission(), 1);
        0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::config::validate_paused(arg0, 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::module_type_mission());
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 6001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        let v2 = DepositEvent{
            user      : v0,
            task_slug : 0x1::string::utf8(arg1),
            amount    : v1,
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    fun init(arg0: MISSION, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

