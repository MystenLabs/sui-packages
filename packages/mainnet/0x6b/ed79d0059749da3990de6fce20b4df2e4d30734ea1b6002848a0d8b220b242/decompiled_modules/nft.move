module 0x6bed79d0059749da3990de6fce20b4df2e4d30734ea1b6002848a0d8b220b242::nft {
    struct Counter has key {
        id: 0x2::object::UID,
        minted: u64,
    }

    struct HuiSqNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public entry fun transfer(arg0: HuiSqNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<HuiSqNFT>(arg0, arg1);
    }

    public fun url(arg0: &HuiSqNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: HuiSqNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let HuiSqNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &HuiSqNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id     : 0x2::object::new(arg0),
            minted : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public entry fun mint_to_sender(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut Counter, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::string::utf8(b", #");
        0x1::string::append(&mut v1, num_to_string(arg2.minted + 1));
        0x1::string::append_utf8(&mut v1, b" of the HuiSqNFT collection");
        0x1::string::append(&mut arg1, v1);
        let v2 = HuiSqNFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafybeieshsowcu2h45bija22nblvbmnpu76y3s3vjjwm4sfttm2zekh4fi/1.jpg"),
        };
        let v3 = NFTMinted{
            object_id   : 0x2::object::id<HuiSqNFT>(&v2),
            creator     : v0,
            name        : v2.name,
            description : v2.description,
        };
        0x2::event::emit<NFTMinted>(v3);
        arg2.minted = arg2.minted + 1;
        0x2::transfer::public_transfer<HuiSqNFT>(v2, v0);
    }

    public fun name(arg0: &HuiSqNFT) : &0x1::string::String {
        &arg0.name
    }

    fun num_to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            while (arg0 != 0) {
                0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
                arg0 = arg0 / 10;
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun update_description(arg0: &mut HuiSqNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

