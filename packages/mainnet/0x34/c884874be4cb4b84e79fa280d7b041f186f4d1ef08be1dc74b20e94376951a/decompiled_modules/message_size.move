module 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message_size {
    struct MaxMessageBodySizeUpdated has copy, drop {
        new_max_message_body_size: u64,
    }

    entry fun set_max_message_body_size(arg0: u64, arg1: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x2::tx_context::TxContext) {
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::assert_object_version_is_compatible_with_package(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::compatible_versions(arg1));
        assert!(0x2::tx_context::sender(arg2) == 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::roles::owner(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::roles(arg1)), 0);
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::set_max_message_body_size(arg1, arg0);
        let v0 = MaxMessageBodySizeUpdated{new_max_message_body_size: arg0};
        0x2::event::emit<MaxMessageBodySizeUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

