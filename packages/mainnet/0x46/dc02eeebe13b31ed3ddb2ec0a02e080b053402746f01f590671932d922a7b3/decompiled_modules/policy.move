module 0x46dc02eeebe13b31ed3ddb2ec0a02e080b053402746f01f590671932d922a7b3::policy {
    public fun seal_approve(arg0: vector<u8>, arg1: &0x46dc02eeebe13b31ed3ddb2ec0a02e080b053402746f01f590671932d922a7b3::form::AdminCap) {
        let v0 = 0x46dc02eeebe13b31ed3ddb2ec0a02e080b053402746f01f590671932d922a7b3::form::cap_form_id(arg1);
        assert!(0x2::object::id_to_bytes(&v0) == arg0, 0);
    }

    // decompiled from Move bytecode v6
}

