module 0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::unlock {
    public fun asset_from_kiosk_to_burn(arg0: 0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::golden_key::GoldenKey, arg1: &0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::proxy::ProtectedTP<0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::golden_key::GoldenKey>, arg2: 0x2::transfer_policy::TransferRequest<0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::golden_key::GoldenKey>, arg3: &0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::golden_key::Version, arg4: &mut 0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::golden_key::GkSupply) {
        0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::golden_key::checkVersion(arg3, 1);
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::golden_key::GoldenKey>(0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::proxy::transfer_policy<0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::golden_key::GoldenKey>(arg1), arg2);
        assert!(0x2::object::id<0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::golden_key::GoldenKey>(&arg0) == v0, 1);
        0xf07758ea7c7e266611bdd63c386f907dfc4cc7bb746f41152634ee704c20c421::golden_key::burn_golden_key(arg0, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

