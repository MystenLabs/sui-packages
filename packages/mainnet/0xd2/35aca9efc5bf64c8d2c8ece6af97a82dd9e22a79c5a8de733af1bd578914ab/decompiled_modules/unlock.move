module 0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::unlock {
    public fun asset_from_kiosk_to_burn(arg0: 0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::golden_key::GoldenKey, arg1: &0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::proxy::ProtectedTP<0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::golden_key::GoldenKey>, arg2: 0x2::transfer_policy::TransferRequest<0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::golden_key::GoldenKey>, arg3: &0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::golden_key::Version, arg4: &mut 0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::golden_key::GkSupply) {
        0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::golden_key::checkVersion(arg3, 1);
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::golden_key::GoldenKey>(0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::proxy::transfer_policy<0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::golden_key::GoldenKey>(arg1), arg2);
        assert!(0x2::object::id<0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::golden_key::GoldenKey>(&arg0) == v0, 1);
        0xd235aca9efc5bf64c8d2c8ece6af97a82dd9e22a79c5a8de733af1bd578914ab::golden_key::burn_golden_key(arg0, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

