module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::spend {
    struct T2000 has drop {
        dummy_field: bool,
    }

    struct Ceilings has key {
        id: 0x2::object::UID,
        ceilings: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct FunderKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct NoDecryptKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct AllowanceAcceptedV1 has copy, drop {
        funder: address,
        spender: address,
        name: 0x1::string::String,
        lifetime_cap: 0x1::option::Option<u256>,
        start_timestamp_ms: 0x1::option::Option<u64>,
        expiration_timestamp_ms: 0x1::option::Option<u64>,
        rate_limit: 0x1::option::Option<0x2::allowance::RateLimit>,
    }

    struct CeilingSetV1 has copy, drop {
        allowance: 0x2::object::ID,
        funder: address,
        ceiling: u64,
    }

    struct CeilingClearedV1 has copy, drop {
        allowance: 0x2::object::ID,
        funder: address,
    }

    struct SpentV1 has copy, drop {
        allowance: 0x2::object::ID,
        job: 0x2::object::ID,
        amount: u64,
    }

    struct MachineKeyRotatedV1 has copy, drop {
        allowance: 0x2::object::ID,
        number: u64,
        spender: address,
    }

    struct NoDecryptSetV1 has copy, drop {
        allowance: 0x2::object::ID,
        funder: address,
        no_decrypt: bool,
    }

    public fun accept(arg0: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &mut 0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        let v0 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg0);
        let v1 = AllowanceAcceptedV1{
            funder                  : 0x2::allowance::funder(v0),
            spender                 : 0x1::option::destroy_some<address>(0x2::allowance::spender(v0)),
            name                    : *0x2::allowance::name(v0),
            lifetime_cap            : 0x2::allowance::lifetime_cap(v0),
            start_timestamp_ms      : 0x2::allowance::start_timestamp_ms(v0),
            expiration_timestamp_ms : 0x2::allowance::expiration_timestamp_ms(v0),
            rate_limit              : 0x2::allowance::rate_limit(v0),
        };
        0x2::allowance::issue<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, T2000>(arg0, 0x2::allowance::settings_permit<T2000>(0x1::internal::permit<T2000>()), arg2);
        0x2::event::emit<AllowanceAcceptedV1>(v1);
    }

    public fun ceiling_of(arg0: &Ceilings, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.ceilings, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<0x2::object::ID, u64>(&arg0.ceilings, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    entry fun clear_ceiling(arg0: &mut Ceilings, arg1: 0x2::object::ID, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg3: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg2);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.ceilings, arg1), 5);
        let v0 = FunderKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists_with_type<FunderKey, address>(&arg0.id, v0), 6);
        let v1 = FunderKey{pos0: arg1};
        let v2 = *0x2::dynamic_field::borrow<FunderKey, address>(&arg0.id, v1);
        assert!(0x2::tx_context::sender(arg3) == v2, 0);
        let v3 = FunderKey{pos0: arg1};
        0x2::dynamic_field::remove<FunderKey, address>(&mut arg0.id, v3);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg0.ceilings, arg1);
        let v4 = NoDecryptKey{pos0: arg1};
        if (0x2::dynamic_field::exists_with_type<NoDecryptKey, bool>(&arg0.id, v4)) {
            let v5 = NoDecryptKey{pos0: arg1};
            0x2::dynamic_field::remove<NoDecryptKey, bool>(&mut arg0.id, v5);
        };
        let v6 = CeilingClearedV1{
            allowance : arg1,
            funder    : v2,
        };
        0x2::event::emit<CeilingClearedV1>(v6);
    }

    fun draw(arg0: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg1: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg2: &Ceilings, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, address, bool) {
        let v0 = 0x2::object::id<0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(arg0);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg2.ceilings, v0), 2);
        let v1 = 0x2::allowance::app_balance_spend<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T2000>(arg0, 0x2::allowance::spend_permit<T2000>(0x1::internal::permit<T2000>()), arg1, arg3, arg4);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v1) <= *0x2::table::borrow<0x2::object::ID, u64>(&arg2.ceilings, v0), 3);
        (v1, 0x2::allowance::funder(0x2::allowance::allowance_settings<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg0)), no_decrypt_of(arg2, v0))
    }

    public fun fund_bounty(arg0: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg1: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg2: &Ceilings, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg10);
        let v0 = 0x2::object::id<0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(arg0);
        let (v1, v2, v3) = draw(arg0, arg1, arg2, arg11, arg12);
        let v4 = v1;
        let v5 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::bounty::create_bounty_marked(v4, 0x2::tx_context::sender(arg12), v2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v3, arg10, arg11, arg12);
        let v6 = SpentV1{
            allowance : v0,
            job       : v5,
            amount    : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4),
        };
        0x2::event::emit<SpentV1>(v6);
        v5
    }

    public fun fund_job(arg0: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg1: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg2: &Ceilings, arg3: address, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg9: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg10: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg10);
        let v0 = 0x2::object::id<0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(arg0);
        let (v1, v2, v3) = draw(arg0, arg1, arg2, arg11, arg12);
        let v4 = v1;
        let v5 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::create_job_marked(v4, arg3, arg4, arg5, arg6, arg7, v2, v3, arg8, arg9, arg10, arg11, arg12);
        let v6 = SpentV1{
            allowance : v0,
            job       : v5,
            amount    : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4),
        };
        0x2::event::emit<SpentV1>(v6);
        v5
    }

    public fun fund_open(arg0: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg1: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg2: &Ceilings, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg9);
        let v0 = 0x2::object::id<0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(arg0);
        let (v1, v2, v3) = draw(arg0, arg1, arg2, arg10, arg11);
        let v4 = v1;
        let v5 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::create_open_job_marked(v4, 0x2::tx_context::sender(arg11), v2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::none<0x2::object::ID>(), v3, arg9, arg10, arg11);
        let v6 = SpentV1{
            allowance : v0,
            job       : v5,
            amount    : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4),
        };
        0x2::event::emit<SpentV1>(v6);
        v5
    }

    public fun fund_repost(arg0: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg1: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg2: &Ceilings, arg3: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::Job, arg4: u64, arg5: u64, arg6: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg6);
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::funder(arg3) == 0x2::allowance::funder(0x2::allowance::allowance_settings<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg0)), 7);
        let v0 = 0x2::object::id<0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(arg0);
        let (v1, _, v3) = draw(arg0, arg1, arg2, arg7, arg8);
        let v4 = v1;
        let v5 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::repost_marked(arg3, v4, arg4, arg5, v3, arg6, arg7, arg8);
        let v6 = SpentV1{
            allowance : v0,
            job       : v5,
            amount    : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4),
        };
        0x2::event::emit<SpentV1>(v6);
        v5
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Ceilings{
            id       : 0x2::object::new(arg0),
            ceilings : 0x2::table::new<0x2::object::ID, u64>(arg0),
        };
        0x2::transfer::share_object<Ceilings>(v0);
    }

    public fun no_decrypt_of(arg0: &Ceilings, arg1: 0x2::object::ID) : bool {
        let v0 = NoDecryptKey{pos0: arg1};
        0x2::dynamic_field::exists_with_type<NoDecryptKey, bool>(&arg0.id, v0)
    }

    entry fun rotate_machine_key(arg0: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg2: u64, arg3: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg4: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg3);
        assert!(0x2::tx_context::sender(arg4) == 0x2::allowance::funder(0x2::allowance::allowance_settings<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg0)), 0);
        assert!(0x2::tx_context::sender(arg4) == 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::passport_of(arg1, arg2), 1);
        let v0 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::operator_of(arg1, arg2);
        0x2::allowance::rotate_spender<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, T2000>(arg0, 0x2::allowance::settings_permit<T2000>(0x1::internal::permit<T2000>()), v0);
        let v1 = MachineKeyRotatedV1{
            allowance : 0x2::object::id<0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(arg0),
            number    : arg2,
            spender   : v0,
        };
        0x2::event::emit<MachineKeyRotatedV1>(v1);
    }

    entry fun set_ceiling(arg0: &mut Ceilings, arg1: &0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg2: u64, arg3: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg4: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg3);
        assert!(0x2::tx_context::sender(arg4) == 0x2::allowance::funder(0x2::allowance::allowance_settings<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1)), 0);
        let v0 = 0x2::allowance::app(0x2::allowance::allowance_settings<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1));
        let v1 = 0x1::type_name::with_defining_ids<T2000>();
        assert!(0x1::option::contains<0x1::type_name::TypeName>(&v0, &v1), 4);
        let v2 = 0x2::object::id<0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(arg1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.ceilings, v2)) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.ceilings, v2) = arg2;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.ceilings, v2, arg2);
        };
        let v3 = FunderKey{pos0: v2};
        if (!0x2::dynamic_field::exists_with_type<FunderKey, address>(&arg0.id, v3)) {
            let v4 = FunderKey{pos0: v2};
            0x2::dynamic_field::add<FunderKey, address>(&mut arg0.id, v4, 0x2::tx_context::sender(arg4));
        };
        let v5 = CeilingSetV1{
            allowance : v2,
            funder    : 0x2::tx_context::sender(arg4),
            ceiling   : arg2,
        };
        0x2::event::emit<CeilingSetV1>(v5);
    }

    entry fun set_no_decrypt(arg0: &mut Ceilings, arg1: &0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg2: bool, arg3: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg4: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg3);
        assert!(0x2::tx_context::sender(arg4) == 0x2::allowance::funder(0x2::allowance::allowance_settings<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1)), 0);
        let v0 = 0x2::allowance::app(0x2::allowance::allowance_settings<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1));
        let v1 = 0x1::type_name::with_defining_ids<T2000>();
        assert!(0x1::option::contains<0x1::type_name::TypeName>(&v0, &v1), 4);
        let v2 = 0x2::object::id<0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(arg1);
        let v3 = no_decrypt_of(arg0, v2);
        if (arg2 && !v3) {
            let v4 = NoDecryptKey{pos0: v2};
            0x2::dynamic_field::add<NoDecryptKey, bool>(&mut arg0.id, v4, true);
        } else if (!arg2 && v3) {
            let v5 = NoDecryptKey{pos0: v2};
            0x2::dynamic_field::remove<NoDecryptKey, bool>(&mut arg0.id, v5);
        };
        let v6 = NoDecryptSetV1{
            allowance  : v2,
            funder     : 0x2::tx_context::sender(arg4),
            no_decrypt : arg2,
        };
        0x2::event::emit<NoDecryptSetV1>(v6);
    }

    // decompiled from Move bytecode v7
}

