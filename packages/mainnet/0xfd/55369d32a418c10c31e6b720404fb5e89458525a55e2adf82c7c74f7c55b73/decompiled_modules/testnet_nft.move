module 0xfd55369d32a418c10c31e6b720404fb5e89458525a55e2adf82c7c74f7c55b73::testnet_nft {
    struct Supply has store, key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    struct TestnetNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: TestnetNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<TestnetNFT>(arg0, arg1);
    }

    public fun url(arg0: &TestnetNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: TestnetNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let TestnetNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &TestnetNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Supply{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Supply>(v0);
    }

    public fun mint(arg0: &mut Supply, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = TestnetNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<TestnetNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<TestnetNFT>(v1, v0);
        arg0.value = arg0.value + 1;
    }

    public fun name(arg0: &TestnetNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut TestnetNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

