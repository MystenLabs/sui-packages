module 0xb0230f55f042d55838f312cb193ec67df1ed2a0fb2ce48a18183e7e67878103f::formchain_seal {
    public entry fun seal_approve(arg0: vector<u8>, arg1: &0xb0230f55f042d55838f312cb193ec67df1ed2a0fb2ce48a18183e7e67878103f::formchain::FormOwnerCap, arg2: &0xb0230f55f042d55838f312cb193ec67df1ed2a0fb2ce48a18183e7e67878103f::formchain::Form, arg3: &0x2::tx_context::TxContext) {
        assert!(0xb0230f55f042d55838f312cb193ec67df1ed2a0fb2ce48a18183e7e67878103f::formchain::cap_owner(arg1) == 0x2::tx_context::sender(arg3), 1);
        assert!(0xb0230f55f042d55838f312cb193ec67df1ed2a0fb2ce48a18183e7e67878103f::formchain::cap_form_id(arg1) == 0x2::object::id<0xb0230f55f042d55838f312cb193ec67df1ed2a0fb2ce48a18183e7e67878103f::formchain::Form>(arg2), 1);
    }

    // decompiled from Move bytecode v7
}

