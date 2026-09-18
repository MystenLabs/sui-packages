module 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::message {
    struct BurnInputs has drop {
        gross_amount: u64,
        recent_blockhash: vector<u8>,
        fee_payer: vector<u8>,
        event_account: vector<u8>,
        compute_unit_limit: u32,
        compute_unit_price: u64,
    }

    fun assert_key(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
    }

    public(friend) fun assert_source(arg0: &vector<u8>, arg1: &vector<u8>) {
        assert_key(arg0);
        assert_key(arg1);
        assert!(arg0 != arg1 && *arg1 != 0x2::address::to_bytes(@0x0), 1);
    }

    public fun burn_inputs(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u32, arg5: u64) : BurnInputs {
        assert!(arg0 > fee_amount(), 0);
        assert_key(&arg1);
        assert_key(&arg2);
        assert_key(&arg3);
        assert!(arg1 != 0x2::address::to_bytes(@0x0), 0);
        assert!(arg4 >= 100000 && arg4 <= 1000000, 2);
        assert!(arg5 <= 1000000, 2);
        BurnInputs{
            gross_amount       : arg0,
            recent_blockhash   : arg1,
            fee_payer          : arg2,
            event_account      : arg3,
            compute_unit_limit : arg4,
            compute_unit_price : arg5,
        }
    }

    fun compute_program() : vector<u8> {
        x"0306466fe5211732ffecadba72c39be7bc8ce5bbc5f7126b2c439b3a40000000"
    }

    public(friend) fun encode(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: &BurnInputs) : vector<u8> {
        assert!(arg2 != @0x0, 0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, arg4.fee_payer);
        0x1::vector::push_back<vector<u8>>(v1, arg4.event_account);
        0x1::vector::push_back<vector<u8>>(v1, arg0);
        0x1::vector::push_back<vector<u8>>(v1, arg1);
        0x1::vector::push_back<vector<u8>>(v1, message_transmitter());
        0x1::vector::push_back<vector<u8>>(v1, local_token());
        0x1::vector::push_back<vector<u8>>(v1, usdc_mint());
        0x1::vector::push_back<vector<u8>>(v1, arg3);
        0x1::vector::push_back<vector<u8>>(v1, compute_program());
        0x1::vector::push_back<vector<u8>>(v1, token_messenger_minter());
        0x1::vector::push_back<vector<u8>>(v1, sender_authority());
        0x1::vector::push_back<vector<u8>>(v1, token_messenger());
        0x1::vector::push_back<vector<u8>>(v1, remote_token_messenger());
        0x1::vector::push_back<vector<u8>>(v1, token_minter());
        0x1::vector::push_back<vector<u8>>(v1, message_transmitter_program());
        0x1::vector::push_back<vector<u8>>(v1, token_program());
        0x1::vector::push_back<vector<u8>>(v1, 0x2::address::to_bytes(@0x0));
        0x1::vector::push_back<vector<u8>>(v1, event_authority());
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&v0)) {
            assert_key(0x1::vector::borrow<vector<u8>>(&v0, v2));
            let v3 = v2 + 1;
            while (v3 < 0x1::vector::length<vector<u8>>(&v0)) {
                assert!(*0x1::vector::borrow<vector<u8>>(&v0, v2) != *0x1::vector::borrow<vector<u8>>(&v0, v3), 1);
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        let v4 = x"03010a12";
        0x1::vector::reverse<vector<u8>>(&mut v0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<vector<u8>>(&v0)) {
            0x1::vector::append<u8>(&mut v4, 0x1::vector::pop_back<vector<u8>>(&mut v0));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(v0);
        0x1::vector::append<u8>(&mut v4, arg4.recent_blockhash);
        0x1::vector::push_back<u8>(&mut v4, 4);
        0x1::vector::append<u8>(&mut v4, x"08000502");
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u32>(&arg4.compute_unit_limit));
        0x1::vector::append<u8>(&mut v4, x"08000903");
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg4.compute_unit_price));
        0x1::vector::append<u8>(&mut v4, x"0f04030607020a0c");
        let v6 = fee_amount();
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&v6));
        0x1::vector::push_back<u8>(&mut v4, 6);
        0x1::vector::append<u8>(&mut v4, x"091102000a03040b0c0d0506010e090f10110934");
        0x1::vector::append<u8>(&mut v4, x"d73c3d2e723780b0");
        let v7 = net_amount(arg4);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&v7));
        0x1::vector::append<u8>(&mut v4, x"08000000");
        0x1::vector::append<u8>(&mut v4, 0x2::address::to_bytes(arg2));
        v4
    }

    fun event_authority() : vector<u8> {
        x"a8fd59b1151014cfa79f0585f7b77dd9c5329a287e798105e63c8bd1646e561c"
    }

    public fun fee_amount() : u64 {
        1000000
    }

    public fun gross_amount(arg0: &BurnInputs) : u64 {
        arg0.gross_amount
    }

    fun local_token() : vector<u8> {
        x"598f2f18e98e233b2f5031331aa1d9aff28cf939b62d87f052b4f4f13dbbac11"
    }

    fun message_transmitter() : vector<u8> {
        x"9c3b2db259be09a437cac10df569d529d44435d87783580242f8c2b6ef1e54c2"
    }

    fun message_transmitter_program() : vector<u8> {
        x"a65fc989db5f5d42759f3a546058efcdcdc0bf3c1898072d8eb45dd1d80508ce"
    }

    public fun net_amount(arg0: &BurnInputs) : u64 {
        arg0.gross_amount - fee_amount()
    }

    fun remote_token_messenger() : vector<u8> {
        x"e9306407f0bafe3cf08e4a41d087e0725e46e9e044e1f8ad22791ba376a39ce3"
    }

    fun sender_authority() : vector<u8> {
        x"07b4e8c40171eb54907a1c7e8d5118db8d188cb35268781213ed680d82e0d36c"
    }

    fun token_messenger() : vector<u8> {
        x"8fa249796e1c22f4bdf03865d78153fdf08706fa85fb11a33fd74f7abf16c42a"
    }

    fun token_messenger_minter() : vector<u8> {
        x"a65fc943419a5ad590042fd67c9791fd015acf53a54cc823edb8ff81b9ed722e"
    }

    fun token_minter() : vector<u8> {
        x"b4e9c5059b4c802b52611072842ee1dd053a913b3f27ae0d116913419d0110e7"
    }

    fun token_program() : vector<u8> {
        x"06ddf6e1d765a193d9cbe146ceeb79ac1cb485ed5f5b37913a8cf5857eff00a9"
    }

    fun usdc_mint() : vector<u8> {
        x"c6fa7af3bedbad3a3d65f36aabc97431b1bbe4c2d2f6e0e47ca60203452f5d61"
    }

    // decompiled from Move bytecode v7
}

