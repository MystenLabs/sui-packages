module 0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::unlock {
    public fun confirm_request(arg0: &0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::proxy::ProtectedTP<0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::nft::TestNFT>, arg1: 0x2::transfer_policy::TransferRequest<0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::nft::TestNFT>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::nft::TestNFT>(0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::proxy::transfer_policy<0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::nft::TestNFT>(arg0), arg1);
    }

    public fun asset_from_kiosk_to_unlock(arg0: 0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::nft::TestNFT, arg1: &0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::proxy::ProtectedTP<0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::nft::TestNFT>, arg2: 0x2::transfer_policy::TransferRequest<0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::nft::TestNFT>) : 0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::nft::TestNFT {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::nft::TestNFT>(0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::proxy::transfer_policy<0x436e48ea3bbdda5d34b221bf580ae5e66fa04f5242478443a449277166bfe5cc::nft::TestNFT>(arg1), arg2);
        arg0
    }

    // decompiled from Move bytecode v6
}

