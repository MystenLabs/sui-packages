module 0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::unlock {
    public fun asset_from_kiosk_to_burn(arg0: 0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::golden_key::GoldenKey, arg1: &0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::proxy::ProtectedTP<0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::golden_key::GoldenKey>, arg2: 0x2::transfer_policy::TransferRequest<0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::golden_key::GoldenKey>, arg3: &0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::golden_key::Version, arg4: &mut 0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::golden_key::GkSupply) {
        0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::golden_key::checkVersion(arg3, 1);
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::golden_key::GoldenKey>(0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::proxy::transfer_policy<0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::golden_key::GoldenKey>(arg1), arg2);
        assert!(0x2::object::id<0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::golden_key::GoldenKey>(&arg0) == v0, 1);
        0x78ddda067d8f156129542d332b5da29c2308c42e091390cbdb226767fad5584c::golden_key::burn_golden_key(arg0, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

