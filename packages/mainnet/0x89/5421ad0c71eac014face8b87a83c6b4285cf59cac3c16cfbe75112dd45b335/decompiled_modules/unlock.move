module 0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::unlock {
    public fun asset_from_kiosk_to_burn(arg0: 0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::golden_key::GoldenKey, arg1: &0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::proxy::ProtectedTP<0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::golden_key::GoldenKey>, arg2: 0x2::transfer_policy::TransferRequest<0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::golden_key::GoldenKey>, arg3: &0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::golden_key::Version, arg4: &mut 0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::golden_key::GkSupply) {
        0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::golden_key::checkVersion(arg3, 1);
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::golden_key::GoldenKey>(0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::proxy::transfer_policy<0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::golden_key::GoldenKey>(arg1), arg2);
        assert!(0x2::object::id<0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::golden_key::GoldenKey>(&arg0) == v0, 1);
        0x895421ad0c71eac014face8b87a83c6b4285cf59cac3c16cfbe75112dd45b335::golden_key::burn_golden_key(arg0, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

