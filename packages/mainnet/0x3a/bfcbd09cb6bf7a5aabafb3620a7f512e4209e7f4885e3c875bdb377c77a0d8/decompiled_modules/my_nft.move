module 0x3abfcbd09cb6bf7a5aabafb3620a7f512e4209e7f4885e3c875bdb377c77a0d8::my_nft {
    struct MY_NFT has drop {
        dummy_field: bool,
    }

    struct MyNft has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MY_NFT>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<MyNft>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<MyNft>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<MyNft>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) : MyNft {
        MyNft{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v7
}

