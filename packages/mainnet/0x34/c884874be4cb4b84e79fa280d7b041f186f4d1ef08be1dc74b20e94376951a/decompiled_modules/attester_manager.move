module 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::attester_manager {
    struct SignatureThresholdUpdated has copy, drop {
        old_signature_threshold: u64,
        new_signature_threshold: u64,
    }

    struct AttesterEnabled has copy, drop {
        attester: address,
    }

    struct AttesterDisabled has copy, drop {
        attester: address,
    }

    entry fun disable_attester(arg0: address, arg1: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x2::tx_context::TxContext) {
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::assert_object_version_is_compatible_with_package(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::compatible_versions(arg1));
        verify_attester_manager(arg1, arg2);
        let v0 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::get_num_enabled_attesters(arg1);
        assert!(v0 > 1, 3);
        assert!(v0 > 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::signature_threshold(arg1), 4);
        assert!(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::is_attester_enabled(arg1, arg0), 1);
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::disable_attester(arg1, arg0);
        let v1 = AttesterDisabled{attester: arg0};
        0x2::event::emit<AttesterDisabled>(v1);
    }

    entry fun enable_attester(arg0: address, arg1: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x2::tx_context::TxContext) {
        enable_attester_internal(arg0, arg1, arg2);
    }

    public(friend) fun enable_attester_internal(arg0: address, arg1: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x2::tx_context::TxContext) {
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::assert_object_version_is_compatible_with_package(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::compatible_versions(arg1));
        verify_attester_manager(arg1, arg2);
        assert!(!0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::is_attester_enabled(arg1, arg0), 0);
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::enable_attester(arg1, arg0);
        let v0 = AttesterEnabled{attester: arg0};
        0x2::event::emit<AttesterEnabled>(v0);
    }

    entry fun set_signature_threshold(arg0: u64, arg1: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x2::tx_context::TxContext) {
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::assert_object_version_is_compatible_with_package(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::compatible_versions(arg1));
        verify_attester_manager(arg1, arg2);
        assert!(arg0 != 0, 7);
        assert!(arg0 <= 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::get_num_enabled_attesters(arg1), 6);
        assert!(arg0 != 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::signature_threshold(arg1), 5);
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::set_signature_threshold(arg1, arg0);
        let v0 = SignatureThresholdUpdated{
            old_signature_threshold : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::signature_threshold(arg1),
            new_signature_threshold : arg0,
        };
        0x2::event::emit<SignatureThresholdUpdated>(v0);
    }

    fun verify_attester_manager(arg0: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::roles::attester_manager(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::roles(arg0)), 2);
    }

    // decompiled from Move bytecode v6
}

