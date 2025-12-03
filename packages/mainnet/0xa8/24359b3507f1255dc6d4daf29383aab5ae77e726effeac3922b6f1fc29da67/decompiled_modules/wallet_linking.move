module 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::wallet_linking {
    fun construct_wallet_link_attestation_message(arg0: 0x2::object::ID, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, b"||");
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, b"||");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        v0
    }

    public(friend) fun link_chain_wallet(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::OracleConfig, arg6: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_wallet_key_is_allowed(arg6, &arg1);
        link_wallet_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun link_wallet_internal(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::OracleConfig, arg6: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::owner(arg0), 2);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg6);
        let v0 = 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::get_oracle_public_key(arg5);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::validate_oracle_public_key(&v0);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg4 <= v1 + 5000, 13906834621019979777);
        assert!(v1 - arg4 <= 600000, 13906834629609914369);
        let v2 = construct_wallet_link_attestation_message(0x2::object::id<0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile>(arg0), &arg1, &arg2, arg4);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::verify_oracle_signature(&v2, &v0, &arg3);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::add_wallet_address(arg0, arg1, arg2, arg6, arg7, arg8);
    }

    public(friend) fun unlink_chain_wallet(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_wallet_key_is_allowed(arg3, &arg1);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::remove_wallet_address(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

