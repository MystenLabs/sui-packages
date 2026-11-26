module 0x3ec7b7d3f6629aa80a4002b0a8cc3ccd0dccb15873148b95e303384e31228459::tokens {
    struct Transfer<phantom T0> has drop {
        dummy_field: bool,
    }

    public fun airdrop<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg2: vector<address>, arg3: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906834560890437633);
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906834569480372223);
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::balance::send_funds<T0>(0x2::coin::mint_balance<T0>(arg0, 0x1::vector::pop_back<u64>(&mut arg3)), 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::account_address(arg1, 0x1::vector::pop_back<address>(&mut arg2)));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    public fun approve_transfer<T0>(arg0: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>) {
        let v0 = Transfer<T0>{dummy_field: false};
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::approve<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>, Transfer<T0>>(arg0, v0);
    }

    public(friend) fun create<T0: drop>(arg0: T0, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T0>(arg0, 0, arg1, arg2, arg3, 0x1::string::utf8(b""), arg4);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T0>>(0x2::coin_registry::finalize<T0>(v0, arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun setup<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg2: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::Templates, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::new_for_currency<T0>(arg1, arg0, false);
        let v2 = v1;
        let v3 = v0;
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::set_required_approval<0x2::balance::Balance<T0>, Transfer<T0>>(&mut v3, &v2, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::send_funds_action());
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::set_required_approval<0x2::balance::Balance<T0>, 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::shop::Purchase>(&mut v3, &v2, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::unlock_funds_action());
        let v4 = 0x1::type_name::with_defining_ids<Transfer<T0>>();
        let v5 = 0x1::vector::empty<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>();
        0x1::vector::push_back<0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::Argument>(&mut v5, 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::ext_input<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::PAS>(0x1::string::utf8(b"request")));
        let v6 = 0x1::type_name::with_defining_ids<T0>();
        let v7 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::from_ascii(*0x1::type_name::as_string(&v6)));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::templates::set_template_command<Transfer<T0>>(arg2, 0x1::internal::permit<Transfer<T0>>(), 0x5a5f54bdb8d79da2f0e3a7e06a2741f5b78071ca3cbc47ec06cb544b36bbed46::ptb::move_call(0x1::string::from_ascii(0x1::type_name::address_string(&v4)), 0x1::string::utf8(b"tokens"), 0x1::string::utf8(b"approve_transfer"), v5, v7));
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::share<0x2::balance::Balance<T0>>(v3);
        0x2::transfer::public_transfer<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::PolicyCap<0x2::balance::Balance<T0>>>(v2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

