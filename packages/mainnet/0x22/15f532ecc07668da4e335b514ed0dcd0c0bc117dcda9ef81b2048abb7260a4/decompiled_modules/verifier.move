module 0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::verifier {
    struct VerifiedEvent has copy, drop {
        is_verified: bool,
    }

    struct VerifyingKeyEvent has copy, drop {
        delta_bytes: vector<u8>,
        gamma_bytes: vector<u8>,
        alpha_bytes: vector<u8>,
        vk_bytes: vector<u8>,
    }

    struct JustEvent has copy, drop {
        vk_bytes: vector<u8>,
    }

    public fun get_verification_key_components(arg0: &0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::verification_key_manager::VerificationKeyManager, arg1: vector<u8>) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::verification_key_manager::get_keys_for_circuit(arg0, &arg1)
    }

    public entry fun just(arg0: vector<u8>) {
        0x1::debug::print<vector<u8>>(&arg0);
        let v0 = 0x2::groth16::bn254();
        let v1 = 0x2::groth16::pvk_to_bytes(0x2::groth16::prepare_verifying_key(&v0, &arg0));
        let v2 = 0x1::vector::pop_back<vector<u8>>(&mut v1);
        let v3 = 0x1::vector::pop_back<vector<u8>>(&mut v1);
        let v4 = 0x1::vector::pop_back<vector<u8>>(&mut v1);
        let v5 = 0x1::vector::pop_back<vector<u8>>(&mut v1);
        0x1::debug::print<vector<u8>>(&v2);
        0x1::debug::print<vector<u8>>(&v3);
        0x1::debug::print<vector<u8>>(&v4);
        0x1::debug::print<vector<u8>>(&v5);
        assert!(v2 == x"b41e5e09002a7170cb4cc56ae96b152d17b6b0d1b9333b41f2325c3c8a9d2e2df98f8e2315884fae52b3c6bb329df0359daac4eff4d2e7ce729078b10d79d4af", 1003);
        assert!(v3 == x"6030ca5b462a3502d560df7ff62b7f1215195233f688320de19e4b3a2a2cb6120ae49bcc0abbd3cbbf06b29b489edbf86e3b679f4e247464992145f468e3c00d", 1004);
        assert!(v4 == x"61665b255f20b17bbd56b04a9e4d6bf596cb8d578ce5b2a9ccd498e26d394a3071485596cabce152f68889799f7f6b4e94d415c28e14a3aa609e389e344ae72778358ca908efe2349315bce79341c69623a14397b7fa47ae3fa31c6e41c2ee1b6ab50ef5434c1476d9894bc6afee68e0907b98aa8dfa3464cc9a122b247334064ff7615318b47b881cef4869f3dbfde38801475ae15244be1df58f55f71a5a01e28c8fa91fac886b97235fddb726dfc6a916483464ea130b6f82dc602e684b14f5ee655e510a0c1dd6f87b608718cd19d63a914f745a80c8016aa2c49883482aa28acd647cf9ce56446c0330fe6568bc03812b3bda44d804530abc67305f4914a509ecdc30f0b88b1a4a8b11e84856b333da3d86bb669a53dbfcde59511be60d8d5f7c79faa4910bf396ab04e7239d491e0a3bee177e6c9aac0ecbcd09ca850afcd46f25410849cefcfbdac828e7b057d4a732a373aad913d4b767897ba15d0bfcbcbb25bc5f2dae1ea59196ede9666a5c260f054b1a64977666af6a03076409", 1005);
        assert!(v5 == x"1dcc52e058148a622c51acfdee6e181252ec0e9717653f0be1faaf2a68222e0dd2ccf4e1e8b088efccfdb955a1ff4a0fd28ae2ccbe1a112449ddae8738fb40b0", 1006);
        let v6 = VerifyingKeyEvent{
            delta_bytes : v2,
            gamma_bytes : v3,
            alpha_bytes : v4,
            vk_bytes    : v5,
        };
        0x2::event::emit<VerifyingKeyEvent>(v6);
        let v7 = JustEvent{vk_bytes: arg0};
        0x2::event::emit<JustEvent>(v7);
    }

    public entry fun parse_pvk_from_vk(arg0: vector<u8>) {
        0x1::debug::print<vector<u8>>(&arg0);
        let v0 = 0x2::groth16::bn254();
        let v1 = 0x2::groth16::pvk_to_bytes(0x2::groth16::prepare_verifying_key(&v0, &arg0));
        let v2 = VerifyingKeyEvent{
            delta_bytes : 0x1::vector::pop_back<vector<u8>>(&mut v1),
            gamma_bytes : 0x1::vector::pop_back<vector<u8>>(&mut v1),
            alpha_bytes : 0x1::vector::pop_back<vector<u8>>(&mut v1),
            vk_bytes    : 0x1::vector::pop_back<vector<u8>>(&mut v1),
        };
        0x2::event::emit<VerifyingKeyEvent>(v2);
    }

    public fun setup_verification_keys(arg0: &mut 0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::verification_key_manager::VerificationKeyManager, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::verification_key_manager::get_admin(arg0) == 0x2::tx_context::sender(arg2), 1008);
        let v0 = VerifiedEvent{is_verified: true};
        0x2::event::emit<VerifiedEvent>(v0);
    }

    public fun verify_proof(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = 0x2::groth16::bn254();
        let v1 = 0x2::groth16::prepare_verifying_key(&v0, &arg0);
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(arg1);
        let v3 = 0x2::groth16::proof_points_from_bytes(arg2);
        let v4 = 0x2::groth16::bn254();
        let v5 = 0x2::groth16::verify_groth16_proof(&v4, &v1, &v2, &v3);
        let v6 = VerifiedEvent{is_verified: v5};
        0x2::event::emit<VerifiedEvent>(v6);
        v5
    }

    public fun verify_proof_with_manager(arg0: &0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::verification_key_manager::VerificationKeyManager, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let (v0, _, _, _) = 0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::verification_key_manager::get_keys_for_circuit(arg0, &arg1);
        let v4 = v0;
        assert!(!0x1::vector::is_empty<u8>(&v4), 1007);
        let v5 = 0x2::groth16::bn254();
        let v6 = 0x2::groth16::prepare_verifying_key(&v5, &v4);
        let v7 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        let v8 = 0x2::groth16::proof_points_from_bytes(arg3);
        let v9 = 0x2::groth16::bn254();
        let v10 = 0x2::groth16::verify_groth16_proof(&v9, &v6, &v7, &v8);
        let v11 = VerifiedEvent{is_verified: v10};
        0x2::event::emit<VerifiedEvent>(v11);
        v10
    }

    // decompiled from Move bytecode v6
}

