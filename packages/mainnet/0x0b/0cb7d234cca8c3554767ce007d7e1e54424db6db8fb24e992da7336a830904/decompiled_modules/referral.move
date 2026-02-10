module 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::referral {
    struct ReferralRecordedEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        referee: address,
        referer: address,
    }

    struct Referral has store, key {
        id: 0x2::object::UID,
        is_claim_paused: bool,
        code_owner: 0x2::table::Table<0x1::string::String, address>,
        referrer_code: 0x2::table::Table<address, 0x1::string::String>,
        referee_to_code: 0x2::table::Table<address, 0x1::string::String>,
        referrer_discount_bps: u64,
        referee_discount_bps: u64,
        referrer_deposit_usd_threshold: u64,
        accumulated_deposit_only_usd: 0x2::table::Table<address, u64>,
        user_rebates_records: 0x2::table::Table<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>,
        rebates: 0x2::bag::Bag,
    }

    fun new(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Referral {
        Referral{
            id                             : 0x2::object::new(arg3),
            is_claim_paused                : false,
            code_owner                     : 0x2::table::new<0x1::string::String, address>(arg3),
            referrer_code                  : 0x2::table::new<address, 0x1::string::String>(arg3),
            referee_to_code                : 0x2::table::new<address, 0x1::string::String>(arg3),
            referrer_discount_bps          : arg0,
            referee_discount_bps           : arg1,
            referrer_deposit_usd_threshold : arg2,
            accumulated_deposit_only_usd   : 0x2::table::new<address, u64>(arg3),
            user_rebates_records           : 0x2::table::new<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(arg3),
            rebates                        : 0x2::bag::new(arg3),
        }
    }

    public(friend) fun claim_rebates<T0>(arg0: &mut Referral, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_claim_paused, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::referral_claim_paused());
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&arg0.user_rebates_records, v0), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::referral_no_rebates());
        let v2 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut arg0.user_rebates_records, v0);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v2, &v1), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::referral_rebate_no_token());
        let v3 = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(v2, &v1);
        assert!(v3 != 0, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::referral_claim_zero_value_rebate());
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(v2, &v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rebates, v1), v3), arg1)
    }

    public(friend) fun default(arg0: &mut 0x2::tx_context::TxContext) : Referral {
        new(1000, 400, 10000, arg0)
    }

    fun generate_random_string(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = 0x2::random::generate_u8(&mut v0) % 36;
            let v4 = if (v3 < 10) {
                48 + v3
            } else {
                87 + v3
            };
            0x1::vector::push_back<u8>(&mut v1, v4);
            v2 = v2 + 1;
        };
        0x1::string::utf8(v1)
    }

    public(friend) fun generate_referral_code(arg0: &mut Referral, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.referrer_code, v0)) {
            abort 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::referral_already_has_referral_code()
        };
        assert!(is_qualified_to_create_referral_code(arg0, v0), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::referral_not_qualified_to_gen_code());
        let v1 = generate_random_string(arg1, 6, arg2);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.code_owner, v1), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::referral_invalid_referral_code());
        0x2::table::add<0x1::string::String, address>(&mut arg0.code_owner, v1, v0);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.referrer_code, v0, v1);
    }

    public(friend) fun get_linked_referral_code(arg0: &Referral, arg1: address) : 0x1::option::Option<0x1::string::String> {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.referee_to_code, arg1)) {
            0x1::option::some<0x1::string::String>(*0x2::table::borrow<address, 0x1::string::String>(&arg0.referee_to_code, arg1))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public(friend) fun get_referral_code(arg0: &Referral, arg1: address) : 0x1::string::String {
        assert!(has_referral_code(arg0, arg1), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::referral_no_referral_code());
        *0x2::table::borrow<address, 0x1::string::String>(&arg0.referrer_code, arg1)
    }

    public(friend) fun has_referral_code(arg0: &Referral, arg1: address) : bool {
        0x2::table::contains<address, 0x1::string::String>(&arg0.referrer_code, arg1)
    }

    public(friend) fun increase_usd_qualification(arg0: &mut Referral, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, u64>(&arg0.accumulated_deposit_only_usd, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.accumulated_deposit_only_usd, arg1, arg2);
            return
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.accumulated_deposit_only_usd, arg1);
        if (*v0 > arg0.referrer_deposit_usd_threshold) {
            return
        };
        *v0 = *v0 + arg2;
    }

    public(friend) fun is_qualified_to_create_referral_code(arg0: &Referral, arg1: address) : bool {
        if (!0x2::table::contains<address, u64>(&arg0.accumulated_deposit_only_usd, arg1)) {
            return false
        };
        *0x2::table::borrow<address, u64>(&arg0.accumulated_deposit_only_usd, arg1) >= arg0.referrer_deposit_usd_threshold
    }

    fun join_rebate_balance<T0>(arg0: &mut Referral, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rebates, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rebates, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rebates, v0, arg1);
        };
    }

    public(friend) fun list_rebates(arg0: &Referral, arg1: address) : (vector<0x1::type_name::TypeName>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0x1::vector::empty<u64>();
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&arg0.user_rebates_records, arg1)) {
            return (v0, v1)
        };
        let v2 = 0x2::table::borrow<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&arg0.user_rebates_records, arg1);
        let v3 = 0x2::vec_map::keys<0x1::type_name::TypeName, u64>(v2);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            let v5 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v5);
            0x1::vector::push_back<u64>(&mut v1, *0x2::vec_map::get<0x1::type_name::TypeName, u64>(v2, &v5));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v3);
        (v0, v1)
    }

    fun look_up_code_owner(arg0: &Referral, arg1: 0x1::string::String) : address {
        *0x2::table::borrow<0x1::string::String, address>(&arg0.code_owner, arg1)
    }

    fun record_user_rebates<T0>(arg0: &mut Referral, arg1: address, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&arg0.user_rebates_records, arg1)) {
            let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v1, v0, arg2);
            0x2::table::add<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut arg0.user_rebates_records, arg1, v1);
            return
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>>(&mut arg0.user_rebates_records, arg1);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v2, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(v2, v0, arg2);
            return
        };
        let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(v2, &v0);
        *v3 = *v3 + arg2;
    }

    public(friend) fun track_flash_loan_usage<T0>(arg0: &mut Referral, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.code_owner, arg2), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::referral_invalid_referral_code());
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = look_up_code_owner(arg0, arg2);
        let v2 = v0 * arg0.referee_discount_bps / 10000;
        let v3 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, (v0 - v2) * arg0.referrer_discount_bps / 10000, arg4));
        update_user_rebate<T0>(arg0, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v2, arg4)));
        let v4 = ReferralRecordedEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::balance::value<T0>(&v3),
            referee   : arg3,
            referer   : v1,
        };
        0x2::event::emit<ReferralRecordedEvent>(v4);
        update_user_rebate<T0>(arg0, v1, v3);
        arg1
    }

    public(friend) fun try_map_referral_code(arg0: &mut Referral, arg1: address, arg2: 0x1::option::Option<0x1::string::String>) : 0x1::option::Option<0x1::string::String> {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.referee_to_code, arg1)) {
            return 0x1::option::some<0x1::string::String>(*0x2::table::borrow<address, 0x1::string::String>(&arg0.referee_to_code, arg1))
        };
        if (0x1::option::is_none<0x1::string::String>(&arg2)) {
            return arg2
        };
        let v0 = *0x1::option::borrow<0x1::string::String>(&arg2);
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.code_owner, v0), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::referral_invalid_referral_code());
        assert!(0x2::table::borrow<0x1::string::String, address>(&arg0.code_owner, v0) != &arg1, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::referral_no_self_reference());
        0x2::table::add<address, 0x1::string::String>(&mut arg0.referee_to_code, arg1, v0);
        arg2
    }

    public(friend) fun update_claim_pause(arg0: &mut Referral, arg1: bool) {
        assert!(arg0.is_claim_paused != arg1, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::updating_with_same_value());
        arg0.is_claim_paused = arg1;
    }

    public(friend) fun update_referral_params(arg0: &mut Referral, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 < 10000, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        assert!(arg2 < 10000, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        assert!(arg3 > 0, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        arg0.referrer_discount_bps = arg1;
        arg0.referee_discount_bps = arg2;
        arg0.referrer_deposit_usd_threshold = arg3;
    }

    fun update_user_rebate<T0>(arg0: &mut Referral, arg1: address, arg2: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        record_user_rebates<T0>(arg0, arg1, 0x2::balance::value<T0>(&arg2));
        join_rebate_balance<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

