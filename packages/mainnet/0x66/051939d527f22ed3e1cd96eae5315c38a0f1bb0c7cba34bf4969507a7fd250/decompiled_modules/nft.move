module 0x66051939d527f22ed3e1cd96eae5315c38a0f1bb0c7cba34bf4969507a7fd250::nft {
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
        img_url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    public fun description(arg0: &SuihubNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun img_url(arg0: &SuihubNFT) : &0x2::url::Url {
        &arg0.img_url
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
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(b"Test"),
            img_url     : 0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmQtswV3RoMJ7GQsaUxruLwGnzD1sn58gwQ2suNs2n3bYN"),
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

    // decompiled from Move bytecode v6
}

