module 0x1cdf9026d6ba0fc7cf7896e21c52f906a0e0319cb1fb56806cab5c056ad5828d::user_profile {
    public fun mint_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg4);
        let v2 = v1;
        let v3 = v0;
        0x2::kiosk::place<0x1cdf9026d6ba0fc7cf7896e21c52f906a0e0319cb1fb56806cab5c056ad5828d::user_profile_nft::UserProfileNFT>(&mut v3, &v2, 0x1cdf9026d6ba0fc7cf7896e21c52f906a0e0319cb1fb56806cab5c056ad5828d::user_profile_nft::mint(arg0, arg1, arg2, arg3, arg4));
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    // decompiled from Move bytecode v6
}

