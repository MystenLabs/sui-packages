module 0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::policy {
    public fun seal_approve_delegated(arg0: vector<u8>, arg1: &0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::workspace::Workspace, arg2: &0x2::tx_context::TxContext) {
        assert!(0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::workspace::access(arg1) == 0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::workspace::access_delegated(), 2);
        assert!(0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::workspace::is_delegate(arg1, 0x2::tx_context::sender(arg2)), 1);
    }

    public fun seal_approve_owner(arg0: vector<u8>, arg1: &0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::workspace::Workspace, arg2: &0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::workspace::WorkspaceCap, arg3: &0x2::tx_context::TxContext) {
        assert!(0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::workspace::access(arg1) != 0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::workspace::access_public(), 2);
        assert!(0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::workspace::cap_workspace(arg2) == 0x2::object::id<0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::workspace::Workspace>(arg1), 0);
    }

    // decompiled from Move bytecode v7
}

