module 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::pausable {
    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Unpause has copy, drop {
        dummy_field: bool,
    }

    entry fun pause(arg0: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg1: &0x2::tx_context::TxContext) {
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::assert_object_version_is_compatible_with_package(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(!0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::paused(arg0), 1);
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::set_paused(arg0, true);
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    entry fun unpause(arg0: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg1: &0x2::tx_context::TxContext) {
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::assert_object_version_is_compatible_with_package(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::paused(arg0), 2);
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::set_paused(arg0, false);
        let v0 = Unpause{dummy_field: false};
        0x2::event::emit<Unpause>(v0);
    }

    fun verify_pauser(arg0: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::roles::pauser(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::roles(arg0)), 0);
    }

    // decompiled from Move bytecode v6
}

