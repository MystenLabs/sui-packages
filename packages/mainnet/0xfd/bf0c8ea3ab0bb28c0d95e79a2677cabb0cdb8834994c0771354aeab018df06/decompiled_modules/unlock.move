module 0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::unlock {
    public fun confirm_request(arg0: &0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::proxy::ProtectedTP<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>, arg1: 0x2::transfer_policy::TransferRequest<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>(0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::proxy::transfer_policy<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>(arg0), arg1);
    }

    public fun asset_from_kiosk_to_burn(arg0: 0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT, arg1: &0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::proxy::ProtectedTP<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>, arg2: 0x2::transfer_policy::TransferRequest<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>) {
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>(0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::proxy::transfer_policy<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>(arg1), arg2);
        assert!(0x2::object::id<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>(&arg0) == v0, 1);
        0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::burn(arg0);
    }

    public fun asset_from_kiosk_to_unlock(arg0: 0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT, arg1: &0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::proxy::ProtectedTP<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>, arg2: 0x2::transfer_policy::TransferRequest<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>) : 0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>(0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::proxy::transfer_policy<0xfdbf0c8ea3ab0bb28c0d95e79a2677cabb0cdb8834994c0771354aeab018df06::hello_world::NFT>(arg1), arg2);
        arg0
    }

    // decompiled from Move bytecode v6
}

