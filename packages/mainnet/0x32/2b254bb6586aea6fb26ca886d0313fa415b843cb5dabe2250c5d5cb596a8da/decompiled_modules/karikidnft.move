module 0x322b254bb6586aea6fb26ca886d0313fa415b843cb5dabe2250c5d5cb596a8da::karikidnft {
    struct KarikidNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct KarikidMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: KarikidNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<KarikidNFT>(arg0, arg1);
    }

    public entry fun burn(arg0: KarikidNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let KarikidNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = KarikidNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = KarikidMinted{
            object_id : 0x2::object::id<KarikidNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<KarikidMinted>(v2);
        0x2::transfer::public_transfer<KarikidNFT>(v1, v0);
    }

    public entry fun update(arg0: &mut KarikidNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

