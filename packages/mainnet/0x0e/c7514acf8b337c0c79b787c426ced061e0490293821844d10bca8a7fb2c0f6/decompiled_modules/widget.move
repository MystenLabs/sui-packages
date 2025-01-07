module 0xec7514acf8b337c0c79b787c426ced061e0490293821844d10bca8a7fb2c0f6::widget {
    struct DevNetNFT has store, key {
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

    public fun url(arg0: &DevNetNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: DevNetNFT) {
        let DevNetNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &DevNetNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : DevNetNFT {
        let v0 = DevNetNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        v0
    }

    public fun name(arg0: &DevNetNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut DevNetNFT, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

