module 0x6e639ae87f4383f6f7ffabdbe19696115a399dd99de2e516fe1c8af398528373::guange2015NFT {
    struct DevNetNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
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
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &DevNetNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DevNetNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::public_transfer<DevNetNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &DevNetNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_desc(arg0: &mut DevNetNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public entry fun update_name(arg0: &mut DevNetNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.name = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

