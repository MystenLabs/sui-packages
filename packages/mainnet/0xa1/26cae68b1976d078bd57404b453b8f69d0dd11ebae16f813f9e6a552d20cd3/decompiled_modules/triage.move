module 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::triage {
    fun is_valid_transition(arg0: u8, arg1: u8) : bool {
        let v0 = 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::status_triaged();
        arg0 == 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::status_open() && (arg1 == v0 || arg1 == 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::status_resolved()) || arg0 == v0 && (arg1 == 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::status_in_progress() || arg1 == 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::status_resolved()) || arg0 == 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::status_in_progress() && (arg1 == 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::status_resolved() || arg1 == v0)
    }

    public fun transition(arg0: &0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::Form, arg1: &mut 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::Submission, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::owner(arg0) == 0x2::tx_context::sender(arg3), 1);
        assert!(0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::form_id(arg1) == 0x2::object::id<0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::Form>(arg0), 2);
        assert!(is_valid_transition(0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::status(arg1), arg2), 3);
        0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::set_status(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

