module 0x50c18585d5f640d014aa2e6625d51035d995b2bb7efe3c538a517d0444120292::islasilvernft {
    struct AssetCap has key {
        id: 0x2::object::UID,
        supply: u64,
        total_supply: u64,
    }

    struct AccessControl has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct IslaSilverNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &IslaSilverNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun description(arg0: &IslaSilverNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetCap{
            id           : 0x2::object::new(arg0),
            supply       : 0,
            total_supply : 0,
        };
        let v1 = AccessControl{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<AssetCap>(v0);
        0x2::transfer::share_object<AccessControl>(v1);
    }

    public fun mintNFT(arg0: &mut AssetCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : IslaSilverNFT {
        assert!(arg0.supply + 1 <= arg0.total_supply, 1);
        arg0.supply = arg0.supply + 1;
        let v0 = IslaSilverNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<IslaSilverNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        v0
    }

    public fun name(arg0: &IslaSilverNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun supply(arg0: &AssetCap) : u64 {
        arg0.supply
    }

    public fun total_supply(arg0: &AssetCap) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

