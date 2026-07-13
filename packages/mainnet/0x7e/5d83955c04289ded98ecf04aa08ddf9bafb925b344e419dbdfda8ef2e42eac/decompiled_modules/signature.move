module 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::signature {
    struct SigConfig has key {
        id: 0x2::object::UID,
        version: u64,
        chain_name: 0x1::string::String,
        chain_name_hash: vector<u8>,
        chain_id: u64,
        vault_id: address,
        chains: 0x2::table::Table<u64, u8>,
        business_signer: address,
        ledger_signer: address,
    }

    public fun add_chain(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut SigConfig, arg2: u64, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg3 == 0 || arg3 == 1, 3004);
        assert!(!0x2::table::contains<u64, u8>(&arg1.chains, arg2), 3002);
        0x2::table::add<u64, u8>(&mut arg1.chains, arg2, arg3);
    }

    fun assert_version(arg0: &SigConfig) {
        assert!(arg0.version == 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current(), 3010);
    }

    fun ecrecover_to_eth_address(arg0: &vector<u8>, arg1: &vector<u8>) : address {
        let v0 = *arg0;
        let v1 = *0x1::vector::borrow<u8>(&v0, 64);
        if (v1 >= 27) {
            *0x1::vector::borrow_mut<u8>(&mut v0, 64) = v1 - 27;
        };
        let v2 = 0x2::ecdsa_k1::secp256k1_ecrecover(&v0, arg1, 0);
        let v3 = 0x2::ecdsa_k1::decompress_pubkey(&v2);
        let v4 = b"";
        let v5 = 1;
        while (v5 < 65) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v3, v5));
            v5 = v5 + 1;
        };
        let v6 = 0x2::hash::keccak256(&v4);
        let v7 = 0;
        while (v7 < 12) {
            *0x1::vector::borrow_mut<u8>(&mut v6, v7) = 0;
            v7 = v7 + 1;
        };
        0x2::address::from_bytes(v6)
    }

    fun eip191_pre_image(arg0: vector<u8>) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, 25);
        0x1::vector::append<u8>(&mut v0, x"457468657265756d205369676e6564204d6573736167653a0a3332");
        0x1::vector::append<u8>(&mut v0, arg0);
        v0
    }

    fun encode_evm_address(arg0: address) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = 0;
        while (v1 < 12) {
            *0x1::vector::borrow_mut<u8>(&mut v0, v1) = 0;
            v1 = v1 + 1;
        };
        v0
    }

    fun encode_evm_uint256(arg0: u256) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u256>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun encode_solana_message_bytes(arg0: &vector<u8>, arg1: address, arg2: &vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64) : vector<u8> {
        let v0 = b"PrimaryType=Withdraw,AsterChain=Mainnet,Destination=";
        0x1::vector::append<u8>(&mut v0, 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::util::address_to_hex_str(arg1));
        0x1::vector::append<u8>(&mut v0, b",DestinationChain=");
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, b",Token=");
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x1::vector::append<u8>(&mut v0, b",Amount=");
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, b",Fee=");
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, b",Nonce=");
        0x1::vector::append<u8>(&mut v0, 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::util::u64_to_decimal_str(arg5));
        v0
    }

    fun encode_user_digest(arg0: &vector<u8>, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, x"8b73c3c69bb8fe3d512ecc4cf759cc79239f7b179b0ffacaa9a75d522b39400f");
        0x1::vector::append<u8>(&mut v0, x"738e495ea128e1abf74af009c5687468378bb99cbd0849a55e50f059be1a3110");
        0x1::vector::append<u8>(&mut v0, x"c89efdaa54c0f20c7adf612882df0950f5a951637e0307cdcb4c672f298b8bc6");
        0x1::vector::append<u8>(&mut v0, encode_evm_uint256((arg1 as u256)));
        0x1::vector::append<u8>(&mut v0, x"0000000000000000000000000000000000000000000000000000000000000000");
        let v1 = b"";
        0x1::vector::append<u8>(&mut v1, x"a40ca56145460a06d254e336d63bb4482ab9a635e70a59afc19267f03468aa70");
        0x1::vector::append<u8>(&mut v1, x"8d7f87ab38a7f75a63dc465e10aadacecfca64c44ca774040b039bfb004e3367");
        0x1::vector::append<u8>(&mut v1, encode_evm_address(arg2));
        0x1::vector::append<u8>(&mut v1, *arg0);
        0x1::vector::append<u8>(&mut v1, arg3);
        0x1::vector::append<u8>(&mut v1, arg4);
        0x1::vector::append<u8>(&mut v1, arg5);
        0x1::vector::append<u8>(&mut v1, encode_evm_uint256((arg6 as u256)));
        0x1::vector::append<u8>(&mut v1, x"8d646f556e5d9d6f1edcf7a39b77f5ac253776eb34efcfd688aacbee518efc26");
        let v2 = b"";
        0x1::vector::push_back<u8>(&mut v2, 25);
        0x1::vector::push_back<u8>(&mut v2, 1);
        0x1::vector::append<u8>(&mut v2, 0x2::hash::keccak256(&v0));
        0x1::vector::append<u8>(&mut v2, 0x2::hash::keccak256(&v1));
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SigConfig{
            id              : 0x2::object::new(arg0),
            version         : 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current(),
            chain_name      : 0x1::string::utf8(b""),
            chain_name_hash : b"",
            chain_id        : 0,
            vault_id        : @0x0,
            chains          : 0x2::table::new<u64, u8>(arg0),
            business_signer : @0x0,
            ledger_signer   : @0x0,
        };
        0x2::transfer::share_object<SigConfig>(v0);
    }

    public(friend) fun migrate(arg0: &mut SigConfig) {
        if (arg0.version < 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current()) {
            arg0.version = 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current();
        };
    }

    public fun remove_chain(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut SigConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<u64, u8>(&arg1.chains, arg2), 3001);
        0x2::table::remove<u64, u8>(&mut arg1.chains, arg2);
    }

    public fun set_business_signer(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut SigConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg3));
        arg1.business_signer = arg2;
    }

    public fun set_chain(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut SigConfig, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg5));
        arg1.chain_name_hash = 0x2::hash::keccak256(0x1::string::as_bytes(&arg2));
        arg1.chain_name = arg2;
        arg1.chain_id = arg3;
        arg1.vault_id = arg4;
    }

    public fun set_ledger_signer(arg0: &0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::AccessControl, arg1: &mut SigConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control::assert_admin_role(arg0, 0x2::tx_context::sender(arg3));
        arg1.ledger_signer = arg2;
    }

    fun verify_business_sig(arg0: u64, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>) : address {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, encode_evm_uint256((arg0 as u256)));
        0x1::vector::append<u8>(&mut v0, encode_evm_uint256((arg1 as u256)));
        0x1::vector::append<u8>(&mut v0, encode_evm_address(arg2));
        0x1::vector::append<u8>(&mut v0, arg3);
        let v1 = eip191_pre_image(0x2::hash::keccak256(&v0));
        ecrecover_to_eth_address(&arg4, &v1)
    }

    fun verify_ledger_sig(arg0: u64, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) : address {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, encode_evm_uint256((arg0 as u256)));
        0x1::vector::append<u8>(&mut v0, encode_evm_address(arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        let v1 = eip191_pre_image(0x2::hash::keccak256(&v0));
        ecrecover_to_eth_address(&arg4, &v1)
    }

    public(friend) fun verify_sig(arg0: &SigConfig, arg1: address, arg2: u64, arg3: address, arg4: vector<u8>, arg5: u64, arg6: u8, arg7: u8, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: vector<u8>, arg15: vector<u8>) : vector<u8> {
        assert_version(arg0);
        assert!(0x2::table::contains<u64, u8>(&arg0.chains, arg2), 3001);
        assert!(arg6 <= 18 && arg9 <= 18, 3008);
        let v0 = *0x2::table::borrow<u64, u8>(&arg0.chains, arg2);
        let v1 = 0x2::hash::keccak256(&arg4);
        let v2 = 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::util::number_to_float_str(arg5, arg6, arg7);
        let v3 = 0x2::hash::keccak256(&v2);
        let v4 = 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::util::number_to_float_str(arg8, arg9, arg10);
        let v5 = if (v0 == 0) {
            let (v6, v7) = verify_user_sig_ecdsa(&arg0.chain_name_hash, arg2, arg3, v1, v3, 0x2::hash::keccak256(&v4), arg11, &arg13);
            assert!(v6 == arg1, 3005);
            v7
        } else {
            assert!(v0 == 1, 3001);
            let (v8, v9) = verify_user_sig_ed25519(0x1::string::as_bytes(&arg0.chain_name), arg3, &arg4, v2, v4, arg11, &arg13, arg1);
            assert!(v8, 3005);
            v9
        };
        assert!(verify_business_sig(arg12, arg0.chain_id, arg0.vault_id, v5, arg14) == arg0.business_signer, 3006);
        assert!(verify_ledger_sig(arg12, arg1, v1, v3, arg15) == arg0.ledger_signer, 3007);
        v5
    }

    fun verify_user_sig_ecdsa(arg0: &vector<u8>, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &vector<u8>) : (address, vector<u8>) {
        let v0 = encode_user_digest(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (ecrecover_to_eth_address(arg7, &v0), 0x2::hash::keccak256(&v0))
    }

    fun verify_user_sig_ed25519(arg0: &vector<u8>, arg1: address, arg2: &vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &vector<u8>, arg7: address) : (bool, vector<u8>) {
        let v0 = encode_solana_message_bytes(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::bcs::to_bytes<address>(&arg7);
        (0x2::ed25519::ed25519_verify(arg6, &v1, &v0), 0x2::hash::keccak256(&v0))
    }

    // decompiled from Move bytecode v7
}

