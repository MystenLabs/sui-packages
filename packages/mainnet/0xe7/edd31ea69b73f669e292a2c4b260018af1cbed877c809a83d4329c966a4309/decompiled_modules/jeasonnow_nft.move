module 0xe7edd31ea69b73f669e292a2c4b260018af1cbed877c809a83d4329c966a4309::jeasonnow_nft {
    struct JeasonnowNft has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct JeasonnowNftMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: JeasonnowNft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<JeasonnowNft>(arg0, arg1);
    }

    public fun url(arg0: &JeasonnowNft) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: JeasonnowNft, arg1: &mut 0x2::tx_context::TxContext) {
        let JeasonnowNft {
            id          : v0,
            creator     : _,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &JeasonnowNft) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = JeasonnowNft{
            id          : 0x2::object::new(arg3),
            creator     : 0x2::tx_context::sender(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = JeasonnowNftMinted{
            object_id : 0x2::object::id<JeasonnowNft>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<JeasonnowNftMinted>(v1);
        0x2::transfer::public_transfer<JeasonnowNft>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &JeasonnowNft) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut JeasonnowNft, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

