module 0x28646b319cce050df680326445885aaae070d5a27f22bab903f6efbebace9bf::nft {
    struct VaultNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    public entry fun burn(arg0: VaultNFT) {
        let VaultNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &VaultNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &VaultNFT) : &0x1::string::String {
        &arg0.image_url
    }

    public entry fun mint_to(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultNFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<VaultNFT>(&v0),
            name      : v0.name,
            creator   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<VaultNFT>(v0, arg3);
    }

    public entry fun mint_to_sender(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = VaultNFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<VaultNFT>(&v1),
            name      : v1.name,
            creator   : v0,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<VaultNFT>(v1, v0);
    }

    public fun name(arg0: &VaultNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut VaultNFT, arg1: 0x1::string::String) {
        arg0.description = arg1;
    }

    // decompiled from Move bytecode v6
}

