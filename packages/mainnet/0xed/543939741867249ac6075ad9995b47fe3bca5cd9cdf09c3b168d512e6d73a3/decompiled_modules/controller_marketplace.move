module 0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller_marketplace {
    struct CONTROLLER_MARKETPLACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONTROLLER_MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CONTROLLER_MARKETPLACE>(arg0, arg1);
        let v1 = 0x2::display::new<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&v0, arg1);
        0x2::display::add<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"PaperProof Controller NFT: {artifact_code}"));
        0x2::display::add<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Transferable control rights for PaperProof artifact series {artifact_code}."));
        0x2::display::add<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&mut v1, 0x1::string::utf8(b"image"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&mut v1, 0x1::string::utf8(b"artifact_code"), 0x1::string::utf8(b"{artifact_code}"));
        0x2::display::add<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&mut v1, 0x1::string::utf8(b"series_id"), 0x1::string::utf8(b"{series_id}"));
        0x2::display::add<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&mut v1, 0x1::string::utf8(b"artifact_type"), 0x1::string::utf8(b"{artifact_type_name}"));
        0x2::display::add<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&mut v1, 0x1::string::utf8(b"control_right"), 0x1::string::utf8(b"{control_right}"));
        0x2::display::add<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&mut v1, 0x1::string::utf8(b"authority_mode"), 0x1::string::utf8(b"{authority_mode_name}"));
        0x2::display::add<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&mut v1, 0x1::string::utf8(b"controller_nft_id"), 0x1::string::utf8(b"{id}"));
        0x2::display::update_version<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>>(v1);
        let (v2, v3) = 0x2::transfer_policy::new<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller::ControllerNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::package::burn_publisher(v0);
    }

    // decompiled from Move bytecode v7
}

