module 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::gate {
    struct Text2TextPromptParams has copy, drop, store {
        max_tokens: u64,
        model: 0x1::ascii::String,
        pre_prompt_tokens: vector<u32>,
        prepend_output_with_input: bool,
        prompt: vector<u8>,
        random_seed: u64,
        repeat_last_n: u64,
        repeat_penalty: u32,
        should_stream_output: bool,
        temperature: u32,
        top_k: u64,
        top_p: u32,
    }

    struct Text2TextPromptEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        params: Text2TextPromptParams,
        chunks_count: u64,
        nodes: vector<0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::SmallId>,
        output_destination: vector<u8>,
    }

    struct Text2ImagePromptParams has copy, drop, store {
        guidance_scale: u32,
        height: u64,
        img2img: 0x1::option::Option<0x1::string::String>,
        img2img_strength: u32,
        model: 0x1::ascii::String,
        n_steps: u64,
        num_samples: u64,
        output_destination: vector<u8>,
        prompt: 0x1::string::String,
        random_seed: u64,
        uncond_prompt: 0x1::string::String,
        width: u64,
    }

    struct Text2ImagePromptEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        params: Text2ImagePromptParams,
        chunks_count: u64,
        nodes: vector<0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::SmallId>,
        output_destination: vector<u8>,
    }

    struct EchelonIdAndPerformance has drop {
        index: u64,
        performance: u256,
    }

    public fun create_text2image_prompt_params(arg0: u32, arg1: u64, arg2: u32, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::ascii::String, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: 0x1::string::String, arg9: u64, arg10: 0x1::string::String, arg11: u64) : Text2ImagePromptParams {
        Text2ImagePromptParams{
            guidance_scale     : arg0,
            height             : arg1,
            img2img            : arg3,
            img2img_strength   : arg2,
            model              : arg4,
            n_steps            : arg5,
            num_samples        : arg6,
            output_destination : arg7,
            prompt             : arg8,
            random_seed        : arg9,
            uncond_prompt      : arg10,
            width              : arg11,
        }
    }

    public fun create_text2text_prompt_params(arg0: u64, arg1: 0x1::ascii::String, arg2: vector<u32>, arg3: bool, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u32, arg8: bool, arg9: u32, arg10: u64, arg11: u32) : Text2TextPromptParams {
        Text2TextPromptParams{
            max_tokens                : arg0,
            model                     : arg1,
            pre_prompt_tokens         : arg2,
            prepend_output_with_input : arg3,
            prompt                    : arg4,
            random_seed               : arg5,
            repeat_last_n             : arg6,
            repeat_penalty            : arg7,
            should_stream_output      : arg8,
            temperature               : arg9,
            top_k                     : arg10,
            top_p                     : arg11,
        }
    }

    fun select_eligible_echelon_at_random(arg0: &vector<0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::ModelEchelon>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::random::RandomGenerator) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::empty<EchelonIdAndPerformance>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::ModelEchelon>(arg0)) {
            let v3 = 0x1::vector::borrow<0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::ModelEchelon>(arg0, v2);
            let (v4, v5) = 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::get_model_echelon_fees(v3);
            if (v4 > arg2 || v5 > arg3) {
                v2 = v2 + 1;
                continue
            };
            let v6 = 0x2::table_vec::length<0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::SmallId>(0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::get_model_echelon_nodes(v3));
            if (v6 < arg1) {
                v2 = v2 + 1;
                continue
            };
            let v7 = (0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::get_model_echelon_performance(v3) as u256) * (v6 as u256);
            v0 = v0 + v7;
            let v8 = EchelonIdAndPerformance{
                index       : v2,
                performance : v7,
            };
            0x1::vector::push_back<EchelonIdAndPerformance>(&mut v1, v8);
            v2 = v2 + 1;
        };
        assert!(0x1::vector::length<EchelonIdAndPerformance>(&v1) > 0, 312012100);
        let v9 = v0;
        let v10;
        loop {
            let EchelonIdAndPerformance {
                index       : v10,
                performance : v11,
            } = 0x1::vector::pop_back<EchelonIdAndPerformance>(&mut v1);
            v9 = v9 - v11;
            if (1 + 0x2::random::generate_u256(arg4) % v0 > v9) {
                break
            };
        };
        v10
    }

    fun submit_prompt(arg0: &mut 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::AtomaDb, arg1: &mut 0x2::balance::Balance<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: &mut 0x2::random::RandomGenerator, arg10: &mut 0x2::tx_context::TxContext) : (0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::settlement::SettlementTicket, u64, vector<0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::SmallId>) {
        assert!(0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::get_model_modality(arg0, arg2) == arg3, 312012102);
        let v0 = 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::get_model_echelons_if_enabled(arg0, arg2);
        let v1 = 0x1::option::is_none<u64>(&arg8);
        let v2 = 0x1::option::get_with_default<u64>(&arg8, 1);
        assert!(v2 <= 256, 312012101);
        let v3 = select_eligible_echelon_at_random(v0, v2, arg4, arg6, arg9);
        let v4 = 0x1::vector::borrow<0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::ModelEchelon>(v0, v3);
        let (v5, v6) = 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::get_model_echelon_fees(v4);
        let v7 = 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::sample_unique_nodes_by_echelon_index(arg0, arg2, v3, v2, arg9);
        let v8 = 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::get_cross_validation_extra_nodes_count(arg0);
        let v9 = v5 * arg5 + v6 * arg7;
        let v10 = if (v1) {
            v9 + v8 * v9 * 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::get_cross_validation_probability_permille(arg0) / 1000
        } else {
            v2 * v9
        };
        0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::deposit_to_fee_treasury(arg0, 0x2::balance::split<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>(arg1, v10));
        let v11 = 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::settlement::new_ticket(arg2, 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::get_model_echelon_id(v4), v7, v5, v6, v10, 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::get_model_echelon_settlement_timeout_ms(v4), arg10);
        if (v1) {
            0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::settlement::request_cross_validation(&mut v11, 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::get_cross_validation_probability_permille(arg0), v8);
            (v11, 1 + v8, v7)
        } else {
            (v11, 0x1::vector::length<0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::SmallId>(&v7), v7)
        }
    }

    public fun submit_text2image_prompt(arg0: &mut 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::AtomaDb, arg1: &mut 0x2::balance::Balance<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>, arg2: Text2ImagePromptParams, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: vector<u8>, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::random::new_generator(arg7, arg8);
        let v1 = &mut v0;
        let (v2, v3, v4) = submit_prompt(arg0, arg1, arg2.model, 1, arg3, 0x1::string::length(&arg2.prompt), arg4, arg2.num_samples, arg5, v1, arg8);
        let v5 = v2;
        0x2::dynamic_field::add<0x1::ascii::String, Text2ImagePromptParams>(0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::settlement::ticket_uid(&mut v5), 0x1::ascii::string(b"params"), arg2);
        let v6 = 0x2::object::id<0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::settlement::SettlementTicket>(&v5);
        0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::settlement::return_settlement_ticket(arg0, v5);
        let v7 = Text2ImagePromptEvent{
            ticket_id          : v6,
            params             : arg2,
            chunks_count       : v3,
            nodes              : v4,
            output_destination : arg6,
        };
        0x2::event::emit<Text2ImagePromptEvent>(v7);
        v6
    }

    public fun submit_text2text_prompt(arg0: &mut 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::db::AtomaDb, arg1: &mut 0x2::balance::Balance<0x85b33c1dee78a671da8c7f3b666e8699a8e122865aae37a94b5e3de9499662d7::toma::TOMA>, arg2: Text2TextPromptParams, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: vector<u8>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::random::new_generator(arg6, arg7);
        let v1 = &mut v0;
        let (v2, v3, v4) = submit_prompt(arg0, arg1, arg2.model, 0, arg3, 0x1::vector::length<u32>(&arg2.pre_prompt_tokens) + 0x1::vector::length<u8>(&arg2.prompt), arg3, arg2.max_tokens, arg4, v1, arg7);
        let v5 = v2;
        0x2::dynamic_field::add<0x1::ascii::String, Text2TextPromptParams>(0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::settlement::ticket_uid(&mut v5), 0x1::ascii::string(b"params"), arg2);
        let v6 = 0x2::object::id<0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::settlement::SettlementTicket>(&v5);
        0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::settlement::return_settlement_ticket(arg0, v5);
        let v7 = Text2TextPromptEvent{
            ticket_id          : v6,
            params             : arg2,
            chunks_count       : v3,
            nodes              : v4,
            output_destination : arg5,
        };
        0x2::event::emit<Text2TextPromptEvent>(v7);
        v6
    }

    // decompiled from Move bytecode v6
}

