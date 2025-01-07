module 0xe66016777b31d23c7f6163a249772b24c19bcbd2e532013fcbfc422cbcbda384::qpb8023nft {
    struct QPB8023NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        traits: vector<0x1::string::String>,
        url: 0x1::string::String,
    }

    struct QPB8023NFTMinted has copy, drop {
        id: 0x2::object::ID,
        minted_by: address,
    }

    public fun add_trait(arg0: &mut QPB8023NFT, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.traits, arg1);
    }

    public fun destroy(arg0: QPB8023NFT) {
        let QPB8023NFT {
            id     : v0,
            name   : _,
            traits : _,
            url    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = QPB8023NFTMinted{
            id        : 0x2::object::uid_to_inner(&v0),
            minted_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<QPB8023NFTMinted>(v1);
        let v2 = QPB8023NFT{
            id     : v0,
            name   : arg0,
            traits : arg1,
            url    : arg2,
        };
        0x2::transfer::public_transfer<QPB8023NFT>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &QPB8023NFT) : 0x1::string::String {
        arg0.name
    }

    public fun set_url(arg0: &mut QPB8023NFT, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    public fun traits(arg0: &QPB8023NFT) : &vector<0x1::string::String> {
        &arg0.traits
    }

    public fun url(arg0: &QPB8023NFT) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

