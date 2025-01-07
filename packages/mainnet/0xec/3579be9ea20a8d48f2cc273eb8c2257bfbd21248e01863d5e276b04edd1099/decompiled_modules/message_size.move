module 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::message_size {
    struct MaxMessageBodySizeUpdated has copy, drop {
        new_max_message_body_size: u64,
    }

    entry fun set_max_message_body_size(arg0: u64, arg1: &mut 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg2: &0x2::tx_context::TxContext) {
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg1));
        assert!(0x2::tx_context::sender(arg2) == 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::owner(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles(arg1)), 0);
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::set_max_message_body_size(arg1, arg0);
        let v0 = MaxMessageBodySizeUpdated{new_max_message_body_size: arg0};
        0x2::event::emit<MaxMessageBodySizeUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

