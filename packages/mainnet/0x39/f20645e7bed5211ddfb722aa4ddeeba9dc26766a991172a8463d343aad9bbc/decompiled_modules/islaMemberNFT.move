module 0x39f20645e7bed5211ddfb722aa4ddeeba9dc26766a991172a8463d343aad9bbc::islaMemberNFT {
    struct AssetCap has key {
        id: 0x2::object::UID,
        supply: u64,
        total_supply: u64,
    }

    struct AccessControl has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct IslaNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        level: u64,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        level: u64,
    }

    public fun url(arg0: &IslaNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun description(arg0: &IslaNFT) : &0x1::string::String {
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

    public entry fun leve_up(arg0: &mut IslaNFT, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.level = 1;
    }

    public entry fun mintNFT(arg0: &mut AssetCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.supply + 1 <= arg0.total_supply, 1);
        arg0.supply = arg0.supply + 1;
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = IslaNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
            level       : 0,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<IslaNFT>(&v1),
            creator   : v0,
            name      : v1.name,
            level     : 0,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<IslaNFT>(v1, v0);
    }

    public fun name(arg0: &IslaNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun set_max_amount(arg0: &AccessControl, arg1: &mut AssetCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        arg1.total_supply = arg2;
    }

    public fun supply(arg0: &AssetCap) : u64 {
        arg0.supply
    }

    public fun total_supply(arg0: &AssetCap) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

