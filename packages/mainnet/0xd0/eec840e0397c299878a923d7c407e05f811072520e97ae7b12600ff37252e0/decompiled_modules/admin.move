module 0xd0eec840e0397c299878a923d7c407e05f811072520e97ae7b12600ff37252e0::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun init_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun withdraw_royalty(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xd0eec840e0397c299878a923d7c407e05f811072520e97ae7b12600ff37252e0::nft::MegaTowerNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<0xd0eec840e0397c299878a923d7c407e05f811072520e97ae7b12600ff37252e0::nft::MegaTowerNFT>, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<0xd0eec840e0397c299878a923d7c407e05f811072520e97ae7b12600ff37252e0::nft::MegaTowerNFT>(arg1, arg2, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v7
}

