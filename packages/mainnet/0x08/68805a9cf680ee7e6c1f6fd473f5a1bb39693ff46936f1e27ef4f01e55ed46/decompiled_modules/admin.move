module 0x868805a9cf680ee7e6c1f6fd473f5a1bb39693ff46936f1e27ef4f01e55ed46::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun init_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun withdraw_royalty(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x868805a9cf680ee7e6c1f6fd473f5a1bb39693ff46936f1e27ef4f01e55ed46::nft::MegaTowerNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<0x868805a9cf680ee7e6c1f6fd473f5a1bb39693ff46936f1e27ef4f01e55ed46::nft::MegaTowerNFT>, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<0x868805a9cf680ee7e6c1f6fd473f5a1bb39693ff46936f1e27ef4f01e55ed46::nft::MegaTowerNFT>(arg1, arg2, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v7
}

