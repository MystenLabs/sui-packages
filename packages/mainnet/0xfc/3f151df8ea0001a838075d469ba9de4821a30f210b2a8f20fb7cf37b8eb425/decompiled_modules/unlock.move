module 0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::unlock {
    public fun confirm_request(arg0: &0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::proxy::ProtectedTP<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>, arg1: 0x2::transfer_policy::TransferRequest<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>(0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::proxy::transfer_policy<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>(arg0), arg1);
    }

    public fun asset_from_kiosk_to_unlock(arg0: 0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT, arg1: &0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::proxy::ProtectedTP<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>, arg2: 0x2::transfer_policy::TransferRequest<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>) : 0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>(0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::proxy::transfer_policy<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>(arg1), arg2);
        arg0
    }

    // decompiled from Move bytecode v6
}

