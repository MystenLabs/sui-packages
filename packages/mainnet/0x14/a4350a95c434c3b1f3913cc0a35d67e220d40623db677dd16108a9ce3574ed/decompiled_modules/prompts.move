module 0x14a4350a95c434c3b1f3913cc0a35d67e220d40623db677dd16108a9ce3574ed::prompts {
    entry fun send_image_generation_prompt(arg0: &mut 0x14a4350a95c434c3b1f3913cc0a35d67e220d40623db677dd16108a9ce3574ed::db::AtomaDb, arg1: &mut 0x2::coin::Coin<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u32, arg8: 0x1::option::Option<vector<u8>>, arg9: u32, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: u64, arg14: u64, arg15: 0x1::option::Option<u64>, arg16: &0x2::random::Random, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg16, arg17);
        0x14a4350a95c434c3b1f3913cc0a35d67e220d40623db677dd16108a9ce3574ed::gate::submit_text2image_prompt(arg0, 0x2::coin::balance_mut<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>(arg1), 0x14a4350a95c434c3b1f3913cc0a35d67e220d40623db677dd16108a9ce3574ed::gate::create_text2image_prompt_params(arg7, arg5, arg9, arg8, arg2, arg11, arg10, arg12, arg3, 0x2::random::generate_u64(&mut v0), arg4, arg6), arg13, arg14, arg15, arg12, arg16, arg17);
    }

    entry fun send_prompt(arg0: &mut 0x14a4350a95c434c3b1f3913cc0a35d67e220d40623db677dd16108a9ce3574ed::db::AtomaDb, arg1: &mut 0x2::coin::Coin<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: vector<u32>, arg5: bool, arg6: u64, arg7: vector<u8>, arg8: bool, arg9: u64, arg10: u64, arg11: u32, arg12: u32, arg13: u64, arg14: u32, arg15: 0x1::option::Option<u64>, arg16: &0x2::random::Random, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg16, arg17);
        0x14a4350a95c434c3b1f3913cc0a35d67e220d40623db677dd16108a9ce3574ed::gate::submit_text2text_prompt(arg0, 0x2::coin::balance_mut<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>(arg1), 0x14a4350a95c434c3b1f3913cc0a35d67e220d40623db677dd16108a9ce3574ed::gate::create_text2text_prompt_params(arg9, arg2, arg4, arg5, arg7, 0x2::random::generate_u64(&mut v0), arg10, arg11, arg8, arg12, arg13, arg14), arg6, arg15, arg3, arg16, arg17);
    }

    // decompiled from Move bytecode v6
}

