module 0xc668378c14c3653360e432d7b4f4aa229a6faf3c4d95ec05249c680b7cad01f3::devnet_nft {
    struct DevNetNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        power: u8,
    }

    struct Ownership has key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct NFTUpgrade has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        power: u8,
    }

    public entry fun transfer(arg0: DevNetNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<DevNetNFT>(arg0, arg1);
    }

    public fun url(arg0: &DevNetNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: DevNetNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let DevNetNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            power       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &DevNetNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Ownership{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Ownership>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_to_sender(arg0: &Ownership, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = DevNetNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
            power       : 0,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<DevNetNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<DevNetNFT>(v1, v0);
    }

    public fun name(arg0: &DevNetNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun power(arg0: &DevNetNFT) : &u8 {
        &arg0.power
    }

    public entry fun update_description(arg0: &mut DevNetNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public entry fun upgrade_power(arg0: &Ownership, arg1: &mut DevNetNFT, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.power = arg1.power + 1;
        let v0 = NFTUpgrade{
            object_id : 0x2::object::id<DevNetNFT>(arg1),
            creator   : 0x2::tx_context::sender(arg2),
            name      : arg1.name,
            power     : arg1.power,
        };
        0x2::event::emit<NFTUpgrade>(v0);
    }

    // decompiled from Move bytecode v6
}

