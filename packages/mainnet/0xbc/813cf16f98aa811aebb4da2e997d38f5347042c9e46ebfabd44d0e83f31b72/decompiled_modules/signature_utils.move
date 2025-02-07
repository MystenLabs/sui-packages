module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils {
    struct SignedPrice has copy, drop, store {
        namespace: 0x1::string::String,
        chain_id: 0x1::string::String,
        token_address: vector<u8>,
        dollar_price: u256,
        decimals: u8,
        timestamp_signed: u64,
        signature: vector<u8>,
    }

    public fun calculate_dollar_amount(arg0: u256, arg1: &SignedPrice) : u256 {
        arg0 * arg1.dollar_price / 0x1::u256::pow(10, arg1.decimals)
    }

    public fun create_signed_price(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: u256, arg4: u8, arg5: u64, arg6: vector<u8>) : SignedPrice {
        SignedPrice{
            namespace        : arg0,
            chain_id         : arg1,
            token_address    : arg2,
            dollar_price     : arg3,
            decimals         : arg4,
            timestamp_signed : arg5,
            signature        : arg6,
        }
    }

    public fun is_timestamp_valid(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64) : bool {
        if (0x2::clock::timestamp_ms(arg0) <= arg1) {
            return true
        };
        0x2::clock::timestamp_ms(arg0) - arg1 <= arg2
    }

    public fun validate_and_calculate_dollar_amount(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: u256, arg4: 0x1::option::Option<SignedPrice>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock) : 0x1::option::Option<u256> {
        if (0x1::option::is_some<SignedPrice>(&arg4)) {
            let v1 = 0x1::option::destroy_some<SignedPrice>(arg4);
            assert!(validate_signed_price(arg0, arg1, arg2, arg5, arg6, &v1, arg7), 0);
            0x1::option::some<u256>(calculate_dollar_amount(arg3, &v1))
        } else {
            0x1::option::destroy_none<SignedPrice>(arg4);
            0x1::option::none<u256>()
        }
    }

    public fun validate_signed_price(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &SignedPrice, arg6: &0x2::clock::Clock) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg5.namespace));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg5.chain_id));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&arg5.token_address));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u256>(&arg5.dollar_price));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5.timestamp_signed));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg5.decimals));
        let v1 = if (arg5.namespace != arg0) {
            true
        } else if (arg5.chain_id != arg1) {
            true
        } else {
            arg5.token_address != arg2
        };
        if (v1) {
            return false
        };
        if (!0x2::ecdsa_k1::secp256k1_verify(&arg5.signature, &arg3, &v0, 1)) {
            return false
        };
        is_timestamp_valid(arg6, arg5.timestamp_signed, arg4)
    }

    public fun validate_signed_tx_effects(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>, arg4: &0x1::string::String, arg5: &vector<0x1::string::String>, arg6: &0x1::option::Option<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock) : bool {
        0x1::vector::append<u8>(&mut arg1, 0x1::bcs::to_bytes<vector<u8>>(&arg2));
        0x1::vector::append<u8>(&mut arg1, 0x1::bcs::to_bytes<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>>(arg3));
        0x1::vector::append<u8>(&mut arg1, 0x1::bcs::to_bytes<0x1::string::String>(arg4));
        0x1::vector::append<u8>(&mut arg1, 0x1::bcs::to_bytes<vector<0x1::string::String>>(arg5));
        0x1::vector::append<u8>(&mut arg1, 0x1::bcs::to_bytes<0x1::option::Option<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>>(arg6));
        0x1::vector::append<u8>(&mut arg1, 0x1::bcs::to_bytes<u64>(&arg7));
        if (!0x2::ecdsa_k1::secp256k1_verify(&arg9, &arg0, &arg1, 1)) {
            return false
        };
        is_timestamp_valid(arg10, arg7, arg8)
    }

    public fun view_signed_price(arg0: &SignedPrice) : (0x1::string::String, 0x1::string::String, vector<u8>, u256, u8, u64, vector<u8>) {
        (arg0.namespace, arg0.chain_id, arg0.token_address, arg0.dollar_price, arg0.decimals, arg0.timestamp_signed, arg0.signature)
    }

    // decompiled from Move bytecode v6
}

