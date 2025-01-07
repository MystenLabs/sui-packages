module 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::handle_receive_message {
    struct MintAndWithdraw has copy, drop {
        mint_recipient: address,
        amount: u64,
        mint_token: address,
    }

    public fun handle_receive_message<T0: drop>(arg0: 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::receive_message::Receipt, arg1: &mut 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg2: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg3: &0x2::deny_list::DenyList, arg4: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::receive_message::StampedReceipt {
        0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::version_control::assert_object_version_is_compatible_with_package(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::compatible_versions(arg1));
        assert!(!0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::paused(arg1), 6);
        let v0 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::receive_message::source_domain(&arg0);
        let v1 = 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::from_bytes(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::receive_message::message_body(&arg0));
        assert!(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::amount(&v1) <= 18446744073709551615, 7);
        let v2 = (0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::amount(&v1) as u64);
        validate_remote_token_messenger(v0, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::receive_message::sender(&arg0), arg1);
        validate_burn_message_version(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::version(&v1), arg1);
        let v3 = validate_and_return_local_token<T0>(v0, 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::burn_token(&v1), arg1);
        0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::mint<T0>(arg4, validate_and_return_mint_cap<T0>(v3, arg1), arg3, v2, 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::mint_recipient(&v1), arg5);
        let v4 = MintAndWithdraw{
            mint_recipient : 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::mint_recipient(&v1),
            amount         : v2,
            mint_token     : v3,
        };
        0x2::event::emit<MintAndWithdraw>(v4);
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::receive_message::stamp_receipt<0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::message_transmitter_authenticator::MessageTransmitterAuthenticator>(arg0, 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::message_transmitter_authenticator::new(), arg2)
    }

    fun validate_and_return_local_token<T0: drop>(arg0: u32, arg1: address, arg2: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State) : address {
        assert!(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::local_token_from_remote_token_exists(arg2, arg0, arg1), 3);
        let v0 = 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::local_token_from_remote_token(arg2, arg0, arg1);
        assert!(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::token_utils::calculate_token_id<T0>() == v0, 4);
        v0
    }

    fun validate_and_return_mint_cap<T0: drop>(arg0: address, arg1: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State) : &0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0> {
        assert!(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::mint_cap_for_local_token_exists(arg1, arg0), 5);
        0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::mint_cap_from_token_id<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>>(arg1, arg0)
    }

    fun validate_burn_message_version(arg0: u32, arg1: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State) {
        assert!(arg0 == 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::message_body_version(arg1), 2);
    }

    fun validate_remote_token_messenger(arg0: u32, arg1: address, arg2: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State) {
        assert!(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::remote_token_messenger_for_remote_domain_exists(arg2, arg0), 0);
        assert!(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::remote_token_messenger_from_remote_domain(arg2, arg0) == arg1 && arg1 != @0x0, 1);
    }

    // decompiled from Move bytecode v6
}

