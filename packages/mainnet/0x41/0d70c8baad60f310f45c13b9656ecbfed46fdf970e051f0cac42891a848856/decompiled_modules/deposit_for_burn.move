module 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::deposit_for_burn {
    struct DepositForBurn has copy, drop {
        nonce: u64,
        burn_token: address,
        amount: u64,
        depositor: address,
        mint_recipient: address,
        destination_domain: u32,
        destination_token_messenger: address,
        destination_caller: address,
    }

    public fun deposit_for_burn<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: address, arg3: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg4: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg5: &0x2::deny_list::DenyList, arg6: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg7: &0x2::tx_context::TxContext) : (0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::BurnMessage, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::Message) {
        deposit_for_burn_shared<T0>(arg0, arg1, arg2, @0x0, arg3, arg4, arg5, arg6, arg7)
    }

    fun deposit_for_burn_shared<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: address, arg3: address, arg4: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg5: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg6: &0x2::deny_list::DenyList, arg7: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg8: &0x2::tx_context::TxContext) : (0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::BurnMessage, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::Message) {
        0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::version_control::assert_object_version_is_compatible_with_package(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::compatible_versions(arg4));
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::token_utils::calculate_token_id<T0>();
        assert!(!0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::paused(arg4), 3);
        assert!(v0 > 0, 0);
        assert!(arg2 != @0x0, 1);
        let v2 = safe_get_remote_token_messenger(arg1, arg4);
        let v3 = safe_get_mint_cap<T0>(v1, arg4);
        assert!(safe_get_burn_limit(v1, arg4) >= v0, 6);
        0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::burn<T0>(arg7, v3, arg6, arg0, arg8);
        let v4 = 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::new(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::message_body_version(arg4), v1, arg2, (v0 as u256), 0x2::tx_context::sender(arg8));
        let v5 = send_deposit_for_burn_message(arg1, v2, arg3, &v4, arg5);
        let v6 = DepositForBurn{
            nonce                       : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v5),
            burn_token                  : v1,
            amount                      : v0,
            depositor                   : 0x2::tx_context::sender(arg8),
            mint_recipient              : arg2,
            destination_domain          : arg1,
            destination_token_messenger : v2,
            destination_caller          : arg3,
        };
        0x2::event::emit<DepositForBurn>(v6);
        (v4, v5)
    }

    public fun deposit_for_burn_with_caller<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: address, arg3: address, arg4: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg5: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg6: &0x2::deny_list::DenyList, arg7: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg8: &0x2::tx_context::TxContext) : (0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::BurnMessage, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::Message) {
        deposit_for_burn_shared<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    entry fun replace_deposit_for_burn(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<address>, arg4: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg5: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg6: &0x2::tx_context::TxContext) : (0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::BurnMessage, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::Message) {
        0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::version_control::assert_object_version_is_compatible_with_package(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::compatible_versions(arg4));
        let v0 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::from_bytes(&arg0);
        let v1 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::message_body(&v0);
        let v2 = 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::from_bytes(&v1);
        assert!(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::message_sender(&v2) == 0x2::tx_context::sender(arg6), 7);
        let v3 = 0x1::option::get_with_default<address>(&arg3, 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::mint_recipient(&v2));
        assert!(v3 != @0x0, 1);
        0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::update_mint_recipient(&mut v2, v3);
        0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::update_version(&mut v2, 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::message_body_version(arg4));
        let v4 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::send_message::replace_message<0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::message_transmitter_authenticator::new(), arg0, arg1, 0x1::option::some<vector<u8>>(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::serialize(&v2)), arg2, arg5);
        let v5 = DepositForBurn{
            nonce                       : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v0),
            burn_token                  : 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::burn_token(&v2),
            amount                      : (0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::amount(&v2) as u64),
            depositor                   : 0x2::tx_context::sender(arg6),
            mint_recipient              : v3,
            destination_domain          : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::destination_domain(&v0),
            destination_token_messenger : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::recipient(&v0),
            destination_caller          : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::destination_caller(&v4),
        };
        0x2::event::emit<DepositForBurn>(v5);
        (v2, v4)
    }

    fun safe_get_burn_limit(arg0: address, arg1: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State) : u64 {
        assert!(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::burn_limit_for_token_id_exists(arg1, arg0), 5);
        0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::burn_limit_from_token_id(arg1, arg0)
    }

    fun safe_get_mint_cap<T0>(arg0: address, arg1: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State) : &0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0> {
        assert!(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::mint_cap_for_local_token_exists(arg1, arg0), 4);
        0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::mint_cap_from_token_id<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::MintCap<T0>>(arg1, arg0)
    }

    fun safe_get_remote_token_messenger(arg0: u32, arg1: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State) : address {
        assert!(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::remote_token_messenger_for_remote_domain_exists(arg1, arg0), 2);
        0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::remote_token_messenger_from_remote_domain(arg1, arg0)
    }

    fun send_deposit_for_burn_message(arg0: u32, arg1: address, arg2: address, arg3: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::BurnMessage, arg4: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State) : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::Message {
        if (arg2 == @0x0) {
            0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::send_message::send_message<0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::message_transmitter_authenticator::new(), arg0, arg1, 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::serialize(arg3), arg4)
        } else {
            0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::send_message::send_message_with_caller<0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::message_transmitter_authenticator::MessageTransmitterAuthenticator>(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::message_transmitter_authenticator::new(), arg0, arg1, arg2, 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::serialize(arg3), arg4)
        }
    }

    // decompiled from Move bytecode v6
}

