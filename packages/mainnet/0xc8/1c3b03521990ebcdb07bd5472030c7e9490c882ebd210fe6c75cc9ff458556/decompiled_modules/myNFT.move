module 0xc81c3b03521990ebcdb07bd5472030c7e9490c882ebd210fe6c75cc9ff458556::myNFT {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        traits: vector<0x1::string::String>,
        url: 0x1::string::String,
    }

    struct MyNFTMinted has copy, drop {
        id: 0x2::object::ID,
        minted_by: address,
    }

    public fun add_trait(arg0: &mut MyNFT, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.traits, arg1);
    }

    public fun destroy(arg0: MyNFT) {
        let MyNFT {
            id     : v0,
            name   : _,
            traits : _,
            url    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = MyNFTMinted{
            id        : 0x2::object::uid_to_inner(&v0),
            minted_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MyNFTMinted>(v1);
        let v2 = MyNFT{
            id     : v0,
            name   : arg0,
            traits : arg2,
            url    : arg1,
        };
        0x2::transfer::public_transfer<MyNFT>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &MyNFT) : 0x1::string::String {
        arg0.name
    }

    public fun set_url(arg0: &mut MyNFT, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    public fun traits(arg0: &MyNFT) : vector<0x1::string::String> {
        arg0.traits
    }

    public fun url(arg0: &MyNFT) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

