module 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::prompts {
    entry fun generate_nft(arg0: &mut 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::AtomaDb, arg1: &mut 0x2::coin::Coin<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg6, arg7);
        0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::gate::submit_text2image_prompt(arg0, 0x2::coin::balance_mut<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>(arg1), 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::gate::create_text2image_prompt_params(1065353216, 256, 1065353216, 0x1::option::none<0x1::string::String>(), arg2, 40, 2, arg3, 0x1::string::utf8(b"Generate a bored ape NFT"), 0x2::random::generate_u64(&mut v0), 0x1::string::utf8(b"Shinny, bright, bored, blue background"), 256), arg4, arg5, 0x1::option::some<u64>(1), arg3, arg6, arg7);
    }

    entry fun send_prompt(arg0: &mut 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::AtomaDb, arg1: &mut 0x2::coin::Coin<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: vector<u32>, arg5: bool, arg6: u64, arg7: vector<u8>, arg8: bool, arg9: u64, arg10: u64, arg11: u32, arg12: u32, arg13: u64, arg14: u32, arg15: 0x1::option::Option<u64>, arg16: &0x2::random::Random, arg17: &mut 0x2::coin::Coin<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>(arg17) >= 250000000, 312012200);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>>(0x2::coin::split<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>(arg17, 250000000, arg18), @0x738146acb89851fc7e98a8148753b141155ef6a12aa2c32405aca8952c775040);
        let v0 = 0x2::random::new_generator(arg16, arg18);
        0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::gate::submit_text2text_prompt(arg0, 0x2::coin::balance_mut<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>(arg1), 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::gate::create_text2text_prompt_params(arg9, arg2, arg4, arg5, arg7, 0x2::random::generate_u64(&mut v0), arg10, arg11, arg8, arg12, arg13, arg14), arg6, arg15, arg3, arg16, arg18);
    }

    // decompiled from Move bytecode v6
}

