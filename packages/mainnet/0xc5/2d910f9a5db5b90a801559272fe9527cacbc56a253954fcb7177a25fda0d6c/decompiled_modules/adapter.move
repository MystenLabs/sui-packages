module 0xc52d910f9a5db5b90a801559272fe9527cacbc56a253954fcb7177a25fda0d6c::adapter {
    struct AccordSuins has drop {
        dummy_field: bool,
    }

    struct NameRegistered has copy, drop {
        intent_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        hold_micros: u64,
        paid_micros: u64,
        back_micros: u64,
    }

    public fun version() : u64 {
        1
    }

    public fun finish<T0, T1>(arg0: 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>, arg1: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::ConvertRegistry, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock) {
        0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::assert_adapter_version<AccordSuins>(arg1, 1);
        assert!(0x2::object::id_address<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS>(arg2) == 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::recipient<T0>(&arg0), 1);
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(&arg3);
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::is_subdomain(&v0), 7);
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(&arg3) == name_of(0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::terms<T0>(&arg0)), 2);
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(&arg3) == 0x2::clock::timestamp_ms(arg6) + 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::year_ms(), 3);
        let v1 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_entry<T0>(arg1);
        let v2 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_entry<T1>(arg1);
        let v3 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::route<T0, T1>(arg1);
        let v4 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(&arg3);
        let v5 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_micros(&v2, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::calculate_base_price(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::get_config<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::PricingConfig>(arg2), 0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(&v4))));
        let v6 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_micros(&v1, 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::hold<T0>(&arg0));
        let v7 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_micros(&v1, 0x2::coin::value<T0>(&arg4)) + 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_micros(&v2, 0x2::coin::value<T1>(&arg5));
        let v8 = if (v7 >= v6) {
            0
        } else {
            v6 - v7
        };
        assert!(v8 <= v5 + 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::allowance_micros(&v3, v5), 5);
        let v9 = NameRegistered{
            intent_id   : 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::intent_id<T0>(&arg0),
            owner       : 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::owner<T0>(&arg0),
            name        : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&arg3),
            hold_micros : v6,
            paid_micros : v8,
            back_micros : v7,
        };
        0x2::event::emit<NameRegistered>(v9);
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg3, 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::owner<T0>(&arg0));
        0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::refund<T0, T0>(&arg0, arg4);
        0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::refund<T0, T1>(&arg0, arg5);
        let v10 = AccordSuins{dummy_field: false};
        0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::close<T0, AccordSuins>(v10, arg0);
    }

    fun name_of(arg0: vector<u8>) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain {
        let v0 = 0x1::string::try_utf8(arg0);
        assert!(0x1::option::is_some<0x1::string::String>(&v0), 6);
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(0x1::option::destroy_some<0x1::string::String>(v0));
        let v2 = if (!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::is_subdomain(&v1)) {
            if (0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::number_of_levels(&v1) == 2) {
                if (*0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::tld(&v1) == 0x1::string::utf8(b"sui")) {
                    0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(&v1)) >= 3
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 6);
        v1
    }

    public fun register_seller(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::SellerCap {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::register_external_with_permit<AccordSuins>(0x2::object::id_address<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS>(arg0), arg1, arg2, 0x1::internal::permit<AccordSuins>(), arg3)
    }

    public fun start<T0>(arg0: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::intent::ExternalPayouts<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::intent::Intent<T0>, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg3: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::ConvertRegistry, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>) {
        0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::assert_adapter_version<AccordSuins>(arg3, 1);
        let v0 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_entry<T0>(arg3);
        let (v1, v2, v3, v4, _, v6) = 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::intent::release_external_with_refund<T0, AccordSuins>(arg0, arg1, arg2, 0x1::internal::permit<AccordSuins>(), arg4);
        assert!(0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_micros(&v0, v4) <= 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::cap_micros(&v0), 4);
        name_of(v3);
        let v7 = AccordSuins{dummy_field: false};
        (v1, 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::open<T0, AccordSuins>(v7, 0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::intent::Intent<T0>>(arg1), v6, v4, v2, v3))
    }

    // decompiled from Move bytecode v7
}

