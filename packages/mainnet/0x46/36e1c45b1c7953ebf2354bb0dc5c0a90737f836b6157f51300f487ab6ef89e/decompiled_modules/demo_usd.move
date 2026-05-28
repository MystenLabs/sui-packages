module 0x4636e1c45b1c7953ebf2354bb0dc5c0a90737f836b6157f51300f487ab6ef89e::demo_usd {
    struct DEMO_USD has drop {
        dummy_field: bool,
    }

    struct Faucet has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<DEMO_USD>,
        metadata: 0x2::coin_registry::MetadataCap<DEMO_USD>,
        policy_cap: 0x1::option::Option<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::PolicyCap<0x2::balance::Balance<DEMO_USD>>>,
    }

    struct ActionStamp has drop {
        dummy_field: bool,
    }

    struct TransferApproval has drop {
        dummy_field: bool,
    }

    struct TransferApprovalV2 has drop {
        dummy_field: bool,
    }

    struct UnlockApproval has drop {
        dummy_field: bool,
    }

    public fun approve_transfer<T0>(arg0: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>, arg1: &0x2::clock::Clock) {
        assert!(0x2::balance::value<T0>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::funds<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>(arg0))) < 10000000000, 13835058398879547393);
        assert!(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::sender<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>(arg0)) != 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::recipient<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>(arg0)), 13835339878151356419);
        let v0 = TransferApproval{dummy_field: false};
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::approve<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>, TransferApproval>(arg0, v0);
    }

    public fun approve_transfer_v2(arg0: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<DEMO_USD>>>, arg1: &Faucet) {
        assert!(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::recipient<0x2::balance::Balance<DEMO_USD>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<DEMO_USD>>>(arg0)) != @0x2, 13835621580761464837);
        let v0 = TransferApprovalV2{dummy_field: false};
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::approve<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<DEMO_USD>>, TransferApprovalV2>(arg0, v0);
    }

    public fun faucet_mint_balance(arg0: &mut Faucet, arg1: u64) : 0x2::balance::Balance<DEMO_USD> {
        0x2::coin::mint_balance<DEMO_USD>(&mut arg0.cap, arg1)
    }

    fun init(arg0: DEMO_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DEMO_USD>(arg0, 6, 0x1::string::utf8(b"DEMO_USD"), 0x1::string::utf8(b"Demo USD Testing"), 0x1::string::utf8(b"Demo USD published just for testing"), 0x1::string::utf8(b""), arg1);
        let v2 = Faucet{
            id         : 0x2::object::new(arg1),
            cap        : v1,
            metadata   : 0x2::coin_registry::finalize<DEMO_USD>(v0, arg1),
            policy_cap : 0x1::option::none<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::PolicyCap<0x2::balance::Balance<DEMO_USD>>>(),
        };
        0x2::transfer::share_object<Faucet>(v2);
    }

    entry fun setup(arg0: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg1: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::Templates, arg2: &mut Faucet) {
        let (v0, v1) = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::new_for_currency<DEMO_USD>(arg0, &mut arg2.cap, true);
        let v2 = v1;
        let v3 = v0;
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::set_required_approval<0x2::balance::Balance<DEMO_USD>, TransferApproval>(&mut v3, &v2, 0x1::string::utf8(b"send_funds"));
        0x1::option::fill<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::PolicyCap<0x2::balance::Balance<DEMO_USD>>>(&mut arg2.policy_cap, v2);
        let v4 = 0x1::type_name::with_defining_ids<DEMO_USD>();
        let v5 = 0x1::vector::empty<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>(v6, 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::ext_input<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::PAS>(0x1::string::utf8(b"request")));
        0x1::vector::push_back<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>(v6, 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::object_by_id(0x2::object::id_from_address(@0x6)));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::from_ascii(*0x1::type_name::as_string(&v4)));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::set_template_command<TransferApproval>(arg1, 0x1::internal::permit<TransferApproval>(), 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::move_call(0x1::string::from_ascii(0x1::type_name::address_string(&v4)), 0x1::string::utf8(b"demo_usd"), 0x1::string::utf8(b"approve_transfer"), v5, v7));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::share<0x2::balance::Balance<DEMO_USD>>(v3);
    }

    public fun use_v2(arg0: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<DEMO_USD>>, arg1: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::Templates, arg2: &mut Faucet) {
        let v0 = 0x1::type_name::with_defining_ids<DEMO_USD>();
        let v1 = 0x1::vector::empty<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>(v2, 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::ext_input<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::PAS>(0x1::string::utf8(b"request")));
        0x1::vector::push_back<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>(v2, 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::object_by_id(0x2::object::id<Faucet>(arg2)));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::set_template_command<TransferApprovalV2>(arg1, 0x1::internal::permit<TransferApprovalV2>(), 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::move_call(0x1::string::from_ascii(0x1::type_name::address_string(&v0)), 0x1::string::utf8(b"demo_usd"), 0x1::string::utf8(b"approve_transfer_v2"), v1, 0x1::vector::empty<0x1::string::String>()));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::set_required_approval<0x2::balance::Balance<DEMO_USD>, TransferApprovalV2>(arg0, 0x1::option::borrow<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::PolicyCap<0x2::balance::Balance<DEMO_USD>>>(&arg2.policy_cap), 0x1::string::utf8(b"send_funds"));
    }

    // decompiled from Move bytecode v7
}

