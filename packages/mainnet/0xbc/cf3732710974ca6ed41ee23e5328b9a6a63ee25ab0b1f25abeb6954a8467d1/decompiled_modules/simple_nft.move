module 0xbccf3732710974ca6ed41ee23e5328b9a6a63ee25ab0b1f25abeb6954a8467d1::simple_nft {
    struct SimpleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct SIMPLE_NFT has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: SimpleNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SimpleNFT>(arg0, arg1);
    }

    public fun url(arg0: &SimpleNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: SimpleNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let SimpleNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SimpleNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: SIMPLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SIMPLE_NFT>(arg0, arg1);
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = SimpleNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<SimpleNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<SimpleNFT>(v1, v0);
    }

    public fun name(arg0: &SimpleNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut SimpleNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    entry fun update_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new<SimpleNFT>(arg0, arg1);
        0x2::display::add<SimpleNFT>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SimpleNFT>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SimpleNFT>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<SimpleNFT>(&mut v0, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<SimpleNFT>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://suivision.xyz/object/{id}"));
        0x2::display::add<SimpleNFT>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://t.me/suimover"));
        0x2::display::add<SimpleNFT>(&mut v0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Sui Mover"));
        0x2::display::update_version<SimpleNFT>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<SimpleNFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

