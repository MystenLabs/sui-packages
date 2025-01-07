module 0xb44730bac00679ca9babf827d140ad9154dbfd62470bb1f07b61b3a70a1f758b::Kecson_NFT {
    struct KecsonNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        creator: address,
    }

    struct KECSON_NFT has drop {
        dummy_field: bool,
    }

    struct NFTMintedEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct NFTBurnedEvent has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    struct KecsonNftCap has store, key {
        id: 0x2::object::UID,
        current_supply: u64,
        total_supply: u64,
    }

    public entry fun transfer(arg0: KecsonNft, arg1: address) {
        0x2::transfer::public_transfer<KecsonNft>(arg0, arg1);
    }

    public entry fun burn(arg0: KecsonNft, arg1: &mut 0x2::tx_context::TxContext) {
        let KecsonNft {
            id          : v0,
            name        : v1,
            description : _,
            image_url   : _,
            creator     : _,
        } = arg0;
        let v5 = v0;
        let v6 = NFTBurnedEvent{
            object_id : 0x2::object::uid_to_inner(&v5),
            owner     : 0x2::tx_context::sender(arg1),
            name      : v1,
        };
        0x2::event::emit<NFTBurnedEvent>(v6);
        0x2::object::delete(v5);
    }

    public fun creator(arg0: &KecsonNft) : &address {
        &arg0.creator
    }

    public fun description(arg0: &KecsonNft) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &KecsonNft) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: KECSON_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"letsmove task3 Kecson NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<KECSON_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<KecsonNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<KecsonNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<KecsonNft>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v6 = KecsonNftCap{
            id             : 0x2::object::new(arg1),
            current_supply : 0,
            total_supply   : 1000000000,
        };
        0x2::transfer::share_object<KecsonNftCap>(v6);
    }

    public entry fun mint_to(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: &mut KecsonNftCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        arg3.current_supply = arg3.current_supply + 1;
        assert!(arg3.current_supply <= 1000000000, 0);
        let v1 = 0x1::string::utf8(arg0);
        0x1::string::append(&mut v1, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v1, u64_to_string(arg3.current_supply));
        let v2 = KecsonNft{
            id          : 0x2::object::new(arg4),
            name        : v1,
            description : 0x1::string::utf8(b"letsmove task3 Kecson NFT"),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg1),
            creator     : v0,
        };
        let v3 = NFTMintedEvent{
            object_id : 0x2::object::id<KecsonNft>(&v2),
            creator   : v0,
            name      : v2.name,
        };
        0x2::event::emit<NFTMintedEvent>(v3);
        0x2::transfer::public_transfer<KecsonNft>(v2, arg2);
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut KecsonNftCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        mint_to(arg0, arg1, v0, arg2, arg3);
    }

    public fun name(arg0: &KecsonNft) : &0x1::string::String {
        &arg0.name
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
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

    public entry fun update_description(arg0: &mut KecsonNft, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

