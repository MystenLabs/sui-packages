module 0x16dae14aafeb0d204d337bc5b402b2d29e7765ed016e79f42d8e77cdc3a940a6::nftwallet {
    struct ArchiveBox has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        owner: address,
        nft_ids: vector<0x2::object::ID>,
    }

    public entry fun create_wallet(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ArchiveBox{
            id        : 0x2::object::new(arg1),
            name      : arg0,
            image_url : 0x1::string::utf8(b"https://raw.githubusercontent.com/0xmurphyf/TheArchive/main/public/archive-assets/memory-vial.png"),
            owner     : 0x2::tx_context::sender(arg1),
            nft_ids   : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::public_transfer<ArchiveBox>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_image_url(arg0: &mut ArchiveBox, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.image_url = arg1;
    }

    public entry fun transfer_wallet(arg0: ArchiveBox, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::transfer::public_transfer<ArchiveBox>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

