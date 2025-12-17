module 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::boosting {
    struct PreSubscribe has key {
        id: 0x2::object::UID,
        paused: bool,
        start_time: u64,
        duration: u64,
        price_per_class: 0x2::table::Table<u8, u64>,
        fee_type: 0x1::type_name::TypeName,
        subscribers: 0x2::vec_set::VecSet<address>,
        subscribers_type: 0x2::table::Table<u8, 0x2::vec_set::VecSet<address>>,
        no_slots: 0x2::table::Table<u8, u16>,
    }

    struct InitPreSubscribeEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
    }

    struct PreSubscribeEvent has copy, drop {
        subscriber: address,
        type: u8,
        amount: u64,
    }

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

    struct ClaimBonusEvent has copy, drop {
        claimer: address,
        amount: u64,
        min_time: u64,
        max_time: u64,
        nonce: u128,
    }

    public fun buying_stars<T0>(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg1: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::GlobalVault, arg2: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::UserArchive, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_signature_v2(arg0, arg4, arg5);
        let v0 = 0x2::tx_context::sender(arg8);
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::validate_archive_owner(arg2, arg8);
        let v1 = 0x2::bcs::new(arg5);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 7000);
        assert!(arg3 > 0 && arg3 == 0x2::bcs::peel_u64(&mut v1), 7001);
        assert!(v2 > 0 && 0x2::balance::value<T0>(&arg6) == v2, 7002);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 7005);
        assert!(0x2::clock::timestamp_ms(arg7) < 0x2::bcs::peel_u64(&mut v1), 7004);
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::deposit_to_vault<T0>(arg1, arg6, arg7);
        let v3 = BuyingStarEvent{
            buyer           : v0,
            number_of_stars : arg3,
            fee             : v2,
            nonce           : 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<BuyingStarEvent>(v3);
    }

    public fun change_fee_type_pre_subscribe<T0>(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::AdminCap, arg1: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: &mut PreSubscribe) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        arg2.fee_type = 0x1::type_name::get<T0>();
    }

    public fun claim_bonus<T0>(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg1: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::GlobalVault, arg2: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::UserArchive, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_signature_v2(arg0, arg6, arg7);
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::validate_archive_owner(arg2, arg9);
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
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::update_time_range(arg2, arg4, arg5);
        let v4 = ClaimBonusEvent{
            claimer  : v0,
            amount   : arg3,
            min_time : arg4,
            max_time : arg5,
            nonce    : 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<ClaimBonusEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::withdraw_from_vault<T0>(arg1, arg3, arg8, arg9), v3);
    }

    public fun claim_commission<T0>(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg1: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::GlobalVault, arg2: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::UserArchive, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_signature_v2(arg0, arg6, arg7);
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::validate_archive_owner(arg2, arg9);
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
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::update_time_range(arg2, arg4, arg5);
        let v4 = CommissionClaimEvent{
            claimer  : v0,
            amount   : arg3,
            min_time : arg4,
            max_time : arg5,
            nonce    : 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u128(&mut v2)),
        };
        0x2::event::emit<CommissionClaimEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::withdraw_from_vault<T0>(arg1, arg3, arg8, arg9), v3);
    }

    public fun deposit_fund_to_vault<T0>(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::TreasureCap, arg1: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::GlobalVault, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::deposit_to_vault<T0>(arg1, arg2, arg3);
    }

    public fun init_pre_subscribe<T0>(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::AdminCap, arg1: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        let v0 = 0x2::table::new<u8, 0x2::vec_set::VecSet<address>>(arg2);
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v0, 0, 0x2::vec_set::empty<address>());
        0x2::table::add<u8, 0x2::vec_set::VecSet<address>>(&mut v0, 1, 0x2::vec_set::empty<address>());
        let v1 = PreSubscribe{
            id               : 0x2::object::new(arg2),
            paused           : true,
            start_time       : 0,
            duration         : 259200000,
            price_per_class  : 0x2::table::new<u8, u64>(arg2),
            fee_type         : 0x1::type_name::get<T0>(),
            subscribers      : 0x2::vec_set::empty<address>(),
            subscribers_type : v0,
            no_slots         : 0x2::table::new<u8, u16>(arg2),
        };
        let v2 = InitPreSubscribeEvent{pre_subscribe: 0x2::object::id<PreSubscribe>(&v1)};
        0x2::event::emit<InitPreSubscribeEvent>(v2);
        0x2::transfer::share_object<PreSubscribe>(v1);
    }

    public fun migrate(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::AdminCap, arg1: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: u64) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::migrate(arg0, arg1, arg2);
    }

    public fun pause_pre_subscribe(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::AdminCap, arg1: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: &mut PreSubscribe, arg3: bool) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg2.paused != arg3, 7001);
        arg2.paused = arg3;
    }

    public fun paused(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::AdminCap, arg1: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: bool) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"BOOSTING_MODULE"), arg2);
    }

    public fun pre_subscribe<T0>(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg1: &mut PreSubscribe, arg2: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::GlobalVault, arg3: u8, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(!arg1.paused, 7006);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg1.start_time && v0 <= arg1.start_time + arg1.duration, 7008);
        assert!(arg3 == 0 || arg3 == 1, 7001);
        let v1 = 0x2::tx_context::sender(arg6);
        if (0x2::vec_set::contains<address>(&arg1.subscribers, &v1)) {
            assert!(arg3 == 1, 7009);
            if (!0x2::vec_set::contains<address>(0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers_type, 0), &v1)) {
                abort 7009
            };
            0x2::vec_set::insert<address>(0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers_type, arg3), v1);
        } else {
            0x2::vec_set::insert<address>(&mut arg1.subscribers, v1);
            0x2::vec_set::insert<address>(0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg1.subscribers_type, arg3), v1);
        };
        assert!(0x2::table::contains<u8, u16>(&arg1.no_slots, arg3) && 0x2::table::contains<u8, u64>(&arg1.price_per_class, arg3), 7001);
        let v2 = 0x2::table::borrow_mut<u8, u16>(&mut arg1.no_slots, arg3);
        let v3 = *0x2::table::borrow<u8, u64>(&arg1.price_per_class, arg3);
        assert!(*v2 > 0, 7007);
        *v2 = *v2 - 1;
        assert!(0x2::balance::value<T0>(&arg4) >= v3, 7002);
        assert!(arg1.fee_type == 0x1::type_name::get<T0>(), 7005);
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::deposit_to_vault<T0>(arg2, arg4, arg5);
        let v4 = PreSubscribeEvent{
            subscriber : 0x2::tx_context::sender(arg6),
            type       : arg3,
            amount     : v3,
        };
        0x2::event::emit<PreSubscribeEvent>(v4);
    }

    public fun register(arg0: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Logs, arg1: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::UserArchive {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::register(arg0, arg1, arg2)
    }

    public fun set_duration_pre_subscribe(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::AdminCap, arg1: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: &mut PreSubscribe, arg3: u64) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg3 >= 0, 7001);
        arg2.duration = arg3;
    }

    public fun set_fund_receiver(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::TreasureCap, arg1: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: address) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::set_fund_receiver(arg0, arg2, arg1);
    }

    public fun set_no_slots_pre_subscribe(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::AdminCap, arg1: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: &mut PreSubscribe, arg3: u8, arg4: u16) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg4 > 0, 7001);
        if (0x2::table::contains<u8, u16>(&arg2.no_slots, arg3)) {
            0x2::table::remove<u8, u16>(&mut arg2.no_slots, arg3);
            0x2::table::add<u8, u16>(&mut arg2.no_slots, arg3, arg4);
        } else {
            0x2::table::add<u8, u16>(&mut arg2.no_slots, arg3, arg4);
        };
    }

    public fun set_price_per_class_pre_subscribe(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::AdminCap, arg1: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: &mut PreSubscribe, arg3: u8, arg4: u64) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg4 > 0, 7001);
        if (0x2::table::contains<u8, u64>(&arg2.price_per_class, arg3)) {
            0x2::table::remove<u8, u64>(&mut arg2.price_per_class, arg3);
            0x2::table::add<u8, u64>(&mut arg2.price_per_class, arg3, arg4);
        } else {
            0x2::table::add<u8, u64>(&mut arg2.price_per_class, arg3, arg4);
        };
    }

    public fun set_start_time_pre_subscribe(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::AdminCap, arg1: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: &mut PreSubscribe, arg3: u64, arg4: &0x2::clock::Clock) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg1, 0x1::string::utf8(b"BOOSTING_MODULE"));
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg4), 7001);
        arg2.start_time = arg3;
    }

    public fun subscribe<T0>(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg1: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::GlobalVault, arg2: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::UserArchive, arg3: u16, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::balance::Balance<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_signature_v2(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg9);
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::validate_archive_owner(arg2, arg9);
        let v1 = 0x2::bcs::new(arg6);
        let v2 = 0x2::bcs::peel_u8(&mut v1);
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 7000);
        assert!(0x2::bcs::peel_u16(&mut v1) == arg3, 7001);
        assert!(v2 == arg4, 7001);
        assert!(v3 > 0 && 0x2::balance::value<T0>(&arg7) == v3, 7002);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 7005);
        assert!(0x2::clock::timestamp_ms(arg8) < 0x2::bcs::peel_u64(&mut v1), 7004);
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::deposit_to_vault<T0>(arg1, arg7, arg8);
        let v4 = SubscriptionEvent{
            subscriber : v0,
            duration   : arg3,
            fee        : v3,
            class      : v2,
            nonce      : 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<SubscriptionEvent>(v4);
    }

    public fun swap_stars<T0>(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg1: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::GlobalVault, arg2: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::UserArchive, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_config(arg0, 0x1::string::utf8(b"BOOSTING_MODULE"));
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::verify_signature_v2(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg8);
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::validate_archive_owner(arg2, arg8);
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
            nonce           : 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::update_user_nonce(arg2, 0x2::bcs::peel_u8(&mut v1), 0x2::bcs::peel_u128(&mut v1)),
        };
        0x2::event::emit<SwappingStarEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::withdraw_from_vault<T0>(arg1, v3, arg7, arg8), v2);
    }

    public fun withdraw_all_from_vault<T0>(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::TreasureCap, arg1: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::GlobalVault, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::withdraw_all_from_vault<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun withdraw_amount_from_vault<T0>(arg0: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::TreasureCap, arg1: &0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::Config, arg2: &mut 0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::GlobalVault, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x4ec2895548225271c661ed7a3f22d7e8b1b72cb626760db648422c15903ab2f0::guild::withdraw_amount_from_vault<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

