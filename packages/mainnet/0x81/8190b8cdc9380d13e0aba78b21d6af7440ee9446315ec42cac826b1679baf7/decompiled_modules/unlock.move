module 0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::unlock {
    public fun asset_from_kiosk_to_burn(arg0: 0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::golden_key::GoldenKey, arg1: &0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::proxy::ProtectedTP<0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::golden_key::GoldenKey>, arg2: 0x2::transfer_policy::TransferRequest<0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::golden_key::GoldenKey>, arg3: &0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::golden_key::Version, arg4: &mut 0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::golden_key::GkSupply) {
        0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::golden_key::checkVersion(arg3, 1);
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::golden_key::GoldenKey>(0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::proxy::transfer_policy<0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::golden_key::GoldenKey>(arg1), arg2);
        assert!(0x2::object::id<0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::golden_key::GoldenKey>(&arg0) == v0, 1);
        0x818190b8cdc9380d13e0aba78b21d6af7440ee9446315ec42cac826b1679baf7::golden_key::burn_golden_key(arg0, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

