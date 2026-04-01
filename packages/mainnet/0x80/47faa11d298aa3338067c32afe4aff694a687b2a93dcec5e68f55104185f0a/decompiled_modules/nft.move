module 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct Attribute has copy, drop, store {
        trait_type: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct GanbiteraNFT has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        uri: 0x2::url::Url,
        creator: address,
        attributes: vector<Attribute>,
    }

    public fun attributes(arg0: &GanbiteraNFT) : vector<Attribute> {
        arg0.attributes
    }

    public fun collection_id(arg0: &GanbiteraNFT) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<GanbiteraNFT> {
        let v0 = 0x2::display::new<GanbiteraNFT>(arg0, arg1);
        0x2::display::add<GanbiteraNFT>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<GanbiteraNFT>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<GanbiteraNFT>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{uri}"));
        0x2::display::update_version<GanbiteraNFT>(&mut v0);
        v0
    }

    public(friend) fun create_nft(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::url::Url, arg5: address, arg6: vector<Attribute>, arg7: &mut 0x2::tx_context::TxContext) : GanbiteraNFT {
        GanbiteraNFT{
            id            : 0x2::object::new(arg7),
            collection_id : arg0,
            token_id      : arg1,
            name          : arg2,
            description   : arg3,
            uri           : arg4,
            creator       : arg5,
            attributes    : arg6,
        }
    }

    public fun creator(arg0: &GanbiteraNFT) : address {
        arg0.creator
    }

    public fun description(arg0: &GanbiteraNFT) : 0x1::string::String {
        arg0.description
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NFT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun name(arg0: &GanbiteraNFT) : 0x1::string::String {
        arg0.name
    }

    public fun new_attribute(arg0: 0x1::string::String, arg1: 0x1::string::String) : Attribute {
        Attribute{
            trait_type : arg0,
            value      : arg1,
        }
    }

    public fun token_id(arg0: &GanbiteraNFT) : u64 {
        arg0.token_id
    }

    public fun token_id_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun uri(arg0: &GanbiteraNFT) : 0x2::url::Url {
        arg0.uri
    }

    // decompiled from Move bytecode v6
}

