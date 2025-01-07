module 0xb0d5816f803ad1dcb7d9d0c5fd5bbad4007860a65d4c1efd7cce74d6bbd3a450::meepo_nft {
    struct Meepo_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Meepo_NFT_MintedEvent has copy, drop {
        id: 0x2::object::ID,
        minted_by: address,
        name: 0x1::string::String,
    }

    public fun delete(arg0: Meepo_NFT) {
        let Meepo_NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun url(arg0: &Meepo_NFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun descripton(arg0: &Meepo_NFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Meepo_NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = Meepo_NFT_MintedEvent{
            id        : 0x2::object::id<Meepo_NFT>(&v0),
            minted_by : 0x2::tx_context::sender(arg3),
            name      : 0x1::string::utf8(arg0),
        };
        0x2::event::emit<Meepo_NFT_MintedEvent>(v1);
        0x2::transfer::public_transfer<Meepo_NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &Meepo_NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun set_url(arg0: &mut Meepo_NFT, arg1: vector<u8>) {
        arg0.url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    // decompiled from Move bytecode v6
}

