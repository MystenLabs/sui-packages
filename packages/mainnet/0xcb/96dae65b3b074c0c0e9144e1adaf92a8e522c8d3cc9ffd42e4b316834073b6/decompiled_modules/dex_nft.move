module 0xcb96dae65b3b074c0c0e9144e1adaf92a8e522c8d3cc9ffd42e4b316834073b6::dex_nft {
    struct DexNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct DexNftTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: DexNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<DexNFT>(arg0, arg1);
    }

    public fun url(arg0: &DexNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: DexNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let DexNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &DexNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = DexNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = DexNftTransferEvent{
            object_id : 0x2::object::id<DexNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<DexNftTransferEvent>(v2);
        0x2::transfer::public_transfer<DexNFT>(v1, v0);
    }

    public fun name(arg0: &DexNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut DexNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

