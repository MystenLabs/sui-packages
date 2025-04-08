module 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::unlock {
    public fun confirm_request(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::proxy::ProtectedTP<0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::nft::TestNFT>, arg1: 0x2::transfer_policy::TransferRequest<0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::nft::TestNFT>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::nft::TestNFT>(0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::proxy::transfer_policy<0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::nft::TestNFT>(arg0), arg1);
    }

    public fun asset_from_kiosk_to_unlock(arg0: 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::nft::TestNFT, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::proxy::ProtectedTP<0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::nft::TestNFT>, arg2: 0x2::transfer_policy::TransferRequest<0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::nft::TestNFT>) : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::nft::TestNFT {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::nft::TestNFT>(0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::proxy::transfer_policy<0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::nft::TestNFT>(arg1), arg2);
        arg0
    }

    // decompiled from Move bytecode v6
}

