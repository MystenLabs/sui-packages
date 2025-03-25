module 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::mission {
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
        from: address,
        amount: u64,
        type_token: 0x1::type_name::TypeName,
    }

    public fun claim_reward<T0>(arg0: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::config::Config, arg1: &mut 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::archive::UserArchive, arg2: &mut 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::pools::RewardPool<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::check_version(arg5, 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::module_type_mission(), 1);
        0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::config::validate_paused(arg0, 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::module_type_mission());
        let v0 = 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::config::get_validator(arg0);
        0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::config::verify_signature(arg3, arg4, &v0);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::bcs::new(arg4);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        let v4 = 0x2::bcs::peel_address(&mut v2);
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::archive::validate_bird_archive(arg1, v1);
        0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::archive::validate_type_tasks(v3);
        assert!(v1 == 0x2::bcs::peel_address(&mut v2), 6000);
        assert!(0x2::object::id_address<0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::pools::RewardPool<T0>>(arg2) == v4, 60002);
        assert!(v5 > 0, 6001);
        assert!((0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::pools::get_reward_balance<T0>(arg2) as u64) >= v5, 6001);
        0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::pools::transfer_reward_misson<T0>(arg2, v5, v1, arg6);
        let v6 = RewardClaimedEvent{
            type    : v3,
            owner   : v1,
            rw_id   : 0x2::bcs::peel_u128(&mut v2),
            pool_id : v4,
            amount  : v5,
            nonce   : 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::archive::update_nonce(arg1, v3, 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<RewardClaimedEvent>(v6);
    }

    public fun deposit<T0>(arg0: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: &0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::check_version(arg2, 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::module_type_mission(), 1);
        0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::config::validate_paused(arg0, 0xe3c5bdf6e59bd3e95cf42c1a673e9cb599aa20ba2739f978bfe6b7ebfb316fb7::version::module_type_mission());
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 6001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v2 = DepositEvent{
            from       : v0,
            amount     : v1,
            type_token : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    fun init(arg0: MISSION, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

