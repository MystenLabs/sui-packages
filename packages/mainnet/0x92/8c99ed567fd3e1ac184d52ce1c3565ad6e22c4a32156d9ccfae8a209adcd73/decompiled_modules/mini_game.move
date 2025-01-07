module 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::mini_game {
    public fun admin_mint_specified_alphabet(arg0: &0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::admin::AdminCap, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::new(arg1, arg3);
        0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::emit_created_event(arg2, 0x2::object::id<0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::Alphabet>(&v0), 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::letter(&v0));
        0x2::transfer::public_transfer<0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::Alphabet>(v0, arg2);
    }

    entry fun signature_mint_random_alphabet(arg0: &mut 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player::Player, arg1: &0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::config::Config, arg2: &0x2::random::Random, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        verify_player_signature_and_update_nonce(arg0, 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::config::public_key(arg1), arg3);
        let v0 = 0x2::random::new_generator(arg2, arg4);
        let v1 = 0;
        while (v1 < 0x2::random::generate_u8_in_range(&mut v0, 1, 3)) {
            let v2 = 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::new(0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::weighted_random_letter(&mut v0), arg4);
            0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::emit_created_event(0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player::to_address(arg0), 0x2::object::id<0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::Alphabet>(&v2), 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::letter(&v2));
            0x2::transfer::public_transfer<0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::Alphabet>(v2, 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player::to_address(arg0));
            v1 = v1 + 1;
        };
    }

    fun verify_player_signature(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg1);
        0x2::ed25519::ed25519_verify(&arg3, &arg2, &v0)
    }

    fun verify_player_signature_and_update_nonce(arg0: &mut 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player::Player, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(verify_player_signature(0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player::nonce(arg0), 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player::to_bytes(arg0), arg1, arg2), 0);
        0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player::set_nonce(arg0, 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player::nonce(arg0) + 1);
    }

    // decompiled from Move bytecode v6
}

