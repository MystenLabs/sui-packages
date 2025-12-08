module 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::boosting {
    struct BuyingStarEvent has copy, drop {
        buyer: address,
        number_of_stars: u64,
        fee: u64,
        nonce: u128,
    }

    struct SwappingStarEvent has copy, drop {
        swapper: address,
        number_of_stars: u64,
        received_fee: u64,
        nonce: u128,
    }

    struct SubscriptionEvent has copy, drop {
        subscriber: address,
        duration: u16,
        fee: u64,
        class: u8,
        nonce: u128,
    }

    struct CommissionClaimEvent has copy, drop {
        claimer: address,
        amount: u64,
        min_time: u64,
        max_time: u64,
        nonce: u128,
    }

    public fun buying_stars<T0>(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg1: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::GlobalVault, arg2: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::UserArchive, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::verify_signature_v2(arg0, arg4, arg5);
        let v0 = 0x2::tx_context::sender(arg8);
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::validate_archive_owner(arg2, arg8);
        let v1 = 0x2::bcs::new(arg5);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 7000);
        assert!(arg3 > 0 && arg3 == 0x2::bcs::peel_u64(&mut v1), 7001);
        assert!(v2 > 0 && 0x2::balance::value<T0>(&arg6) == v2, 7002);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 7005);
        assert!(0x2::clock::timestamp_ms(arg7) < 0x2::bcs::peel_u64(&mut v1), 7004);
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::deposit_to_vault<T0>(arg1, arg6, arg7);
        let v3 = BuyingStarEvent{
            buyer           : v0,
            number_of_stars : arg3,
            fee             : v2,
            nonce           : 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<BuyingStarEvent>(v3);
    }

    public fun claim_commission<T0>(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg1: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::GlobalVault, arg2: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::UserArchive, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::verify_signature_v2(arg0, arg6, arg7);
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::validate_archive_owner(arg2, arg9);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(v1 >= arg5 && arg5 >= arg4, 7001);
        let v2 = 0x2::bcs::new(arg7);
        let v3 = 0x2::bcs::peel_address(&mut v2);
        assert!(v0 == v3, 7000);
        assert!(arg3 > 0 && 0x2::bcs::peel_u64(&mut v2) == arg3, 7002);
        assert!(0x2::bcs::peel_u64(&mut v2) == arg4 && 0x2::bcs::peel_u64(&mut v2) == arg5, 7001);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 7005);
        assert!(v1 < 0x2::bcs::peel_u64(&mut v2), 7004);
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::update_time_range(arg2, arg4, arg5);
        let v4 = CommissionClaimEvent{
            claimer  : v0,
            amount   : arg3,
            min_time : arg4,
            max_time : arg5,
            nonce    : 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<CommissionClaimEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::withdraw_from_vault<T0>(arg1, arg3, arg8, arg9), v3);
    }

    public fun deposit_fund_to_vault<T0>(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::TreasureCap, arg1: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::GlobalVault, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::deposit_to_vault<T0>(arg1, arg2, arg3);
    }

    public fun migrate(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::AdminCap, arg1: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg2: u64) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::migrate(arg0, arg1, arg2);
    }

    public fun paused(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::AdminCap, arg1: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg2: bool) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"BOOSTING_MODULE"), arg2);
    }

    public fun set_fund_receiver(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::TreasureCap, arg1: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg2: address) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::set_fund_receiver(arg0, arg2, arg1);
    }

    public fun subscribe<T0>(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg1: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::GlobalVault, arg2: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::UserArchive, arg3: u16, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::balance::Balance<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::verify_signature_v2(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg9);
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::validate_archive_owner(arg2, arg9);
        let v1 = 0x2::bcs::new(arg6);
        let v2 = 0x2::bcs::peel_u8(&mut v1);
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 7000);
        assert!(0x2::bcs::peel_u16(&mut v1) == arg3, 7001);
        assert!(v2 == arg4, 7001);
        assert!(v3 > 0 && 0x2::balance::value<T0>(&arg7) == v3, 7002);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 7005);
        assert!(0x2::clock::timestamp_ms(arg8) < 0x2::bcs::peel_u64(&mut v1), 7004);
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::deposit_to_vault<T0>(arg1, arg7, arg8);
        let v4 = SubscriptionEvent{
            subscriber : v0,
            duration   : arg3,
            fee        : v3,
            class      : v2,
            nonce      : 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<SubscriptionEvent>(v4);
    }

    public fun swap_stars<T0>(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg1: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::GlobalVault, arg2: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::UserArchive, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::verify_signature_v2(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg8);
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::validate_archive_owner(arg2, arg8);
        let v1 = 0x2::bcs::new(arg6);
        let v2 = 0x2::bcs::peel_address(&mut v1);
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == v2, 7000);
        assert!(arg3 > 0 && 0x2::bcs::peel_u64(&mut v1) == arg3, 7001);
        assert!(v3 > 0 && arg4 == v3, 7002);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 7005);
        assert!(0x2::clock::timestamp_ms(arg7) < 0x2::bcs::peel_u64(&mut v1), 7004);
        let v4 = SwappingStarEvent{
            swapper         : v0,
            number_of_stars : arg3,
            received_fee    : v3,
            nonce           : 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<SwappingStarEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::withdraw_from_vault<T0>(arg1, v3, arg7, arg8), v2);
    }

    public fun withdraw_all_from_vault<T0>(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::TreasureCap, arg1: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg2: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::GlobalVault, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::withdraw_all_from_vault<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun withdraw_amount_from_vault<T0>(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::TreasureCap, arg1: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg2: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::GlobalVault, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::withdraw_amount_from_vault<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

