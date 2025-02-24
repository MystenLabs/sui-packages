module 0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::unlock {
    public fun asset_from_kiosk_to_burn(arg0: 0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GoldenKey, arg1: &0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::proxy::ProtectedTP<0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GoldenKey>, arg2: 0x2::transfer_policy::TransferRequest<0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GoldenKey>, arg3: &0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::Version, arg4: &mut 0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GkSupply) {
        0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::checkVersion(arg3, 1);
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GoldenKey>(0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::proxy::transfer_policy<0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GoldenKey>(arg1), arg2);
        assert!(0x2::object::id<0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GoldenKey>(&arg0) == v0, 1);
        0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::burn_golden_key(arg0, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

