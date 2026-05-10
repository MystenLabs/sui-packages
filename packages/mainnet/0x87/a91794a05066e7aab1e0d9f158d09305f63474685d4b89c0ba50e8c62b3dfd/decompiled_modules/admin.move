module 0x87a91794a05066e7aab1e0d9f158d09305f63474685d4b89c0ba50e8c62b3dfd::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun init_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun withdraw_royalty(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x87a91794a05066e7aab1e0d9f158d09305f63474685d4b89c0ba50e8c62b3dfd::nft::MegaTowerNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<0x87a91794a05066e7aab1e0d9f158d09305f63474685d4b89c0ba50e8c62b3dfd::nft::MegaTowerNFT>, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<0x87a91794a05066e7aab1e0d9f158d09305f63474685d4b89c0ba50e8c62b3dfd::nft::MegaTowerNFT>(arg1, arg2, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v7
}

