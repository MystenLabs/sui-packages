module 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::prompts {
    entry fun send_image_prompt(arg0: &mut 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::AtomaDb, arg1: &mut 0x2::coin::Coin<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg8, arg9);
        0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::gate::submit_text2image_prompt(arg0, 0x2::coin::balance_mut<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(arg1), 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::gate::create_text2image_prompt_params(1065353216, 256, 1065353216, 0x1::option::none<vector<u8>>(), arg2, 40, 2, arg3, arg6, 0x2::random::generate_u64(&mut v0), arg7, 256), arg4, arg5, 0x1::option::some<u64>(1), arg3, arg8, arg9);
    }

    entry fun send_prompt(arg0: &mut 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::AtomaDb, arg1: &mut 0x2::coin::Coin<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: vector<u32>, arg5: bool, arg6: u64, arg7: vector<u8>, arg8: bool, arg9: u64, arg10: u64, arg11: u32, arg12: u32, arg13: u64, arg14: u32, arg15: 0x1::option::Option<u64>, arg16: &0x2::random::Random, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg16, arg17);
        0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::gate::submit_text2text_prompt(arg0, 0x2::coin::balance_mut<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(arg1), 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::gate::create_text2text_prompt_params(arg9, arg2, arg4, arg5, arg7, 0x2::random::generate_u64(&mut v0), arg10, arg11, arg8, arg12, arg13, arg14), arg6, arg15, arg3, arg16, arg17);
    }

    // decompiled from Move bytecode v6
}

