module 0x3d064f27631e27464003ce4f25ccddaf9a5bcd4d37c409039dcce3f9d3c64fcc::sony9997_nft {
    struct Sony9997NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: Sony9997NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Sony9997NFT>(arg0, arg1);
    }

    public fun url(arg0: &Sony9997NFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: Sony9997NFT) {
        let Sony9997NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Sony9997NFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Sony9997NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<Sony9997NFT>(v0, v1);
    }

    public fun name(arg0: &Sony9997NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut Sony9997NFT, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

