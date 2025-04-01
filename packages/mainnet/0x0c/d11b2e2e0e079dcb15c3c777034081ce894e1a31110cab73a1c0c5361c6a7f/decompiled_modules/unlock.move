module 0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::unlock {
    public fun confirm_request(arg0: &0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::proxy::ProtectedTP<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>, arg1: 0x2::transfer_policy::TransferRequest<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>(0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::proxy::transfer_policy<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>(arg0), arg1);
    }

    public fun asset_from_kiosk_to_burn(arg0: 0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT, arg1: &0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::proxy::ProtectedTP<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>, arg2: 0x2::transfer_policy::TransferRequest<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>) {
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>(0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::proxy::transfer_policy<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>(arg1), arg2);
        assert!(0x2::object::id<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>(&arg0) == v0, 1);
        0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::burn(arg0);
    }

    public fun asset_from_kiosk_to_unlock(arg0: 0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT, arg1: &0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::proxy::ProtectedTP<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>, arg2: 0x2::transfer_policy::TransferRequest<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>) : 0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>(0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::proxy::transfer_policy<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>(arg1), arg2);
        arg0
    }

    // decompiled from Move bytecode v6
}

