module 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::distributor {
    struct DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    public entry fun claim_red_packet(arg0: &mut 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::State, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_state_signer(arg0);
        let v1 = 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_red_packet_from_state_mut(arg0, arg1);
        assert!(0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_red_packet_status(v1) == 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::constants::status_active(), 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::constants::red_packet_not_active());
        let v2 = 0x2::table::borrow_mut<0x1::string::String, 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::ClaimInfo>(0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_red_packet_claims_mut(v1), arg2);
        assert!(!0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_claim_info_claimed(v2), 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::constants::already_claimed());
        0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::set_claim_info_claimed(v2, true);
        let v3 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v3, arg1);
        0x1::string::append(&mut v3, arg2);
        let v4 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v4, 0x1::string::utf8(x"457468657265756d205369676e6564204d6573736167653a0a3332"));
        0x1::string::append(&mut v4, 0x1::string::utf8(0x2::hash::keccak256(0x1::string::as_bytes(&v3))));
        let v5 = 0x2::hash::keccak256(0x1::string::as_bytes(&v4));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v0, &v5), 1);
        let v6 = 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_claim_info_amount(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_red_packet_balance_mut(v1), v6), arg4), 0x2::tx_context::sender(arg4));
        0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::set_red_packet_remaining_amount(v1, 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_red_packet_remaining_amount(v1) - v6);
        0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::events::emit_red_packet_claimed(arg1, arg2, 0x2::tx_context::sender(arg4), v6);
    }

    public entry fun create_red_packet(arg0: &mut 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::State, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        let v1 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 == v1, 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::constants::invalid_length());
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg3, v3);
            v3 = v3 + 1;
        };
        let v4 = 0x2::table::new<0x1::string::String, 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::ClaimInfo>(arg5);
        v3 = 0;
        while (v3 < v0) {
            0x2::table::add<0x1::string::String, 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::ClaimInfo>(&mut v4, *0x1::vector::borrow<0x1::string::String>(&arg2, v3), 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::new_claim_info(false, *0x1::vector::borrow<u64>(&arg3, v3)));
            v3 = v3 + 1;
        };
        let v5 = 0x1::vector::empty<0x1::string::String>();
        v3 = 0;
        while (v3 < v0) {
            0x1::vector::push_back<0x1::string::String>(&mut v5, *0x1::vector::borrow<0x1::string::String>(&arg2, v3));
            v3 = v3 + 1;
        };
        0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::add_red_packet_to_state(arg0, arg1, 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::new_red_packet(0x2::tx_context::sender(arg5), v2, v2, 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::constants::status_active(), v4, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg5));
        0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::events::emit_red_packet_created(arg1, 0x2::tx_context::sender(arg5), v2, v5, arg3);
    }

    fun init(arg0: DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::share_state(0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::new_state(x"1a3bf80f24155f3a99283256ed5ec9b4fc188909d380da527c79ba299519acb915", 0x2::tx_context::sender(arg1), arg1));
    }

    public entry fun refund_red_packet(arg0: &mut 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::RedPacket, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_red_packet_creator(arg0), 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::constants::not_creator());
        assert!(0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_red_packet_status(arg0) == 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::constants::status_active(), 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::constants::red_packet_not_active());
        0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::set_red_packet_status(arg0, 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::constants::status_refunded());
        let v0 = 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_red_packet_remaining_amount(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_red_packet_balance_mut(arg0), v0), arg2), 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_red_packet_creator(arg0));
        0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::events::emit_red_packet_refunded(0x1::string::utf8(arg1), 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs::get_red_packet_creator(arg0), v0);
    }

    // decompiled from Move bytecode v6
}

