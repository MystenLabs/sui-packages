module 0xc00102ae8af7de683277d219444549c4f2d717b69d07b3926c8acd3538945b38::nft {
    struct Global has key {
        id: 0x2::object::UID,
        current_id: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SuihubNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        thumbnail_url: 0x2::url::Url,
        image_url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    public entry fun burn(arg0: SuihubNFT) {
        let SuihubNFT {
            id            : v0,
            name          : _,
            description   : _,
            project_url   : _,
            thumbnail_url : _,
            image_url     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SuihubNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &SuihubNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id         : 0x2::object::new(arg0),
            current_id : 1,
        };
        0x2::transfer::share_object<Global>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &mut Global, arg1: &AdminCap, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SuihubNFT{
            id            : 0x2::object::new(arg4),
            name          : 0x1::string::utf8(arg2),
            description   : 0x1::string::utf8(b"test"),
            project_url   : 0x1::string::utf8(b"https://test.io/"),
            thumbnail_url : 0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY1F1bs2qdvC6hJ2uV4pSh8GCLXV354B119HNAbrwaSdd"),
            image_url     : 0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY1F1bs2qdvC6hJ2uV4pSh8GCLXV354B119HNAbrwaSdd"),
        };
        arg0.current_id = arg0.current_id + 1;
        let v1 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            owner     : arg3,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        0x2::transfer::public_transfer<SuihubNFT>(v0, arg3);
    }

    public fun name(arg0: &SuihubNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut SuihubNFT, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

